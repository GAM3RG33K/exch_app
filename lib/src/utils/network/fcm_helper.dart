import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:exch_app/src/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:exch_app/src/utils/network/analytics_helper.dart';
import 'package:exch_app/src/utils/application/storage/storage_helper.dart';
import 'package:get_it/get_it.dart';

const String kFcmAppUpdateTopic = 'exch-app-updates';

// Top-level function to handle background messages
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Handling a background message: ${message.messageId}");

  // Log notification event in analytics if needed
  // analyticsHelper.logEvent('notification_received_background', {
  //   'title': message.notification?.title ?? 'No title',
  //   'body': message.notification?.body ?? 'No body',
  // });
}

Future<void> initFCMHelper() async {
  final fcmMessaging = FirebaseMessaging.instance;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final fcmHelper = FCMHelper._(
    fcmMessaging,
    flutterLocalNotificationsPlugin,
  );

  await fcmHelper.init();
  GetIt.instance.registerSingleton<FCMHelper>(
    fcmHelper,
  );
  assert(GetIt.instance.isRegistered<FCMHelper>());
  log('Registered FCM Helper Dependency');
}

FCMHelper get fcmHelper {
  return GetIt.instance.get<FCMHelper>();
}

class FCMHelper {
  final FirebaseMessaging fcmMessaging;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  FCMHelper._(
    this.fcmMessaging,
    this.flutterLocalNotificationsPlugin,
  );

  // Stream controller for handling notification clicks
  final StreamController<RemoteMessage> _notificationClickStreamController =
      StreamController<RemoteMessage>.broadcast();
  Stream<RemoteMessage> get notificationClickStream =>
      _notificationClickStreamController.stream;

  // Initialize FCM
  Future<void> init() async {
    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permission
    await _requestPermission();

    // Initialize local notifications for foreground display
    await _initLocalNotifications();

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification clicks when app is in background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationClick);

    // Check if app was opened from a notification when in terminated state
    await _checkInitialMessage();

    // Save FCM token to local storage and potentially to backend
    await _getFCMToken();

    await subscribeToTopic(kFcmAppUpdateTopic);
    log('FCM Helper initialized');
  }

  // Request notification permission
  Future<void> _requestPermission() async {
    NotificationSettings settings = await fcmMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: false,
      provisional: false,
    );

    log('Notification settings: ${settings.authorizationStatus}');
  }

  // Initialize local notifications plugin
  Future<void> _initLocalNotifications() async {
    // Initialize local notifications
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@drawable/ic_notification');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );

    // Create notification channel for Android
    if (Platform.isAndroid) {
      await _createAndroidNotificationChannel();
    }
  }

  // Create notification channel for Android
  Future<void> _createAndroidNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Handle foreground messages by showing local notification
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    log('Got a message whilst in the foreground!');
    log('Message data: ${message.data}');

    if (message.notification != null) {
      log('Message also contained a notification: ${message.notification?.toMap()}');

      // Show local notification
      await _showLocalNotification(message);

      // Log notification event in analytics
      analyticsHelper?.logEvent(
        type: EventType.remoteMessageReceived,
        parameters: {
          'title': message.notification?.title ?? 'No title',
          'body': message.notification?.body ?? 'No body',
        },
      );
    }
  }

  // Show local notification for foreground messages
  Future<void> _showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null) {
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications',
            importance: Importance.high,
            priority: Priority.high,
            icon: android?.smallIcon ?? '@drawable/ic_notification',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.isNotEmpty ? json.encode(message.data) : "{}",
      );
    }
  }

  // Handle notification response/click for local notifications
  void _onDidReceiveNotificationResponse(NotificationResponse response) {
    log('Local notification clicked: ${response.payload}');
    if (response.payload != null) {
      try {
        final Map<String, dynamic> data = json.decode(response.payload!);
        final RemoteMessage message = RemoteMessage(
          data: data,
          notification: null, // We don't have this information anymore
        );
        _handleNotificationClick(message);
      } catch (e) {
        log('Error parsing notification payload: $e');
      }
    }
  }

  // Handle notification click
  void _handleNotificationClick(RemoteMessage message) {
    log('Notification clicked: ${message.data}');

    // Log notification click event in analytics
    analyticsHelper?.logEvent(
      type: EventType.remoteMessageHandled,
      parameters: {
        'data': message.data.isNotEmpty ? json.encode(message.data) : "{}",
      },
    );
    // Add to stream for app to handle navigation
    _notificationClickStreamController.add(message);
  }

  // Check if app was opened from a notification when in terminated state
  Future<void> _checkInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      log('App opened from terminated state by notification: ${initialMessage.data}');
      _handleNotificationClick(initialMessage);
    }
  }

  // Get and store FCM token
  Future<String?> _getFCMToken() async {
    String? token = await fcmMessaging.getToken();
    if (token != null) {
      log('FCM Token: $token');

      // Save token to local storage
      await storageHelper.storage.setString('fcm_token', token);

      // TODO: Send token to your backend server
      // await apiHelper.sendFCMToken(token);

      // Set up token refresh listener
      fcmMessaging.onTokenRefresh.listen((newToken) {
        log('FCM Token refreshed: $newToken');
        storageHelper.storage.setString('fcm_token', newToken);

        // TODO: Send refreshed token to your backend
        // apiHelper.sendFCMToken(newToken);
      });
    }

    return token;
  }

  // Function to handle topics subscription
  Future<void> subscribeToTopic(String topic) async {
    await fcmMessaging.subscribeToTopic(topic);
    log('Subscribed to topic: $topic');
  }

  // Function to handle topics unsubscription
  Future<void> unsubscribeFromTopic(String topic) async {
    await fcmMessaging.unsubscribeFromTopic(topic);
    log('Unsubscribed from topic: $topic');
  }

  // Clean up
  void dispose() {
    _notificationClickStreamController.close();
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:exch_app/src/utils/network/fcm_helper.dart';
import 'package:get_it/get_it.dart';

Future<void> initDeepLinkHandler(GlobalKey<NavigatorState> navigatorKey) async {
  final deepLinkHandler = DeepLinkHandler._(navigatorKey);
  deepLinkHandler.init();
  GetIt.instance.registerSingleton<DeepLinkHandler>(
    deepLinkHandler,
  );
  assert(GetIt.instance.isRegistered<DeepLinkHandler>());
  log('Registered DeepLinkHandler Dependency');
}

DeepLinkHandler get deepLinkHandler {
  return GetIt.instance.get<DeepLinkHandler>();
}

class DeepLinkHandler {
  final GlobalKey<NavigatorState> navigatorKey;

  DeepLinkHandler._(this.navigatorKey);

  void init() {
    // Listen for notification clicks
    fcmHelper.notificationClickStream.listen(_handleDeepLink);
    log('Deep link handler initialized');
  }

  void _handleDeepLink(RemoteMessage message) {
    log('Handling deep link from notification: ${message.data}');

    // Extract route and parameters from message data
    final String? route = message.data['route'];
    final Map<String, dynamic> params = {};

    // Extract parameters from message data
    message.data.forEach((key, value) {
      if (key != 'route') {
        params[key] = value;
      }
    });

    if (route != null) {
      _navigateToRoute(route, params);
    }
  }

  void _navigateToRoute(String route, Map<String, dynamic> params) {
    final NavigatorState? navigator = navigatorKey.currentState;

    if (navigator != null) {
      switch (route) {
        case 'rates':
          navigator.pushNamed('/rates', arguments: params);
          break;
        case 'currency_details':
          navigator.pushNamed('/currency_details', arguments: params);
          break;
        case 'new_currency':
          navigator.pushNamed('/new_currency');
          break;
        case 'promotions':
          navigator.pushNamed('/promotions', arguments: params);
          break;
        case 'settings':
          navigator.pushNamed('/settings');
          break;
        default:
          // Default action, perhaps go to home
          navigator.pushNamed('/');
          break;
      }
    }
  }
}

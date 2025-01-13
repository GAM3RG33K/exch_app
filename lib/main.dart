// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:exch_app/src/screens/screens.dart';
import 'package:exch_app/src/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart';

void main() {
  runZonedGuarded(
    () async {
      await initializeAppDeependencies();
      runApp(const MyApp());
    },
    (error, stack) {
      if (kReleaseMode) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      } else {
        print('Error: $error');
        print('\nstack: ${stack.toString().split("\n").take(10).join("\n")}');
      }
    },
  );
}

initializeAppDeependencies() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kReleaseMode) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Pass all uncaught errors to Crashlytics
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter
    // framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  log("----------------- FORTIME -----------------");
  await initThemeHelper();
  await initAssetHelper();
  await initStorageHelper();
  await initSystemAccessHelper();
}

ValueNotifier<bool> isAppInitialized = ValueNotifier(false);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final bindingsObserver = AppWidgetsBindingObserver();
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(bindingsObserver);
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(bindingsObserver);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exch ⚡',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      locale: defaultLocale,
      supportedLocales: kSupportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // navigatorObservers: [AppNavigatorObserver()],
      theme: themeHelper.appThemeData,
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: onGenerateRoute,
      color: themeHelper.backgroundColor,
      builder: (context, child) {
        if (!isAppInitialized.value && !context.mediaQueryScreenSize.isEmpty) {
          runPostBuild((timeStamp) {
            context.updateScreenSize();
            themeHelper.updateDynamicFontSizes(context);
          });
          isAppInitialized.value = true;
        }
        return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.noScaling),
            child: SafeArea(child: child!));
      },
    );
  }
}

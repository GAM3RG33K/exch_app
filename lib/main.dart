// ignore_for_file: avoid_print

import 'dart:async';

import 'package:exch_app/src/repositories/rates_repository.dart';
import 'package:exch_app/src/screens/splash_screen.dart';
import 'package:exch_app/src/utils/application/asset_helper.dart';
import 'package:exch_app/src/utils/application/context_helper.dart';
import 'package:exch_app/src/utils/application/routes_helper.dart';
import 'package:exch_app/src/utils/application/storage/storage_helper.dart';
import 'package:exch_app/src/utils/application/system_access_helper.dart';
import 'package:exch_app/src/utils/application/theme_helper.dart';
import 'package:exch_app/src/utils/domain/currency_helper.dart';
import 'package:exch_app/src/utils/localization/localization_helper.dart';
import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:exch_app/src/utils/network/analytics_helper.dart';
import 'package:exch_app/src/utils/network/api_helper.dart';
import 'package:exch_app/src/utils/network/connectivity_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
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
    await initAnalyticsHelper();
  }

  log("----------------- Exch ⚡ -----------------");

  await initThemeHelper();
  await initAssetHelper();
  await initStorageHelper();
  await initConnectivityHelper();
  await initSystemAccessHelper();
  await initApiHelper();
  await initCurrencyHelper();
  await initRatesRepository();
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
    return ShadApp.material(
      title: 'Exch ⚡',
      debugShowCheckedModeBanner: false,
      locale: defaultLocale,
      supportedLocales: kSupportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // navigatorObservers: [AppNavigatorObserver()],
      theme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: ShadGreenColorScheme.dark(
          background: themeHelper.backgroundColor,
        ),
        textTheme: ShadTextTheme(family: 'Ubuntu'),
      ),
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: onGenerateRoute,
      builder: (context, child) {
        if (!isAppInitialized.value && !context.mediaQueryScreenSize.isEmpty) {
          runPostBuild((timeStamp) {
            context.updateScreenSize();
          });
          isAppInitialized.value = true;
        }
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: SafeArea(child: child!),
        );
      },
    );
  }
}

import 'package:exch_app/src/screens/converter/currency_selection_page.dart';
import 'package:exch_app/src/screens/home_page.dart';
import 'package:exch_app/src/screens/splash_screen.dart';
import 'package:flutter/material.dart';

RouteFactory onGenerateRoute = (settings) {
  if (settings.name == SplashScreen.routeName) {
    return _buildRoute(settings, (ctx) => const SplashScreen());
  }

  // if (settings.name == IntroScreen.routeName) {
  //   return _buildRoute(settings, (ctx) => const IntroScreen());
  // }

  if (settings.name == CurrencySelectionPage.routeName) {
    return _buildRoute<String>(
      settings,
      (ctx) => CurrencySelectionPage.fromRouteArguments(
        settings.arguments as Map<String, dynamic>,
      ),
    );
  }

  return _buildRoute(settings, (ctx) => const HomePage());
};

MaterialPageRoute _buildRoute<T>(RouteSettings settings, WidgetBuilder builder) {
  return MaterialPageRoute<T>(
    settings: settings,
    builder: builder,
  );
}

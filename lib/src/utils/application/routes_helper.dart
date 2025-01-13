import 'package:flutter/material.dart';
import 'package:exch_app/src/screens/screens.dart';

RouteFactory onGenerateRoute = (settings) {
  if (settings.name == SplashScreen.routeName) {
    return _buildRoute(settings, (ctx) => const SplashScreen());
  }

  // if (settings.name == IntroScreen.routeName) {
  //   return _buildRoute(settings, (ctx) => const IntroScreen());
  // }

  if (settings.name == SettingsPage.routeName) {
    return _buildRoute(settings, (ctx) => const SettingsPage());
  }

  return _buildRoute(settings, (ctx) => const HomePage());
};

MaterialPageRoute _buildRoute(RouteSettings settings, WidgetBuilder builder) {
  return MaterialPageRoute(
    settings: settings,
    builder: builder,
  );
}

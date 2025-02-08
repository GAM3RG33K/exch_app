import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Future<void> initThemeHelper() async {
  GetIt.instance.registerSingleton<ThemeHelper>(
    ThemeHelper._(),
  );
  assert(GetIt.instance.isRegistered<ThemeHelper>());
  log('Registered Theme Helper Dependency');
}

ThemeHelper get themeHelper => GetIt.instance.get<ThemeHelper>();

class ThemeHelper {
  ThemeHelper._();

  Color get primaryColor => const Color.fromARGB(255, 118, 255, 168);
  Color get secondaryColor => const Color.fromARGB(255, 255, 101, 101);
  Color get backgroundColor => Colors.black;
  Color get backgroundColor2 => const Color.fromARGB(255, 22, 22, 22);
  Color get backgroundColor3 => Colors.white;

  Color get fontColor1 => Colors.white;
  Color get fontColor1Muted => Colors.white30;
  Color get fontColor2 => const Color.fromARGB(255, 255, 101, 101);
  Color get fontColor3 => const Color.fromARGB(255, 118, 255, 168);
  Color get fontColor4 => Colors.blueAccent;
  Color get fontColor5 => Colors.black;
  Color get fontColorDisabled => const Color(0xFF30393D);

  List<Color> get loaderColors => [
        backgroundColor3,
        primaryColor,
        backgroundColor3,
        primaryColor,
      ];
}

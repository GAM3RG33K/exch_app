import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:exch_app/src/utils/utils.dart';

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

  double _titleFontSize = 32;
  double _subtitleFontSize = 16;
  double _bodyTextFontSize = 12;


  double get titleFontSize => _titleFontSize;
  double get subtitleFontSize => _subtitleFontSize;
  double get bodyFontSize => _bodyTextFontSize;

  void updateDynamicFontSizes(BuildContext context) {
    // log('unit width: ${context.uWidth}');
    // log('unit height: ${context.uHeight}');

    double newTitleFontSize = context.uWidth * 8;
    double newSubtitleFontSize = context.uWidth * 4;
    double newBodyTextFontSize = context.uWidth * 5;

    if (context.isTablet) {
      newTitleFontSize = context.uWidth * 4;
      newSubtitleFontSize = context.uWidth * 2.5;
      newBodyTextFontSize = context.uWidth * 3;
    }

    _titleFontSize = newTitleFontSize;
    _subtitleFontSize = newSubtitleFontSize;
    _bodyTextFontSize = newBodyTextFontSize;
  }

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
        primaryColor,
        secondaryColor,
        primaryColor,
        secondaryColor,
      ];

  ThemeData get appThemeData => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
            centerTitle: false, backgroundColor: Colors.transparent),
      );

  TextStyle get titleTextStyle =>
      TextStyle(color: fontColor1, fontSize: titleFontSize);
  TextStyle get subtitleTextStyle =>
      TextStyle(color: fontColor1, fontSize: subtitleFontSize);
  TextStyle get bodyTextStyle =>
      TextStyle(color: fontColor1, fontSize: bodyFontSize);


  TextStyle get alertTitleTextStyle => TextStyle(
        fontSize: bodyFontSize,
        fontWeight: FontWeight.bold,
        color: fontColor5,
      );

  TextStyle get alertContentTextStyle => TextStyle(
        fontSize: bodyFontSize,
        color: fontColor5,
      );
}

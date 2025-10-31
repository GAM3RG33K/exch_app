import 'package:exch_app/l10n/app_localizations.dart';
import 'package:exch_app/src/utils/application/system_access_helper.dart';
import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:exch_app/src/constants.dart';

extension WidgetExtension on State {
  BuildContext? get safeContext {
    if (!mounted) return null;
    return context;
  }

  void runPostBuild(FrameCallback fn) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (safeContext == null) return;
      fn(timeStamp);
    });
  }
}

extension BuildContextExtension on BuildContext {
  AppLocalizations? get l10n {
    return AppLocalizations.of(this);
  }
}

void addPostFrameCallback(FrameCallback fn) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    fn(timeStamp);
  });
}

bool checkIfTablet(Size size) => size.shortestSide >= kMinTabletSize;

Size _screenSize = const Size(400, 600);

extension ContextExtension on BuildContext {
  Size get mediaQueryScreenSize {
    final mediaQuery = MediaQuery.of(this);
    var screenSize = mediaQuery.size;
    return screenSize;
  }

  void updateScreenSize() {
    final mediaQuery = MediaQuery.of(this);
    var screenSize = mediaQueryScreenSize;

    log("Context Screensize: $screenSize");
    if (mediaQuery.orientation == Orientation.landscape) {
      screenSize = screenSize.flipped;
    }

    // Effective Height = Visual space available without camera cut and bottom bar
    //
    // Technically this space should be [kToolbarHeight] & [kBottomNavigationBarHeight]
    // Which is 56 + 56 = 112 pixels
    // But actually the Space we need is much less than that which is [kToolbarSpacingInPixels]
    //
    final effectiveHeight = screenSize.height - kToolbarSpacingInPixels;
    screenSize = Size(
      screenSize.width,
      effectiveHeight,
    );
    _screenSize = screenSize;

    log("Final Screensize: $_screenSize");
  }

  Size get screenSize => _screenSize;

  bool get isTablet => checkIfTablet(screenSize);

  bool get isIpad => isTablet && systemAccessHelper.isIOS;

  double get screenWidth {
    return screenSize.width;
  }

  double get screenHeight {
    return screenSize.height;
  }

  double get uWidth {
    return screenWidth * 0.01;
  }

  double get uHeight {
    return screenHeight * 0.01;
  }

  // App Layouts
  double get valuePickerHeight {
    return uWidth * 44;
  }

  double get valuePickerSingleDigit {
    if (isTablet) return uHeight * 15;
    return uHeight * 14;
  }

  double get valuePickerDoubleDigit {
    if (isTablet) return uHeight * 30;
    return uHeight * 28;
  }

  double get valuePickerIconSize {
    if (isTablet) return uWidth * 8;
    return uWidth * 10;
  }

  double get fabIconSize {
    if (isTablet) return uWidth * 6;
    return uWidth * 8;
  }

  double get actionIconSize => uWidth * 8;

  double get infoIconSize => uWidth * 16;

  double get bottomToolbarHeight => uWidth * 12;

  double get cardHeight => uHeight * 28;

  double get cardLandscapeHeight => uHeight * 24;
}

abstract class ResponsiveStatelessWidget extends StatelessWidget {
  const ResponsiveStatelessWidget({super.key});

  @override
  @protected
  Widget build(BuildContext context) {
    return context.isTablet ? buildTablet(context) : buildMobile(context);
  }

  /// Must implement this method to layout widget on mobile screen
  Widget buildMobile(BuildContext context);

  /// Must implement this method to layout widget on tablet screen
  Widget buildTablet(BuildContext context);
}

abstract class ResponsiveState<T extends StatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return context.isTablet ? buildTablet(context) : buildMobile(context);
  }

  /// Must implement this method to layout widget on mobile screen
  Widget buildMobile(BuildContext context);

  /// Must implement this method to layout widget on tablet screen
  Widget buildTablet(BuildContext context);
}

extension PageControllerExtension on PageController {
  void safeJumpToPage(int page) {
    if (!hasClients ||
        (!position.hasContentDimensions || position.viewportDimension <= 0)) {
      return;
    }
    jumpToPage(page);
  }
}

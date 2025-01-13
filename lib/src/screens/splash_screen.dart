import 'package:flutter/material.dart';
import 'package:exch_app/src/components/components.dart';
import 'package:exch_app/src/screens/screens.dart';
import 'package:exch_app/src/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = r'\';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ResponsiveState<SplashScreen> {
  Future<void> initialization() async {
    await forceOrientation(portait: true);
    await startTimer();
  }

  Future<void> startTimer() async {
    await Future.delayed(const Duration(seconds: 5));

    if (safeContext != null) {
      // Check if this a first run
      final storage = storageHelper;
      if (!storage.isFirstRunHandled) {
        storage.isFirstRunHandled = true;
        // Navigator.of(safeContext!).pushReplacementNamed(IntroPage.routeName);
        // return;
      }
      Navigator.of(safeContext!).pushReplacementNamed(HomePage.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  @override
  Widget buildMobile(BuildContext context) {
    return Scaffold(
      backgroundColor: themeHelper.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(assetHelper.kLogo, width: 250, height: 250),
            const Center(
              child: SmallLoader(
                padding: EdgeInsets.all(48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTablet(BuildContext context) {
    return Scaffold(
      backgroundColor: themeHelper.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(assetHelper.kLogo, width: 640, height: 640),
            const Center(
              child: SmallLoader(
                padding: EdgeInsets.all(48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

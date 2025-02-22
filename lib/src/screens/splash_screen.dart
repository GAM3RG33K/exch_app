import 'package:exch_app/src/repositories/rates_repository.dart';
import 'package:exch_app/src/screens/home_page.dart';
import 'package:exch_app/src/utils/application/asset_helper.dart';
import 'package:exch_app/src/utils/application/context_helper.dart';
import 'package:exch_app/src/utils/application/orientation_helper.dart';
import 'package:exch_app/src/utils/application/storage/storage_helper.dart';
import 'package:exch_app/src/utils/application/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:exch_app/src/components/components.dart';

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
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    await ratesRepository.fetchCurrencyRates(
      errorString: context.l10n!.repo_error_message,
      onlyCached: true,
    );

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
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTablet(BuildContext context) {
    return Scaffold(
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

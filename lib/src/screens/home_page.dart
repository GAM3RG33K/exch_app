import 'package:exch_app/src/components/home/error.dart';
import 'package:exch_app/src/components/home/fetching_rates_loader.dart';
import 'package:exch_app/src/repositories/rates_repository.dart';
import 'package:exch_app/src/components/home/oops.dart';
import 'package:exch_app/src/screens/converter/converter_ui.dart';
import 'package:exch_app/src/screens/settings_page.dart';
import 'package:exch_app/src/utils/application/context_helper.dart';
import 'package:exch_app/src/utils/application/orientation_helper.dart';
import 'package:exch_app/src/utils/application/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:exch_app/src/constants.dart';

class HomePage extends StatefulWidget {
  static const routeName = r'\home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ResponsiveState<HomePage> {
  Future<void> initialization() async {
    await forceOrientation(portait: true, landscape: true);
  }

  @override
  void initState() {
    initialization();
    super.initState();
  }

  @override
  void dispose() {
    forceOrientation(portait: true, landscape: true);
    super.dispose();
  }

  @override
  Widget buildTablet(BuildContext context) {
    return buildMobile(context);
  }

  @override
  Widget buildMobile(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          kAppName.toUpperCase(),
          style: themeHelper.titleTextStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SettingsPage.routeName);
              },
              icon: Icon(
                Icons.settings,
                size: 32,
                color: themeHelper.fontColor1,
              )),
        ],
        backgroundColor: themeHelper.backgroundColor,
      ),
      backgroundColor: themeHelper.backgroundColor2,
      body: Center(
        child: FutureBuilder<RepoResponse?>(
          future: ratesRepository.fetchCurrencyRates(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final data = snapshot.data;
              if (data == null) {
                return const OopsScreen();
              }
              if (data.error != null) {
                return ErrorScreen(
                  error: data.error!,
                );
              }
              return ConverterUI(latestRates: data.data);
            }
            return const FetchingRatesLoader();
          },
        ),
      ),
    );
  }
}

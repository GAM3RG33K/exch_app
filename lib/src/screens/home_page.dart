import 'package:exch_app/src/components/home/error.dart';
import 'package:exch_app/src/components/home/fetching_rates_loader.dart';
import 'package:exch_app/src/models/api/rates_data.dart';
import 'package:exch_app/src/repositories/rates_repository.dart';
import 'package:exch_app/src/components/home/oops.dart';
import 'package:exch_app/src/screens/converter/converter_ui.dart';
import 'package:exch_app/src/utils/application/context_helper.dart';
import 'package:exch_app/src/utils/application/orientation_helper.dart';
import 'package:exch_app/src/utils/application/system_access_helper.dart';
import 'package:exch_app/src/utils/application/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:exch_app/src/constants.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
          kAppName,
          style: ShadTheme.of(context).textTheme.h3,
        ),
        centerTitle: true,
        backgroundColor: themeHelper.backgroundColor,
        actions: const [
          // IconButton(
          //     onPressed: () {
          //       Navigator.of(context).pushNamed(SettingsPage.routeName);
          //     },
          //     icon: const Icon(
          //       Icons.settings,
          //       size: 32,
          //     )),
        ],
      ),
      backgroundColor: themeHelper.backgroundColor2,
      body: Center(
        child: FutureBuilder<RepoResponse<RatesData>?>(
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
              return _buildHomeUI(context, data);
            }
            return const FetchingRatesLoader();
          },
        ),
      ),
    );
  }

  Widget _buildHomeUI(
    BuildContext context,
    RepoResponse<RatesData> data,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: themeHelper.backgroundColor2,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConverterUI(latestRates: data.data!),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => systemAccessHelper.openSite(
                    website: kWebsite,
                  ),
                  child: Text(
                    "© 2025 $kAppName",
                    style: ShadTheme.of(context).textTheme.small.copyWith(
                          color: themeHelper.fontColor1,
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Built by ",
                      style: ShadTheme.of(context).textTheme.small.copyWith(
                            color: themeHelper.fontColor1,
                          ),
                    ),
                    GestureDetector(
                      onTap: () => systemAccessHelper.openSite(
                        website: kShopWebsite,
                      ),
                      child: Text(
                        "Harshvardhan Joshi",
                        style: ShadTheme.of(context).textTheme.small.copyWith(
                              color: Colors.blue,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Contact me at: ",
                      style: ShadTheme.of(context).textTheme.small.copyWith(
                            color: themeHelper.fontColor1,
                          ),
                    ),
                    GestureDetector(
                      onTap: () => systemAccessHelper.openEmailClient(
                        title: 'Reaching Out',
                      ),
                      child: Text(
                        "contact@harshjoshi.dev",
                        style: ShadTheme.of(context).textTheme.small.copyWith(
                              color: Colors.blue,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Build: ",
                      style: ShadTheme.of(context).textTheme.small.copyWith(
                            color: themeHelper.fontColor1,
                          ),
                    ),
                    Text(
                      systemAccessHelper.appBuildInfo,
                      style: ShadTheme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

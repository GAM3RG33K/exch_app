import 'package:flutter/material.dart';
import 'package:exch_app/src/constants.dart';
import 'package:exch_app/src/screens/screens.dart';
import 'package:exch_app/src/utils/utils.dart';

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
        child: Center(
          child: Text(
            kAppName,
            style: themeHelper.titleTextStyle,
          ),
        ),
      ),
    );
  }
}

import 'package:exch_app/src/utils/application/context_helper.dart';
import 'package:exch_app/src/utils/application/system_access_helper.dart';
import 'package:exch_app/src/utils/application/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:exch_app/src/constants.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = r'\settings';

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n!.settings_title,
          style: themeHelper.titleTextStyle,
        ),
        backgroundColor: themeHelper.backgroundColor,
      ),
      backgroundColor: themeHelper.backgroundColor2,
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: ListView(
            children: [
              Text(
                context.l10n!.settings_option_title_contact,
                style: themeHelper.titleTextStyle.copyWith(
                  color: themeHelper.fontColor1,
                ),
              ),
              Divider(
                color: themeHelper.fontColor1,
              ),
              ListTile(
                onTap: () => systemAccessHelper.openEmailClient(
                  title: 'Requesting Support',
                ),
                title: Text(
                  context.l10n!.settings_option_title_contact_support_email,
                  style: themeHelper.bodyTextStyle.copyWith(
                    color: themeHelper.fontColor1,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: themeHelper.primaryColor,
                ),
              ),
              ListTile(
                onTap: () => systemAccessHelper.openEmailClient(
                  title: 'Requesting Feature',
                ),
                title: Text(
                  context.l10n!.settings_option_title_contact_feature_request,
                  style: themeHelper.bodyTextStyle.copyWith(
                    color: themeHelper.fontColor1,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: themeHelper.primaryColor,
                ),
              ),
              SizedBox(
                height: context.uHeight * 4,
              ),
              Text(
                context.l10n!.settings_option_title_about,
                style: themeHelper.titleTextStyle.copyWith(
                  color: themeHelper.fontColor1,
                ),
              ),
              Divider(
                color: themeHelper.fontColor1,
              ),
              ListTile(
                onTap: () => systemAccessHelper.openSite(
                  website: kWebsite,
                ),
                title: Text(
                  context.l10n!.settings_option_title_about_site,
                  style: themeHelper.bodyTextStyle.copyWith(
                    color: themeHelper.fontColor1,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: themeHelper.primaryColor,
                ),
              ),
              ListTile(
                title: Text(
                  context.l10n!.settings_option_title_about_build,
                  style: themeHelper.bodyTextStyle.copyWith(
                    color: themeHelper.fontColor1,
                  ),
                ),
                subtitle: Text(
                  systemAccessHelper.appBuildInfo,
                  style: themeHelper.subtitleTextStyle.copyWith(
                    color: themeHelper.fontColor1,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

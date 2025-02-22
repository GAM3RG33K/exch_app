import 'dart:io';

import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:exch_app/src/utils/notification/notification_helper.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:exch_app/src/constants.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> initSystemAccessHelper() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  GetIt.instance.registerSingleton<SystemAccessHelper>(
    SystemAccessHelper._(
      packageName,
      version,
      buildNumber,
    ),
  );
  assert(GetIt.instance.isRegistered<SystemAccessHelper>());
  log('Registered Asset Helper Dependency');
}

SystemAccessHelper get systemAccessHelper =>
    GetIt.instance.get<SystemAccessHelper>();

class SystemAccessHelper {
  final String packageName;
  final String version;
  final String buildNumber;

  SystemAccessHelper._(
    this.packageName,
    this.version,
    this.buildNumber,
  );

  bool get hasEnabledLogging => const bool.fromEnvironment(
        'ENABLE_LOGS',
        defaultValue: false,
      );

  String get appBuildInfo => "$version($buildNumber)";

  bool get isAndroid => Platform.isAndroid;

  bool get isIOS => Platform.isIOS;

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<bool> openEmailClient({
    String to = kSupportEmail,
    String? title,
    String? body,
  }) async {
    final emailUri = Uri(
        scheme: 'mailto',
        path: to,
        query: encodeQueryParameters({
          'subject': title ?? "",
          "body": body ?? "",
        }));

    // final canLaunch = await canLaunchUrl(emailUri);

    // if (!canLaunch) {
    //   showShortToast('Unable to open Email client on this device');
    //   return false;
    // }

    try {
      log('Email uri: $emailUri');
      return launchUrl(emailUri);
    } catch (ex) {
      showShortToast('Unable to open Email client on this device');
      return false;
    }
  }

  Future<bool> openSite({
    required String website,
  }) async {
    final url = Uri.parse(website);
    return launchUrl(url, mode: LaunchMode.inAppBrowserView);
  }

  Future<void> copyDataToClipboard(String data) {
    return Clipboard.setData(ClipboardData(text: data));
  }
}

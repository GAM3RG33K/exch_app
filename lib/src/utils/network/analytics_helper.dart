import 'package:exch_app/src/constants.dart';
import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

Future<void> initAnalyticsHelper() async {
  final analyticsHelper = AnalyticsHelper._(FirebaseAnalytics.instance);
  GetIt.instance.registerSingleton<AnalyticsHelper>(
    analyticsHelper,
  );
  assert(GetIt.instance.isRegistered<AnalyticsHelper>());
  log('Registered Api Helper Dependency');
}

AnalyticsHelper? get analyticsHelper {
  if (!kReleaseMode) return null;
  return GetIt.instance.get<AnalyticsHelper>();
}

class AnalyticsHelper {
  final FirebaseAnalytics firebaseAnalytics;
  AnalyticsHelper._(this.firebaseAnalytics);

  void defaultErrorCatcher(error) {
    FirebaseCrashlytics.instance.recordError(error, StackTrace.current);
    return;
  }

  Future<void> logEvent({
    required EventType type,
    Json? parameters,
  }) async {
    if (!kReleaseMode) return;
    return FirebaseAnalytics.instance
        .logEvent(
          name: type.name,
          parameters: parameters?.cast<String, Object>(),
        )
        .catchError(defaultErrorCatcher);
  }

  Future<void> logSelectCurrency({
    required CurrencyPosition position,
    required String abbr,
  }) async {
    if (!kReleaseMode) return;
    return FirebaseAnalytics.instance.logSelectContent(
        contentType: EventType.selectCurrency.name,
        itemId: abbr,
        parameters: <String, Object>{
          'position': position.name,
        }).catchError(defaultErrorCatcher);
  }

  Future<void> logSwapCurrency({
    required String initialFrom,
    required String initialTo,
  }) async {
    if (!kReleaseMode) return;
    return logEvent(type: EventType.swapCurrency, parameters: <String, Object>{
      'initialFrom': initialFrom,
      'initialTo': initialTo,
    }).catchError(defaultErrorCatcher);
  }

  Future<void> logConvert({
    required String from,
    required String to,
  }) async {
    if (!kReleaseMode) return;
    return logEvent(type: EventType.convert, parameters: <String, Object>{
      'from': from,
      'to': to,
    }).catchError(defaultErrorCatcher);
  }

  Future<void> logFetchRates() async {
    if (!kReleaseMode) return;
    return logEvent(
      type: EventType.fetchRates,
    ).catchError(defaultErrorCatcher);
  }


  Future<void> logWebsiteAccess() async {
    if (!kReleaseMode) return;
    return logEvent(
      type: EventType.websiteAccess,
    ).catchError(defaultErrorCatcher);
  }


  Future<void> logEmailAccess() async {
    if (!kReleaseMode) return;
    return logEvent(
      type: EventType.emailAccess,
    ).catchError(defaultErrorCatcher);
  }

    Future<void> logDataCopied() async {
    if (!kReleaseMode) return;
    return logEvent(
      type: EventType.copied,
    ).catchError(defaultErrorCatcher);
  }
}

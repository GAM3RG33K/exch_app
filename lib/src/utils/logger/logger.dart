// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:exch_app/src/utils/utils.dart';
import 'dart:developer' as developer;
// import 'package:flutter/material.dart';

String printStackTrace({
  StackTrace? trace,
  int take = 5,
  int skip = 1,
  String? title,
}) {
  String traceString = getPrintableStackTrace(
    take: take,
    trace: trace,
    skip: skip,
  );
  traceString = "$title\n$traceString";
  log(traceString);
  return traceString;
}

String getPrintableStackTrace({
  StackTrace? trace,
  int take = 5,
  int skip = 1,
}) {
  trace ??= StackTrace.current;
  final stackTraceList = trace.toString().split("\n");
  final traceList = stackTraceList.skip(skip).take(take);
  final result = traceList.join("\n");
  return result;
}

Future<T> measureLog<T>({
  required String title,
  required Future<T> Function() process,
}) {
  return Future.microtask(
    () {
      log('$title beings @${DateTime.now().toIso8601String()}');
    },
  ).then(
    (value) {
      return process();
    },
  ).whenComplete(
    () {
      log('$title ends @${DateTime.now().toIso8601String()}');
    },
  );
}

void log(
  String message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  String name = '',
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  if (!GetIt.instance.isRegistered<SystemAccessHelper>()) return;

  // Always print logs using developer package when in debug mode
  if (kDebugMode) {
    return developer.log(
      message,
      time: time,
      sequenceNumber: sequenceNumber,
      level: level,
      name: name,
      zone: zone,
      error: error,
      stackTrace: stackTrace,
    );
  } else {
    // Check if the app has ENABLE_LOGS flag while running/buiding apps
    if (!systemAccessHelper.hasEnabledLogging) return;
    return print(message);
  }
}

// class AppNavigatorObserver extends NavigatorObserver {
//   @override
//   void didPush(Route route, Route? previousRoute) {
//     log('didPush: Screen navigated to: ${route.settings.name}');
//     super.didPush(route, previousRoute);
//   }

//   @override
//   void didPop(Route route, Route? previousRoute) {
//     if (previousRoute != null) {
//       log('didPop: Screen navigated away from: ${previousRoute.settings.name}');
//     }
//     super.didPop(route, previousRoute);
//   }

//   @override
//   void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
//     log('didReplace: Screen replaced: ${newRoute?.settings.name} (old route: ${oldRoute?.settings.name})');
//     super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
//   }
// }

// class AppWidgetsBindingObserver extends WidgetsBindingObserver {
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);

//     switch (state) {
//       case AppLifecycleState.paused:
//         log('App is paused');
//         break;
//       case AppLifecycleState.resumed:
//         log('App is resumed');
//         break;
//       default:
//         break;
//     }
//   }

//   @override
//   void didChangePlatformBrightness() {
//     super.didChangePlatformBrightness();
//     // You can add additional logic here to update theme if necessary
//   }
// }

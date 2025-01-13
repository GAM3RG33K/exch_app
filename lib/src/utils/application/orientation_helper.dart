import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> forceOrientation({
  bool portait = false,
  bool landscape = false,
}) async {
  if (!portait && !landscape) return;

  final orientations = <DeviceOrientation>[];

  if (portait) {
    orientations
        .addAll([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  if (landscape) {
    orientations.addAll(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  return SystemChrome.setPreferredOrientations(orientations);
}

extension OrientationExtension on BuildContext {
  Orientation get orientation => MediaQuery.of(this).orientation;
}

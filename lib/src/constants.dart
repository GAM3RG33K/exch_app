// Custom Type definitions
import 'package:flutter/material.dart';

typedef Json = Map<String, dynamic>;

typedef ItemWidgetBuilder<T> = Widget Function(
    BuildContext context, T value, T? previousValue);

typedef ItemValueChange<T> = void Function(T value, T previousValue);
typedef IndexedValueChange<T> = void Function(int index, T value);

// Storage keys

const String keyType = 'type';

// General constants
const String kAppName = 'Exch ⚡';
const String kWebsite = 'https://harshjoshi.dev';
const String kShopWebsite = 'https://harshjoshi.dev';
const String kWebSiteFAQ = '$kWebsite/faq';
const String kSupportEmail = 'contact@harshjoshi.dev';

// Preference Keys
const String kPrefKeyIsFirstRun = 'isFirstRun';

// App Layouts
const double kMinTabletSize = 600;
const double kDefaultChildAspectRatio = 14 / 10;
const double kChildAspectRatioTabletLandscape = 21 / 9;
const double kChildAspectRatioTabletSoundDemo = 4 / 3;
const kToolbarSpacingInPixels = 88.0;

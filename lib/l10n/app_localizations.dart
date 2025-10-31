import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @intro_msg_1.
  ///
  /// In en, this message translates to:
  /// **'A modern currency converter built with love for '**
  String get intro_msg_1;

  /// No description provided for @intro_caption_1.
  ///
  /// In en, this message translates to:
  /// **'Exch ⚡'**
  String get intro_caption_1;

  /// No description provided for @close_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get close_confirmation;

  /// No description provided for @close_msg.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get close_msg;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @why.
  ///
  /// In en, this message translates to:
  /// **'Why'**
  String get why;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @alert_title.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get alert_title;

  /// No description provided for @alert_msg.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get alert_msg;

  /// No description provided for @configure.
  ///
  /// In en, this message translates to:
  /// **'Configure'**
  String get configure;

  /// No description provided for @converter_exchange_rate.
  ///
  /// In en, this message translates to:
  /// **'1 {fromCurrency} = {exchangeRate} {toCurrency}'**
  String converter_exchange_rate(
      String fromCurrency, String exchangeRate, String toCurrency);

  /// No description provided for @converter_last_updated.
  ///
  /// In en, this message translates to:
  /// **'Updated: {date}'**
  String converter_last_updated(String date);

  /// No description provided for @converter_loading_message.
  ///
  /// In en, this message translates to:
  /// **'Crunching numbers at light speed'**
  String get converter_loading_message;

  /// No description provided for @converter_loading_submessage.
  ///
  /// In en, this message translates to:
  /// **'Hold tight while we fetch the latest rates'**
  String get converter_loading_submessage;

  /// No description provided for @converter_na.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get converter_na;

  /// No description provided for @oops_message.
  ///
  /// In en, this message translates to:
  /// **'Oops! Looks like we\'re drawing a blank here'**
  String get oops_message;

  /// No description provided for @oops_submessage.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry, it happens to the best of us'**
  String get oops_submessage;

  /// No description provided for @error_message.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get error_message;

  /// No description provided for @error_submessage.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry, We are looking into it'**
  String get error_submessage;

  /// No description provided for @error_reason.
  ///
  /// In en, this message translates to:
  /// **'Reason: \n{error}'**
  String error_reason(String error);

  /// No description provided for @home_copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2025 {appName}'**
  String home_copyright(String appName);

  /// No description provided for @home_built_by.
  ///
  /// In en, this message translates to:
  /// **'Built by '**
  String get home_built_by;

  /// No description provided for @home_contact_at.
  ///
  /// In en, this message translates to:
  /// **'Contact: '**
  String get home_contact_at;

  /// No description provided for @home_build.
  ///
  /// In en, this message translates to:
  /// **'Build: '**
  String get home_build;

  /// No description provided for @repo_error_message.
  ///
  /// In en, this message translates to:
  /// **'Please check internet and try again!'**
  String get repo_error_message;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

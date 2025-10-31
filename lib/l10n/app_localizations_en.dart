// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get intro_msg_1 => 'A modern currency converter built with love for ';

  @override
  String get intro_caption_1 => 'Exch ⚡';

  @override
  String get close_confirmation => 'Confirmation';

  @override
  String get close_msg => 'Are you sure?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get why => 'Why';

  @override
  String get done => 'Done';

  @override
  String get copy => 'Copy';

  @override
  String get share => 'Share';

  @override
  String get alert_title => 'Alert';

  @override
  String get alert_msg => 'Something went wrong!';

  @override
  String get configure => 'Configure';

  @override
  String converter_exchange_rate(
      String fromCurrency, String exchangeRate, String toCurrency) {
    return '1 $fromCurrency = $exchangeRate $toCurrency';
  }

  @override
  String converter_last_updated(String date) {
    return 'Updated: $date';
  }

  @override
  String get converter_loading_message => 'Crunching numbers at light speed';

  @override
  String get converter_loading_submessage =>
      'Hold tight while we fetch the latest rates';

  @override
  String get converter_na => 'N/A';

  @override
  String get oops_message => 'Oops! Looks like we\'re drawing a blank here';

  @override
  String get oops_submessage => 'Don\'t worry, it happens to the best of us';

  @override
  String get error_message => 'Something went wrong!';

  @override
  String get error_submessage => 'Don\'t worry, We are looking into it';

  @override
  String error_reason(String error) {
    return 'Reason: \n$error';
  }

  @override
  String home_copyright(String appName) {
    return '© 2025 $appName';
  }

  @override
  String get home_built_by => 'Built by ';

  @override
  String get home_contact_at => 'Contact: ';

  @override
  String get home_build => 'Build: ';

  @override
  String get repo_error_message => 'Please check internet and try again!';
}

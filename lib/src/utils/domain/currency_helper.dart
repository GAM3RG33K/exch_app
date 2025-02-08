import 'package:exch_app/src/models/currency.dart';
import 'package:exch_app/src/utils/domain/currencies.dart';
import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:get_it/get_it.dart';

Future<void> initCurrencyHelper() async {
  GetIt.instance.registerSingleton<CurrencyHelper>(
    CurrencyHelper._(),
  );
  assert(GetIt.instance.isRegistered<CurrencyHelper>());
  log('Registered Currency Helper Dependency');
}

CurrencyHelper get currencyHelper => GetIt.instance.get<CurrencyHelper>();

class CurrencyHelper {
  CurrencyHelper._();
  String get imagesFolder => 'assets/images';

// Image Assets
  String get kLogo => '$imagesFolder/logo.png';
  String get kLogoSvg => '$imagesFolder/logo.svg';

  num getExchange(Currency fromCurrency, Currency toCurrency) {
    log("getExchange: ${fromCurrency.abbr}: ${toCurrency.abbr}");
    final fromRate = fromCurrency.rate;
    final toRate = toCurrency.rate;

    log("getExchange: ${1 * (toRate / fromRate)}");
    return 1 * (toRate / fromRate);
  }
}

extension CurrencyString on String? {

  bool get isValidCurrencyAbbr {
    if (this == null) return false;
    return currencyNameMap[this] != null && currencySymbolMap[this] != null;
  }

  String? get currencyName {
    if (this == null) return null;
    return currencyNameMap[this];
  }

  String? get symbol {
    if (this == null) return null;
    return currencySymbolMap[this];
  }
}

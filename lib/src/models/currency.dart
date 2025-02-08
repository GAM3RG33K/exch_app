import 'package:exch_app/src/utils/domain/currency_helper.dart';

class Currency {
  final String name;
  final String symbol;
  final String abbr;

  // All rates set are compared to USD
  final num rate;

  Currency({
    required this.name,
    required this.symbol,
    required this.abbr,
    required this.rate,
  });

  factory Currency.fromAbbr({
    required String abbr,
    required num rate,
  }) {
    assert(abbr.isNotEmpty, "Abbr value cannot be empty");
    return Currency(
      name: abbr.currencyName!,
      symbol: abbr.symbol!,
      abbr: abbr,
      rate: rate,
    );
  }

  bool get isValidCurrency => abbr.isValidCurrencyAbbr;

}

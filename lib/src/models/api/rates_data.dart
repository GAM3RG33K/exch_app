import 'package:exch_app/src/models/currency.dart';
import 'package:exch_app/src/utils/domain/currency_helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rates_data.freezed.dart';
part 'rates_data.g.dart';

@freezed
class RatesData with _$RatesData {
  const factory RatesData({
    required String date,
    required Map<String, num> rates,
  }) = _RatesData;

  factory RatesData.fromJson(Map<String, dynamic> json) =>
      _$RatesDataFromJson(json);
}

extension CurrenctFetchExtension on RatesData {
  Map<String, Currency> get rateInCurrency {
    final entries = rates.entries
        .map(
          (e) {
            final abbr = e.key;
            if (!abbr.isValidCurrencyAbbr) return null;
            final currency = Currency.fromAbbr(abbr: abbr, rate: e.value);
            return MapEntry(abbr, currency);
          },
        )
        .where((element) => element != null)
        .toList()
        .cast<MapEntry<String, Currency>>();

    return Map.fromEntries(entries);
  }
}

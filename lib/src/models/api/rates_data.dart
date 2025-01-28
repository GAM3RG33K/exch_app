import 'package:exch_app/src/models/currency.dart';
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
          (e) => MapEntry(e.key, Currency.fromAbbr(abbr: e.key, rate: e.value)),
        )
        .toList();
    return Map.fromEntries(entries);
  }
}

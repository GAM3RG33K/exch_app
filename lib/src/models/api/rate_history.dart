import 'package:json_annotation/json_annotation.dart';

part 'rate_history.g.dart';

@JsonSerializable()
class HistoryDataEntry {
  final DateTime date;
  final num rate;

  HistoryDataEntry({
    required this.date,
    required this.rate,
  });

  factory HistoryDataEntry.fromJson(Map<String, dynamic> json) =>
      _$HistoryDataEntryFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryDataEntryToJson(this);
}

@JsonSerializable()
class RateHistory {
  final String base;
  final String target;
  final List<HistoryDataEntry> history;

  RateHistory({
    required this.base,
    required this.target,
    required this.history,
  });

  factory RateHistory.fromJson(Map<String, dynamic> json) =>
      _$RateHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$RateHistoryToJson(this);
}

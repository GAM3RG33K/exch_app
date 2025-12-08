import 'dart:async';
import 'dart:convert';

import 'package:exch_app/src/models/api/rates_data.dart';
import 'package:exch_app/src/models/api/rate_history.dart';
import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:exch_app/src/utils/string_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:exch_app/src/constants.dart';
import 'package:exch_app/src/utils/application/storage/storage_interface.dart';
import 'package:exch_app/src/utils/application/storage/storage_preference_impl.dart';

Future<void> initStorageHelper() async {
  final storage = StoragePreferenceImpl();
  await storage.init();
  log('Storage Helper Initializaed');

  GetIt.instance.registerSingleton<StorageHelper>(
    StorageHelper._(storage),
  );

  assert(GetIt.instance.isRegistered<StorageHelper>());

  // Clean up old history cache
  unawaited(storageHelper.cleanupOldHistoryCache());

  log('Registered Storage Helper Dependency');
}

StorageHelper get storageHelper => GetIt.instance.get<StorageHelper>();

class StorageHelper {
  final IStorage storage;
  StorageHelper._(this.storage);

  bool get isFirstRunHandled =>
      storage.containsKey(kPrefKeyIsFirstRun) &&
      (storage.getBool(kPrefKeyIsFirstRun)!);

  set isFirstRunHandled(bool value) =>
      storage.setBool(kPrefKeyIsFirstRun, value);

  String get cachedRateDate {
    return (storage.getString(kPrefKeyCachedRateDate) ?? "");
  }

  set cachedRateDate(String value) =>
      storage.setString(kPrefKeyCachedRateDate, value);

  String? get authToken {
    return storage.getString(kPrefKeyAuthToken);
  }

  set authToken(String? value) {
    if (value == null) {
      storage.remove(kPrefKeyAuthToken);
    } else {
      storage.setString(kPrefKeyAuthToken, value);
    }
  }

  String get latestRatesKey {
    final today = DateTime.now().dateOnly;
    return "$today";
  }

  Future<RatesData?> getLatestRates({
    String? prefKey,
  }) async {
    final key = prefKey ?? latestRatesKey;
    final jsonString = storage.getString(key) ?? "{}";
    final json = jsonDecode(jsonString) as Map<String, dynamic>?;
    if (json == null || json.isEmpty) return null;
    final ratesData = RatesData.fromJson(json);
    return ratesData;
  }

  Future<RatesData?> getLatestCachedRates() async {
    final key = cachedRateDate;
    return getLatestRates(prefKey: key);
  }

  Future<void> setLatestRates(RatesData ratesData) async {
    final key = latestRatesKey;
    final json = jsonEncode(ratesData.toJson());
    await storage.setString(key, json);
    cachedRateDate = ratesData.date;
  }

  String _getHistoryKey(
      String base, String target, String? start, String? end) {
    final today = DateTime.now().dateOnly;
    return "history_${base}_${target}_${start ?? ''}_${end ?? ''}_$today";
  }

  Future<RateHistory?> getRateHistory({
    required String base,
    required String target,
    String? start,
    String? end,
  }) async {
    final key = _getHistoryKey(base, target, start, end);
    final jsonString = storage.getString(key);
    if (jsonString == null) return null;

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return RateHistory.fromJson(json);
    } catch (e) {
      log('Error decoding cached history', error: e);
      return null;
    }
  }

  Future<void> setRateHistory(RateHistory history,
      {required String base,
      required String target,
      String? start,
      String? end}) async {
    final key = _getHistoryKey(base, target, start, end);
    final json = jsonEncode(history.toJson());
    await storage.setString(key, json);
  }

  Future<void> cleanupOldHistoryCache() async {
    final keys = storage.getKeys();
    final today = DateTime.now().dateOnly;
    final historyKeys = keys.where((key) {
      return key.toString().startsWith("history_") &&
          !key.toString().endsWith("_$today");
    }).toList();

    for (final key in historyKeys) {
      await storage.remove(key.toString());
    }

    if (historyKeys.isNotEmpty) {
      log('Cleaned up ${historyKeys.length} old history cache entries');
    }
  }
}

import 'dart:convert';

import 'package:exch_app/src/models/api/rates_data.dart';
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
}

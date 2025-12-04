// rate fetch api : /api/rates/latest

import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:exch_app/src/models/api/rates_data.dart';
import 'package:exch_app/src/models/api/rate_history.dart';
import 'package:exch_app/src/models/currency.dart';
import 'package:exch_app/src/utils/application/storage/storage_helper.dart';
import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:exch_app/src/utils/network/analytics_helper.dart';
import 'package:exch_app/src/utils/network/api_helper.dart';
import 'package:exch_app/src/utils/string_helper.dart';
import 'package:get_it/get_it.dart';

class RepoError extends Error {
  final String message;
  RepoError(this.message);

  @override
  String toString() {
    return message;
  }
}

class RepoResponse<T> {
  final T? data;
  final RepoError? error;
  final num turnAroundTime;

  RepoResponse({
    required this.turnAroundTime,
    this.data,
    this.error,
  });
}

Future<void> initRatesRepository() async {
  final ratesRepository = RatesRepository(
    apiHelper: apiHelper,
    storageHelper: storageHelper,
  );
  GetIt.instance.registerSingleton<RatesRepository>(
    ratesRepository,
  );
  assert(GetIt.instance.isRegistered<RatesRepository>());
  log('Registered Rates Repository Dependency');
}

RatesRepository get ratesRepository => GetIt.instance.get<RatesRepository>();

class RatesRepository {
  final StorageHelper storageHelper;
  final ApiHelper apiHelper;

  RatesRepository({
    required this.apiHelper,
    required this.storageHelper,
  });

  final latestRates = ValueNotifier<List<Currency>>(<Currency>[]);
  final latestRateDate = ValueNotifier<String>("");
  final ValueNotifier<bool> isFetching = ValueNotifier(false);

  bool get hasCacheExpired {
    final today = DateTime.now().dateOnly;
    final cachedRatesKey = storageHelper.cachedRateDate;
    return today != cachedRatesKey;
  }

  Future<RatesData?> fetchCurrencyRatesFromAPI() async {
    try {
      final response = await apiHelper.get('/api/rates/latest');
      final data = (response.data as Map?);
      if (data == null || data.isEmpty) {
        return null;
      }
      unawaited(analyticsHelper?.logFetchRates());
      final ratesData = RatesData.fromJson(data.cast<String, dynamic>());
      return ratesData;
    } catch (ex) {
      log("Unable to fetch exchange rates", error: ex);
    }
    return null;
  }

  Future<RepoResponse<RatesData>?> fetchCurrencyRates(
      {required String errorString, bool onlyCached = false}) async {
    if (onlyCached) {
      final startTimestamp = DateTime.now().microsecondsSinceEpoch;
      final cachedRates = await storageHelper.getLatestCachedRates();
      final endTimestamp = DateTime.now().microsecondsSinceEpoch;

      final difference = endTimestamp - startTimestamp;

      final turnAroundTime = difference ~/ (1000);
      return RepoResponse<RatesData>(
        turnAroundTime: turnAroundTime,
        data: cachedRates,
      );
    }

    isFetching.value = true;
    final startTimestamp = DateTime.now().microsecondsSinceEpoch;

    RatesData? ratesData = await storageHelper.getLatestRates();

    if ((hasCacheExpired || ratesData == null)) {
      ratesData = await fetchCurrencyRatesFromAPI();
    }
    final endTimestamp = DateTime.now().microsecondsSinceEpoch;

    final difference = endTimestamp - startTimestamp;

    final turnAroundTime = difference ~/ (1000);

    isFetching.value = false;

    if (ratesData == null) {
      return RepoResponse<RatesData>(
        turnAroundTime: turnAroundTime,
        // ignore: use_build_context_synchronously
        error: RepoError(errorString),
      );
    }

    storageHelper.setLatestRates(ratesData);

    return RepoResponse<RatesData>(
      turnAroundTime: turnAroundTime,
      data: ratesData,
    );
  }

  Future<RepoResponse<RateHistory>?> fetchRateHistory(
      {required String base,
      required String target,
      String? start,
      String? end,
      double? currentBase}) async {
    try {
      final startTimestamp = DateTime.now().microsecondsSinceEpoch;

      if (kDebugMode) {
        // Dummy data for debug mode
        final dummyHistory = <HistoryDataEntry>[];
        final now = DateTime.now();
        final random = Random();
        double currentRate = currentBase ?? 1.0;

        // Generate 100 data points
        for (int i = 100; i >= 0; i--) {
          final date = now.subtract(Duration(days: i));
          final dateString =
              "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

          // Random walk
          final change = (random.nextDouble() - 0.5) * 0.05;
          currentRate += change;
          if (currentRate < 0.1) currentRate = 0.1;

          dummyHistory.add(HistoryDataEntry(
              date: DateTime.parse(dateString), rate: currentRate));
        }

        await Future.delayed(
            const Duration(milliseconds: 500)); // Simulate network delay

        return RepoResponse<RateHistory>(
          turnAroundTime: 500,
          data: RateHistory(
            base: base,
            target: target,
            history: dummyHistory,
          ),
        );
      }

      final queryParams = {
        'base': base,
        'target': target,
        if (start != null) 'start': start,
        if (end != null) 'end': end,
      };

      final response = await apiHelper.get(
        '/api/rates/history',
        queryParameters: queryParams,
      );

      final endTimestamp = DateTime.now().microsecondsSinceEpoch;
      final turnAroundTime = (endTimestamp - startTimestamp) ~/ 1000;

      final data = response.data as Map<String, dynamic>;
      final historyData = RateHistory.fromJson(data);

      return RepoResponse<RateHistory>(
        turnAroundTime: turnAroundTime,
        data: historyData,
      );
    } catch (ex) {
      log("Unable to fetch rate history", error: ex);
      return RepoResponse<RateHistory>(
        turnAroundTime: 0,
        error: RepoError("Failed to fetch history"),
      );
    }
  }
}

// rate fetch api : /api/rates/latest

import 'dart:async';

import 'package:exch_app/src/models/api/rates_data.dart';
import 'package:exch_app/src/models/currency.dart';
import 'package:exch_app/src/utils/application/storage/storage_helper.dart';
import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:exch_app/src/utils/network/analytics_helper.dart';
import 'package:exch_app/src/utils/network/api_helper.dart';
import 'package:exch_app/src/utils/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:exch_app/src/utils/application/context_helper.dart';

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

  bool get hasCacheExpired {
    final today = DateTime.now().dateOnly;
    final cachedRatesKey = storageHelper.cachedRateDate;
    return today != cachedRatesKey;
  }

  Future<RatesData?> fetchCurrencyRatesFromAPI() async {
    final response = await apiHelper.get('/api/rates/latest');
    final data = (response.data as Map?);
    if (data == null || data.isEmpty) {
      return null;
    }
    unawaited(analyticsHelper?.logFetchRates());
    final ratesData = RatesData.fromJson(data.cast<String, dynamic>());
    return ratesData;
  }

  Future<RepoResponse<RatesData>?> fetchCurrencyRates(
      BuildContext context) async {
    final startTimestamp = DateTime.now().microsecondsSinceEpoch;
    RatesData? ratesData = await storageHelper.getLatestRates();
    if (hasCacheExpired || ratesData == null) {
      ratesData = await fetchCurrencyRatesFromAPI();
    }
    final endTimestamp = DateTime.now().microsecondsSinceEpoch;

    final difference = endTimestamp - startTimestamp;

    final turnAroundTime = difference ~/ (1000);
    if (ratesData == null) {
      return RepoResponse<RatesData>(
        turnAroundTime: turnAroundTime,
        // ignore: use_build_context_synchronously
        error: RepoError(context.l10n!.repo_error_message),
      );
    }
    storageHelper.setLatestRates(ratesData);
    return RepoResponse<RatesData>(
      turnAroundTime: turnAroundTime,
      data: ratesData,
    );
  }
}

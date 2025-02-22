import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:exch_app/src/repositories/rates_repository.dart';
import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:get_it/get_it.dart';

Future<void> initConnectivityHelper() async {
  final connectivityHelper = ConnectivityHelper._(Connectivity());
  await connectivityHelper.initialize();

  GetIt.instance.registerSingleton<ConnectivityHelper>(
    connectivityHelper,
  );
  assert(GetIt.instance.isRegistered<ConnectivityHelper>());
  log('Registered Connectivity Helper Dependency');
}

ConnectivityHelper get connectivityHelper =>
    GetIt.instance.get<ConnectivityHelper>();

class ConnectivityHelper {
  final Connectivity _connectivity;

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityHelper._(this._connectivity)
      : _streamController = StreamController.broadcast();

  final StreamController<ConnectivityResult> _streamController;

  Stream<ConnectivityResult> get connectivityStatusUpdates =>
      _streamController.stream;

  Future<void> initialize() async {
    // Check initial connectivity
    final result = await _connectivity.checkConnectivity();
    _handleConnectivityResult(result.first);

    // Listen for connectivity changes
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      _handleConnectivityResult(result.first);
    });
  }

  void _handleConnectivityResult(ConnectivityResult result) {
    _streamController.sink.add(result);

    final isOnline = result != ConnectivityResult.none;

    // If coming back online and rates repository exists, fetch new rates
    if (isOnline &&
        GetIt.instance.isRegistered<RatesRepository>()) {
      _fetchLatestRates();
    }
  }

  Future<void> _fetchLatestRates() async {

    try {
      await ratesRepository.fetchCurrencyRates(
        errorString: 'failed to load currency rates on network status change',
      );
    } finally {}
  }

  void dispose() {
    _subscription?.cancel();
    _streamController.close();
  }
}

extension ConnectivityResultExtension on ConnectivityResult? {
  bool get isOnline {
    if (this == null) {
      return false;
    }

    if (this == ConnectivityResult.none) {
      return false;
    }

    if (this == ConnectivityResult.bluetooth) {
      return false;
    }

    return true;
  }
}

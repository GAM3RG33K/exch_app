import 'dart:async';
import 'package:exch_app/src/constants.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:exch_app/src/repositories/rates_repository.dart';
import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:get_it/get_it.dart';

Future<void> initConnectivityHelper() async {
  final connection = InternetConnection.createInstance(
    customCheckOptions: [
      InternetCheckOption(uri: Uri.parse(kBaseUrl)),
    ],
  );
  final connectivityHelper = ConnectivityHelper._(connection);
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
  final InternetConnection _internetConnection;

  StreamSubscription<InternetStatus>? _subscription;

  ConnectivityHelper._(this._internetConnection)
      : _streamController = StreamController.broadcast();

  final StreamController<InternetStatus> _streamController;

  Stream<InternetStatus> get connectivityStatusUpdates =>
      _streamController.stream;

  Future<void> initialize() async {
    // Check initial connectivity
    final isConnected = await _internetConnection.hasInternetAccess;
    _handleConnectivityResult(
      isConnected ? InternetStatus.connected : InternetStatus.disconnected,
    );

    // Listen for connectivity changes
    _subscription = _internetConnection.onStatusChange.listen((status) {
      _handleConnectivityResult(status);
    });
  }

  void _handleConnectivityResult(InternetStatus status) {
    _streamController.sink.add(status);

    final isConnected = status == InternetStatus.connected;

    // If coming back online and rates repository exists, fetch new rates
    if (isConnected && GetIt.instance.isRegistered<RatesRepository>()) {
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

extension ConnectivityResultExtension on InternetStatus {
  bool get isOnline => this == InternetStatus.connected;
}

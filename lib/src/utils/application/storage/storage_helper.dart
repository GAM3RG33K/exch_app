import 'package:get_it/get_it.dart';
import 'package:exch_app/src/constants.dart';
import 'package:exch_app/src/utils/application/storage/storage_interface.dart';
import 'package:exch_app/src/utils/application/storage/storage_preference_impl.dart';
import 'package:exch_app/src/utils/utils.dart';

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
}

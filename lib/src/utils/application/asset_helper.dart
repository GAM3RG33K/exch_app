import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:get_it/get_it.dart';

Future<void> initAssetHelper() async {
  GetIt.instance.registerSingleton<AssetHelper>(
    AssetHelper._(),
  );
  assert(GetIt.instance.isRegistered<AssetHelper>());
  log('Registered Asset Helper Dependency');
}

AssetHelper get assetHelper => GetIt.instance.get<AssetHelper>();

class AssetHelper {
  AssetHelper._();
  String get imagesFolder => 'assets/images';

// Image Assets
  String get kLogo => '$imagesFolder/logo.png';
  String get kLogoSvg => '$imagesFolder/logo.svg';
}

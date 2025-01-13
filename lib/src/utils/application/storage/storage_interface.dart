abstract class IStorage {
  IStorage();

  Future<void> init();

  int? getInt(String key, {int? defaultValue});

  String? getString(String key, {String? defaultValue});

  double? getDouble(String key, {double? defaultValue});

  bool? getBool(String key, {bool? defaultValue});

  Future<void> setInt(String key, int? value);

  Future<void> setString(String key, String? value);

  Future<void> setDouble(String key, double? value);

  Future<void> setBool(String key, bool? value);

  bool containsKey(String key);

  Set getKeys();

  Future<void> remove(String key);

  Future<void> removeAll();

  Future<void> setObject<T>(String key, T? value);

  T? getValue<T>(String key, {T? defaultValue});
}

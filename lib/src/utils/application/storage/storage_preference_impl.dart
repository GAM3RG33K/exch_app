import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:exch_app/src/utils/application/storage/storage_interface.dart';

class StoragePreferenceImpl implements IStorage {
  SharedPreferences? sharedPreferences;

  bool _isInitialized = false;

  get isInitialized => _isInitialized;

  @override
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  @override
  bool containsKey(String key) {
    assert(
      _isInitialized,
      "Storage is not initialized, Please call init() before using the storage API",
    );
    return sharedPreferences!.containsKey(key);
  }

  @override
  bool? getBool(String key, {bool? defaultValue}) {
    assert(
      _isInitialized,
      "Storage is not initialized, Please call init() before using the storage API",
    );
    return sharedPreferences!.getBool(key) ?? defaultValue;
  }

  @override
  double? getDouble(String key, {double? defaultValue}) {
    assert(
      _isInitialized,
      "Storage is not initialized, Please call init() before using the storage API",
    );
    return sharedPreferences!.getDouble(key) ?? defaultValue;
  }

  @override
  int? getInt(String key, {int? defaultValue}) {
    assert(
      _isInitialized,
      "Storage is not initialized, Please call init() before using the storage API",
    );
    return sharedPreferences!.getInt(key) ?? defaultValue;
  }

  @override
  Set getKeys() {
    assert(
      _isInitialized,
      "Storage is not initialized, Please call init() before using the storage API",
    );
    return sharedPreferences!.getKeys();
  }

  @override
  String? getString(String key, {String? defaultValue}) {
    assert(
      _isInitialized,
      "Storage is not initialized, Please call init() before using the storage API",
    );
    return sharedPreferences!.getString(key) ?? defaultValue;
  }

  @override
  T? getValue<T>(String key, {T? defaultValue}) {
    assert(
      _isInitialized,
      "Storage is not initialized, Please call init() before using the storage API",
    );
    return sharedPreferences!.get(key) as T? ?? defaultValue;
  }

  @override
  Future<void> remove(String key) {
    assert(
      _isInitialized,
      "Storage is not initialized, Please call init() before using the storage API",
    );
    return sharedPreferences!.remove(key);
  }

  @override
  Future<void> removeAll() {
    assert(
      _isInitialized,
      "Storage is not initialized, Please call init() before using the storage API",
    );
    return sharedPreferences!.clear();
  }

  @override
  Future<void> setBool(String key, bool? value) {
    assert(
      _isInitialized,
      "Storage is not initialized, Please call init() before using the storage API",
    );
    if (value == null) remove(key);
    return sharedPreferences!.setBool(key, value!);
  }

  @override
  Future<void> setDouble(String key, double? value) {
    assert(
      _isInitialized,
      "Storage is not initialized, Please call init() before using the storage API",
    );
    if (value == null) remove(key);
    return sharedPreferences!.setDouble(key, value!);
  }

  @override
  Future<void> setInt(String key, int? value) {
    assert(
      _isInitialized,
      "Storage is not initialized, Please call init() before using the storage API",
    );
    if (value == null) remove(key);
    return sharedPreferences!.setInt(key, value!);
  }

  @override
  Future<void> setObject<T>(String key, T? value) {
    assert(
      _isInitialized,
      "Storage is not initialized, Please call init() before using the storage API",
    );
    if (value == null) remove(key);
    return sharedPreferences!.setString(key, jsonEncode(value!));
  }

  @override
  Future<void> setString(String key, String? value) {
    assert(
      _isInitialized,
      "Storage is not initialized, Please call init() before using the storage API",
    );
    if (value == null) remove(key);
    return sharedPreferences!.setString(key, value!);
  }
}

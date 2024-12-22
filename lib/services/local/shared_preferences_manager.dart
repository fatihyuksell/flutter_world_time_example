import 'dart:convert';

import 'package:optimus_case/enums/shared_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  final Map<String, Object?> _cache = {};

  Future<bool> set(final String key, final Object? value) async {
    if (key.isEmpty) {
      return false;
    }

    _cache[key] = value;

    if (value == null) {
      _cache.remove(key);
      return _prefs.remove(key);
    } else if (value is int) {
      return _prefs.setInt(key, value);
    } else if (value is double) {
      return _prefs.setDouble(key, value);
    } else if (value is bool) {
      return _prefs.setBool(key, value);
    } else if (value is String) {
      return _prefs.setString(key, value);
    } else if (value is List<String>) {
      return _prefs.setStringList(key, value);
    } else if (value is Map<String, dynamic>) {
      return _prefs.setString(key, json.encode(value));
    } else {
      _cache.remove(key);
      throw Exception('Invalid Type');
    }
  }

  T? get<T>(final String key) {
    if (_cache.containsKey(key)) {
      return _cache[key] as T?;
    }

    T? value;

    if (key.isEmpty) {
      value = null;
    } else if (T == int) {
      value = _prefs.getInt(key) as T?;
    } else if (T == double) {
      value = _prefs.getDouble(key) as T?;
    } else if (T == bool) {
      value = _prefs.getBool(key) as T?;
    } else if (T == String) {
      value = _prefs.getString(key) as T?;
    } else if (T == List<String>) {
      _prefs.getStringList(key) as List<T>?;
    } else if (T == Map<String, dynamic>) {
      value = _prefs.getString(key) != null
          ? jsonDecode(_prefs.getString(key)!) as T?
          : null;
    } else {
      throw Exception('Invalid value type!');
    }

    _cache[key] = value;
    return value;
  }

  Future<void> deleteAll() async {
    _cache.clear();
    await _prefs.clear();
  }

  String? get languageCode => get<String>(SharedConstants.languageCode.value);
}

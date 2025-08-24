import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/log.dart';



class SharedPreferencesManager {
  static SharedPreferences? _prefs;
  static final Map<String, ValueNotifier<dynamic>> _notifiers = {};

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  static ValueNotifier<T?> listen<T>(String key) {
    if (_notifiers[key] == null) {
      _notifiers[key] = ValueNotifier<T?>(get<T>(key));
    }
    return _notifiers[key] as ValueNotifier<T?>;
  }

  static Future<bool> save<T>(String key, T value) async {
    if (_prefs == null) return false;

    bool success;
    if (value is String) {
      success = await _prefs!.setString(key, value);
    } else if (value is int) {
      success = await _prefs!.setInt(key, value);
    } else if (value is double) {
      success = await _prefs!.setDouble(key, value);
    } else if (value is bool) {
      success = await _prefs!.setBool(key, value);
    } else if (value is List<String>) {
      success = await _prefs!.setStringList(key, value);
    } else {
      try {
        final json = (value as dynamic).toJson();
        success = await _prefs!.setString(key, jsonEncode(json));
      } catch (_) {
        throw UnsupportedError("Unsupported value type and missing toJson()");
      }
    }

    if (success) _notifiers[key]?.value = value;
    return success;
  }

  static T? get<T>(String key, {T Function(Map<String, dynamic>)? fromJson}) {
    if (_prefs == null) return null;

    dynamic value = _prefs!.get(key);
    if (T == String || T == int || T == double || T == bool || T == List<String>) {
      return value as T?;
    }

    if (value is String && fromJson != null) {
      try {
        final map = jsonDecode(value) as Map<String, dynamic>;
        return fromJson(map);
      } catch (_) {
        return null;
      }
    }
    
    return value;
  }


  static void remove(String key) {
    _prefs?.remove(key);
    _notifiers[key]?.value = null;
  }

  static void clear() {
    _prefs?.clear();
    for (var notifier in _notifiers.values) {
      notifier.value = null;
    }
  }

}



import 'dart:convert';

import 'package:jbdev/jbdev.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SharedPreferencesManager {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    String? currencySymbol = get("app.currency_symbol");
    String? local = get("app.local");
    String? timezone = get("app.timezone");

    if (currencySymbol.isNullOrEmpty) {
      App.currencySymbol = currencySymbol!;
    }
    if (local.isNullOrEmpty) {
      App.locale = JBLocale.values.fromString(local);
    }
    if (timezone.isNullOrEmpty) {
      App.timezone = JBTimezone.values.fromString(timezone);
    }
  }


  static Future<bool> save<T>(String key, T value) async {
    if (_prefs == null) return false;

    if (value is String) {
      return await _prefs!.setString(key, value);
    } else if (value is int) {
      return await _prefs!.setInt(key, value);
    } else if (value is double) {
      return await _prefs!.setDouble(key, value);
    } else if (value is bool) {
      return await _prefs!.setBool(key, value);
    } else if (value is List<String>) {
      return await _prefs!.setStringList(key, value);
    } else {
      try {
        final json = (value as dynamic).toJson(); // assumes value has toJson()
        return await _prefs!.setString(key, jsonEncode(json));
      } catch (_) {
        throw UnsupportedError("Unsupported value type and missing toJson()");
      }
    }
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

    return null;
  }



  static void remove(String key) {
    _prefs?.remove(key);
  }

  static void clear() {
    _prefs?.clear();
  }
}

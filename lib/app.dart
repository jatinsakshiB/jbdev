import 'package:flutter/material.dart';
import 'package:jbdev/jbdev.dart';
import 'package:package_info_plus/package_info_plus.dart';


ValueNotifier<int> appNotifier = ValueNotifier(0);

class App{
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;

  static String _currencySymbol = JBConfig.defCurrencySymbol;
  static JBLocale _locale = JBConfig.defLocale;
  static JBTimezone _timezone = JBConfig.defTimezone;
  static String _theme = "default";

  static String get currencySymbol => _currencySymbol;
  static JBLocale get locale => _locale;
  static String get localeCode => _locale.name;
  static JBTimezone get timezone => _timezone;
  static ThemeData? get theme {
    return JBConfig.themes[_theme];
  }

  static set currencySymbol(String value) {
    _currencySymbol = value;
    SharedPreferencesManager.save("app.currency_symbol", value);
    appNotifier.value++;
  }
  static set locale(JBLocale value) {
    _locale = value;
    SharedPreferencesManager.save("app.locale", value.name);
    appNotifier.value++;
  }
  static set timezone(JBTimezone value) {
    _timezone = value;
    SharedPreferencesManager.save("app.timezone", value.name);
    appNotifier.value++;
  }
  static void setTheme(String value) {
    _theme = value;
    SharedPreferencesManager.save("app.theme", value);
    appNotifier.value++;
  }

  static PackageInfo? packageInfo;

  static Future<void> init() async{
    await SharedPreferencesManager.init();
    packageInfo = await PackageInfo.fromPlatform();

    final savedCurrency = SharedPreferencesManager.get("app.currency_symbol");
    final savedLocale = SharedPreferencesManager.get("app.locale");
    final savedTimezone = SharedPreferencesManager.get("app.timezone");
    final savedTheme = SharedPreferencesManager.get("app.theme");

    if (savedCurrency != null) _currencySymbol = savedCurrency;

    if (savedLocale != null) _locale = JBLocale.values.fromString(savedLocale);
    if (savedTimezone != null) _timezone = JBTimezone.values.fromString(savedTimezone,);
    if (savedTheme != null) _theme = savedTheme;
    appNotifier.value++;
  }
}
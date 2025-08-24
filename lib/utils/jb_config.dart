import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jbdev/jbdev.dart';



class JBConfig {
  static String? baseUrl;
  static Map<String, ThemeData> themes = {
    "default": ThemeData()
  };

  static String defCurrencySymbol = '₹';
  static JBLocale defLocale = JBLocale.en_IN;
  static JBTimezone defTimezone = JBTimezone.ist;

  static ApiConfig apiConfig = ApiConfig();
  static ToastConfig toastConfig = ToastConfig();
  static TapEffectConfig tapEffectConfig = TapEffectConfig();

  static Widget Function(BuildContext context)? loadingPopupBuilder;
  static Widget Function(BuildContext context, JBPopup popup)? popupBuilder;
  static Widget Function(BuildContext context, JBPopup popup)? bottomSheetBuilder;
  static Widget Function(BuildContext context, JBPopup popup, Widget Function() child)? bottomSheetBackgroundBuilder;
  static double? bottomSheetActionsHeight = 54;

  /// Defines the maximum height of the bottom sheet as a fraction of the screen height.
  ///
  /// Accepted range: 0.5 to 1.0
  /// - `0.5` = 50% of screen height (half screen)
  /// - `1.0` = 100% of screen height (full screen)
  ///
  /// Example:
  /// ```dart
  /// bottomSheetMaxHeight = 0.8; // Shows bottom sheet at 80% screen height
  /// ```
  static double bottomSheetMaxHeight = 0.8;
  static double? bottomSheetBarrierBlur;
  static double? popupBarrierBlur;
  static double bottomSheetBorderRadius = 16;
  static double popupBorderRadius = 16;
  static Color? bottomSheetBackgroundColor;
  static Color? popupBackgroundColor;
  static Color? popupBarrierColor = Colors.black54;
  static EdgeInsets popupPadding = EdgeInsets.all(26);


  static JBTextFieldErrors defaultTextFieldErrors = JBTextFieldErrors();
  static JBTextFieldProperties defaultTextField = JBTextFieldProperties();
  static Map<String, JBTextFieldProperties> textFields = {};

  static JBButtonProperties defaultButton = JBButtonProperties();
  /// Button style configuration map for JBButton.
  ///
  /// Each entry defines the style of a button type.
  /// You can also define light/dark theme variants.
  ///
  /// 🔑 Key Format:
  /// - `"type"`: Base style for the type.
  /// - `"type:light"`: Optional light mode variant.
  /// - `"type:dark"`: Optional dark mode variant.
  ///
  /// ❗ No fallback: If a requested type or theme variant is missing, an error will be thrown.
  ///
  /// Example:
  /// ```dart
  /// static Map<String, JBButtonProperties> buttons = {
  ///   "primary": JBButtonProperties(),
  ///   "primary:light": JBButtonProperties(),
  ///   "primary:dark": JBButtonProperties(),
  /// };
  /// ```
  ///
  /// Usage in `JBButton` will resolve:
  /// - `"type:<brightness>"`
  /// - Then `"type"`
  /// - ❌ If not found, throws error.
  static Map<String, JBButtonProperties> buttons = {
    "success": JBButtonProperties(
      color: Colors.green,
      textColor: Colors.white
    ),
    'error': JBButtonProperties(
      color: Colors.red,
      textColor: Colors.white
    )
  };

}

class TapEffectConfig{
  Color? splashColor;
  Color? highlightColor;
  Color? hoverColor;
  Color? focusColor;
  Duration? hoverDuration;
  MouseCursor? mouseCursor;

  TapEffectConfig({this.splashColor, this.highlightColor, this.hoverColor, this.focusColor, this.hoverDuration, this.mouseCursor});
}

class ToastConfig{
  ToastGravity gravity;
  Toast? toastLength;
  Color? backgroundColor;
  Color? textColor;
  double? fontSize;

  ToastConfig({this.gravity = ToastGravity.BOTTOM, this.toastLength, this.backgroundColor, this.textColor, this.fontSize});
}

class ApiConfig {
  Duration connectTimeout;
  Duration receiveTimeout;
  Duration sendTimeout;
  List<int> validStatuses;
  Map<String, dynamic> headers;

  ApiConfig({
    this.connectTimeout = const Duration(seconds: 25),
    this.receiveTimeout = const Duration(seconds: 25),
    this.sendTimeout = const Duration(seconds: 25),
    this.validStatuses = const [200],
    this.headers = const {"Accept": "application/json"},
  });
}

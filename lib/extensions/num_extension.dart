import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jbdev/jbdev.dart';

extension NumExtensions on num {
  /// Convert number to width (SizedBox)
  Widget get widthBox => SizedBox(width: toDouble());

  /// Convert number to height (SizedBox)
  Widget get heightBox => SizedBox(height: toDouble());


  Duration get seconds => Duration(seconds: toInt());
  Duration get minutes => Duration(minutes: toInt());
  Duration get microseconds => Duration(microseconds: toInt());
  Duration get milliseconds => Duration(milliseconds: toInt());
  Duration get hours => Duration(hours: toInt());
  Duration get days => Duration(days: toInt());

  num get half => this*.5;

  String format({String pattern = "#.##"}) {
    return NumberFormat(pattern).format(this);
  }

  String money({String pattern = "#.##"}) {
    return "${App.currencySymbol}${format(pattern: pattern)}";
  }


  /// Returns a string combining this number with the correct singular or plural form of a word.
  ///
  /// - If the number is 1, returns "1 <singular>".
  /// - Otherwise, returns "<number> <plural>", or appends "s" to the singular if no plural is provided.
  ///
  /// Example:
  /// ```dart
  /// 1.pluralize("apple");                 // "1 apple"
  /// 3.pluralize("apple");                 // "3 apples"
  /// 2.pluralize("child", plural: "children"); // "2 children"
  /// ```
  String pluralize(String singular, {String? plural}) => this == 1 ? "$this $singular" : "$this ${plural ?? '${singular}s'}";
}

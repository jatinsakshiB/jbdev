import 'package:flutter/cupertino.dart';

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
}

import 'package:flutter/material.dart';

class JBTextFieldProperties{
  Color? color;
  Color? borderColor;
  double? borderWidth;
  Color? disabledBorderColor;
  double? disabledBorderWidth;
  Color? focusedBorderColor;
  double? focusedBorderWidth;
  BorderRadius? borderRadius;
  double? borderRadiusAll;
  TextStyle? textStyle;
  TextStyle? labelTextStyle;
  TextStyle? hintTextStyle;
  TextStyle? errorTextStyle;
  Color? textColor;
  Color? labelTextColor;
  Color? hintTextColor;
  Color? errorTextColor;
  EdgeInsetsGeometry? padding;
  double? elevation;
  Color? cursorColor;
  MainAxisAlignment? errorAlignment;


  JBTextFieldProperties({
    this.color,
    this.borderColor,
    this.borderWidth,
    this.disabledBorderColor,
    this.disabledBorderWidth,
    this.focusedBorderColor,
    this.focusedBorderWidth,
    this.borderRadius,
    this.borderRadiusAll,
    this.textStyle,
    this.labelTextStyle,
    this.hintTextStyle,
    this.errorTextStyle,
    this.textColor,
    this.labelTextColor,
    this.hintTextColor,
    this.errorTextColor,
    this.padding,
    this.elevation,
    this.cursorColor,
    this.errorAlignment
  });
}
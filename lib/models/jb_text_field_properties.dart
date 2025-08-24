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
  TextStyle? disableTextStyle;
  TextStyle? labelTextStyle;
  TextStyle? hintTextStyle;
  TextStyle? errorTextStyle;
  Color? textColor;
  Color? disableTextColor;
  Color? labelTextColor;
  Color? hintTextColor;
  Color? errorTextColor;
  EdgeInsetsGeometry? padding;
  double? elevation;
  Color? cursorColor;
  MainAxisAlignment? errorAlignment;
  double? height;


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
    this.errorAlignment,
    this.height,
  });
}

class JBTextFieldErrors{
  String Function(String)? requiredErrorText;
  String Function(String)? invalidErrorText;

  JBTextFieldErrors({
    this.requiredErrorText,
    this.invalidErrorText,
  });
}
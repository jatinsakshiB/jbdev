import 'package:flutter/material.dart';

class JBTextFieldProperties{
  Color? color;
  Color? borderColor;
  double? borderWidth;
  BorderRadius? borderRadius;
  double? borderRadiusAll;
  TextStyle? textStyle;
  TextStyle? labelTextStyle;
  TextStyle? hintTextStyle;
  Color? textColor;
  Color? labelTextColor;
  Color? hintTextColor;
  EdgeInsetsGeometry? padding;
  double? elevation;
  Color? cursorColor;


  JBTextFieldProperties({
    this.color,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.borderRadiusAll,
    this.textStyle,
    this.labelTextStyle,
    this.hintTextStyle,
    this.textColor,
    this.labelTextColor,
    this.hintTextColor,
    this.padding,
    this.elevation,
    this.cursorColor
  });
}
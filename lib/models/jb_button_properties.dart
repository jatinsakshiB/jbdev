import 'package:flutter/material.dart';

class JBButtonProperties{
  LinearGradient? gradient;          // Gradient background (optional)
  Color? color;                      // Solid background color
  Color? borderColor;                // Border color (if any)
  double? borderWidth;               // Border thickness
  BorderRadius? borderRadius;        // Custom border radius
  double? borderRadiusAll;           // Uniform border radius (if preferred)
  TextStyle? textStyle;              // Custom text style
  Color? textColor;                  // Shortcut for text color
  double? height;                    // Button height
  double? minWidth;                  // Button min width
  EdgeInsetsGeometry? padding;       // Custom padding inside the button
  double? elevation;                 // Elevation (shadow depth)


  JBButtonProperties({
    this.gradient,
    this.color,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.borderRadiusAll,
    this.textStyle,
    this.textColor,
    this.height,
    this.minWidth,
    this.padding,
    this.elevation
  });
}
import 'package:flutter/material.dart';
import 'package:jbdev/jbdev.dart';


extension WidgetExtension on Widget {

  /// Add padding to any widget
  Widget withPaddingOnly({double left = 0, double top = 0, double right = 0, double bottom = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: this,
    );
  }
  /// Add padding to any widget
  Widget withPadding([EdgeInsetsGeometry padding = const EdgeInsets.all(8)]) {
    return Padding(
      padding: padding,
      child: this,
    );
  }
  /// Add padding to any widget
  Widget withPaddingAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  /// Add symmetric padding
  Widget withSymmetricPadding({double vertical = 0, double horizontal = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }

  /// Add only top padding
  Widget withTopPadding(double value) {
    return Padding(
      padding: EdgeInsets.only(top: value),
      child: this,
    );
  }

  /// Add only bottom padding
  Widget withBottomPadding(double value) {
    return Padding(
      padding: EdgeInsets.only(bottom: value),
      child: this,
    );
  }

  /// Add only left padding
  Widget withLeftPadding(double value) {
    return Padding(
      padding: EdgeInsets.only(left: value),
      child: this,
    );
  }

  /// Add only right padding
  Widget withRightPadding(double value) {
    return Padding(
      padding: EdgeInsets.only(right: value),
      child: this,
    );
  }

  /// Add margin using Container
  Widget withMargin([EdgeInsetsGeometry margin = const EdgeInsets.all(8)]) {
    return Container(
      margin: margin,
      child: this,
    );
  }

  /// Align widget
  Widget aligned({
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  /// Center any widget
  Widget centered() {
    return Center(child: this);
  }

  /// Expanded any widget
  Widget expanded() {
    return Expanded(child: this);
  }

  /// Make widget scrollable (useful for long Column in small screens)
  Widget scrollable({Axis axis = Axis.vertical}) {
    return SingleChildScrollView(
      scrollDirection: axis,
      child: this,
    );
  }

  /// Add tap functionality without manually wrapping with GestureDetector
  Widget onTap(VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }

  Widget onTapWithEffect(VoidCallback? onTap, {Color? effectColor, ShapeBorder? shape, BorderRadius? borderRadius}) {
    var config = JBConfig.tapEffectConfig;
    return Material(
      color: Colors.transparent,
      shape: shape,
      child: InkWell(
        onTap: onTap,
        splashColor: effectColor ?? config.splashColor,
        highlightColor: effectColor ?? config.highlightColor,
        hoverColor: config.hoverColor,
        hoverDuration: config.hoverDuration,
        focusColor: config.focusColor,
        mouseCursor: config.mouseCursor,
        customBorder: shape,
        borderRadius: borderRadius,
        child: this,
      ),
    );
  }


  /// Add width
  Widget withWidth(double? width) {
    return width == null ? this : SizedBox(
      width: width,
      child: this,
    );
  }

  /// Add height
  Widget withHeight(double? height) {
    return height == null ? this : SizedBox(
      height: height,
      child: this,
    );
  }

  /// Add a sized box wrapper
  Widget withSize({double? width, double? height}) {
    return SizedBox(
      width: width,
      height: height,
      child: this,
    );
  }

  /// Add rounded corners (useful for containers/images)
  Widget withRoundedCorners([double radius = 12]) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:jbdev/jbdev.dart';


extension TextStyleSizes on TextStyle {
  TextStyle get xs => copyWith(fontSize: 10);
  TextStyle get sm => copyWith(fontSize: 12);
  TextStyle get base => copyWith(fontSize: 14);
  TextStyle get md => copyWith(fontSize: 16);
  TextStyle get lg => copyWith(fontSize: 18);
  TextStyle get xl => copyWith(fontSize: 20);
  TextStyle get xxl => copyWith(fontSize: 24);
  TextStyle get xxxl => copyWith(fontSize: 32);


  TextStyle get primary => c(colors?.secondary);
  TextStyle get onPrimary => c(colors?.onPrimary);
  TextStyle get secondary => c(colors?.secondary);
  TextStyle get onSecondary => c(colors?.onSecondary);
  TextStyle get error => c(colors?.error);


  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get overline => copyWith(decoration: TextDecoration.overline);
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);

  TextStyle get ellipsis => copyWith(overflow: TextOverflow.ellipsis);
  TextStyle get clip => copyWith(overflow: TextOverflow.clip);
  TextStyle get fade => copyWith(overflow: TextOverflow.fade);
  TextStyle get visible => copyWith(overflow: TextOverflow.visible);

  TextStyle alpha(double alpha) => copyWith(color: color!.withValues(alpha: alpha));
  TextStyle c(Color? color) => copyWith(color: color, decorationColor: color);
}
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


  TextStyle primary(BuildContext context) => c(context.colors.primary);
  TextStyle onPrimary(BuildContext context) => c(context.colors.onPrimary);
  TextStyle secondary(BuildContext context) => c(context.colors.secondary);
  TextStyle onSecondary(BuildContext context) => c(context.colors.onSecondary);
  TextStyle error(BuildContext context) => c(context.colors.error);


  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get overline => copyWith(decoration: TextDecoration.overline);
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);

  TextStyle get ellipsis => copyWith(overflow: TextOverflow.ellipsis);
  TextStyle get clip => copyWith(overflow: TextOverflow.clip);
  TextStyle get fade => copyWith(overflow: TextOverflow.fade);
  TextStyle get visible => copyWith(overflow: TextOverflow.visible);

  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get normal => copyWith(fontWeight: FontWeight.normal);
  TextStyle get w100 => copyWith(fontWeight: FontWeight.w100);
  TextStyle get w200 => copyWith(fontWeight: FontWeight.w200);
  TextStyle get w300 => copyWith(fontWeight: FontWeight.w300);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);
  TextStyle get w900 => copyWith(fontWeight: FontWeight.w900);

  TextStyle alpha(double alpha) => copyWith(color: color!.withValues(alpha: alpha));
  TextStyle c(Color? color) => copyWith(color: color, decorationColor: color);
}
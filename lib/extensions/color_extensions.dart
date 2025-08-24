import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color? fromHex(String? hexString) {
    if (hexString == null || hexString.isEmpty) return null;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${(a * 255).toInt().toRadixString(16).padLeft(2, '0')}' // Convert alpha to int
      '${(r * 255).toInt().toRadixString(16).padLeft(2, '0')}' // Convert red to int
      '${(g * 255).toInt().toRadixString(16).padLeft(2, '0')}' // Convert green to int
      '${(b * 255).toInt().toRadixString(16).padLeft(2, '0')}'; // Convert blue to int
}

extension ColorExtensions on Color{
  Color withJbAlpha(int alpha, {Color? baseColor}){
    final colorWithAlpha = withValues(alpha: alpha/100);

    if (baseColor != null){
      return Color.alphaBlend(colorWithAlpha, baseColor);
    }
    return colorWithAlpha;
  }
}
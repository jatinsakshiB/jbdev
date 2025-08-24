
import 'package:flutter/material.dart';

class BumpNavBarPainter extends CustomPainter {
  final double bumpWidth;
  final double bumpDepth;
  final double cornerRadius;
  final Color fillColor;
  final Color? borderColor;
  final double borderWidth;

  BumpNavBarPainter({
    this.bumpWidth = 160,
    this.bumpDepth = 22,
    this.cornerRadius = 16,
    this.fillColor = Colors.white,
    this.borderColor,
    this.borderWidth = 1.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double center = size.width / 2;
    final double halfBumpWidth = bumpWidth / 2;

    final path = Path();

    path.moveTo(0, bumpDepth + cornerRadius);
    path.quadraticBezierTo(0, bumpDepth, cornerRadius, bumpDepth);

    path.lineTo(center - halfBumpWidth, bumpDepth);

    path.cubicTo(
      center - halfBumpWidth / 2, bumpDepth,
      center - halfBumpWidth / 2, 0,
      center, 0,
    );
    path.cubicTo(
      center + halfBumpWidth / 2, 0,
      center + halfBumpWidth / 2, bumpDepth,
      center + halfBumpWidth, bumpDepth,
    );

    path.lineTo(size.width - cornerRadius, bumpDepth);
    path.quadraticBezierTo(size.width, bumpDepth, size.width, bumpDepth + cornerRadius);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Draw fill
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, fillPaint);

    // Draw border
    if (borderColor != null){
      final borderPaint = Paint()
        ..color = borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth;

      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

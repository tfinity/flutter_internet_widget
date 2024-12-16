import 'package:flutter/material.dart';

class BoundaryOverlayPainter extends CustomPainter {
  BoundaryOverlayPainter({
    required this.color,
    this.shouldPaint = true,
    this.strokeWidth = 20.0,
    this.safeAreaTop = 0.0,
    this.safeAreaBottom = 0.0,
  });
  final Color color;
  final bool shouldPaint;
  final double strokeWidth;
  final double safeAreaTop;
  final double safeAreaBottom;

  @override
  void paint(Canvas canvas, Size size) {
    // print('shouldPaint: $shouldPaint');
    if (!shouldPaint) return;

    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth + safeAreaTop;

    canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);
    paint.strokeWidth = strokeWidth;

    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, size.height), paint);
    paint.strokeWidth = strokeWidth + safeAreaBottom;
    canvas.drawLine(
        Offset(size.width, size.height), Offset(0, size.height), paint);
    paint.strokeWidth = strokeWidth;
    canvas.drawLine(Offset(0, size.height), const Offset(0, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

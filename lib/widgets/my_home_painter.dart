import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:painter/models/drawing_area.dart';

class MyHomePainter extends CustomPainter {
  final List<DrawingArea?> points;
  final double strokeWidth;
  final Color selectedColor;

  const MyHomePainter({
    required this.points,
    required this.selectedColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Background rectangle
    Paint backgroundPainter = Paint()..color = Colors.white;
    Rect rectangle = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rectangle, backgroundPainter);

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(
          points[i]!.offset,
          points[i + 1]!.offset,
          points[i]!.paint,
        );
      } else if (points[i] != null && points[i + 1] == null) {
        canvas.drawPoints(
          PointMode.points,
          [points[i]!.offset],
          points[i]!.paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

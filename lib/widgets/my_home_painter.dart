import 'package:flutter/material.dart';

class MyHomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Background rectangle
    Paint backgroundPainter = Paint()..color = Colors.white;
    Rect rectangle = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rectangle, backgroundPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

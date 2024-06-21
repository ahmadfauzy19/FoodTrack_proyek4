import 'dart:math';
import 'package:flutter/material.dart';

class CircleBorderPainter extends CustomPainter {
  final List<Color> borderColors = [
    Colors.blueAccent,
    Colors.blueAccent,
    Colors.orange,
    Colors.orange
  ];
  final List<double> startAngles = [pi / 4, -3 * pi / 4, 3 * pi / 4, -pi / 4];
  final double sweepAngle = pi / 2;
  final Paint paints = Paint()
    ..strokeWidth = 4.0
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;

    for (int i = 0; i < borderColors.length; i++) {
      paints.color = borderColors[i];
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngles[i],
        sweepAngle,
        false,
        paints,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

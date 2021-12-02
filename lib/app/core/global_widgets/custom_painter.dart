import 'package:flutter/material.dart';

class BottomWavePainter extends CustomPainter {
  const BottomWavePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final x = size.width;
    final y = size.height;
    final path2 = Path();
    path2
      ..moveTo(0, y)
      ..lineTo(x, y)
      ..lineTo(x, y - (y / 10))
      ..quadraticBezierTo(x / 2, y - (y / 5), 0, y - (y / 10))
      ..close();
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

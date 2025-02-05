import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.deepPurple[700]!;
    final paint2 = Paint()..color = Colors.deepPurple[200]!;
    final paint3 = Paint()..color = Colors.deepPurple[100]!;

    final path = Path();
    path.moveTo(0, size.height * .25);
    path.lineTo(size.width, size.height * .5);
    path.lineTo(0, size.height * .75);
    path.close();
    canvas.drawPath(path, paint2);

    final path2 = Path();
    path2.moveTo(size.width, 0);
    path2.lineTo(size.width, 350);
    path2.lineTo(size.width * .5, 250);
    path2.lineTo(size.width * .5, 150);
    path2.close();
    canvas.drawPath(path2, paint);

    final rect = Rect.fromLTWH(0, 650, size.width, 230);
    final rrect = RRect.fromLTRBAndCorners(
      rect.left,
      rect.top,
      rect.right,
      rect.bottom,
      topRight: Radius.circular(50),
    );
    canvas.drawRRect(rrect, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

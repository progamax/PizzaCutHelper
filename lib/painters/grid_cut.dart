import 'dart:ui';

import 'package:flutter/material.dart';

class GridCut extends CustomPainter {
  int rowsNumber;
  double scale;

  GridCut(this.rowsNumber, this.scale);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    const double strokeWidth = 5;
    canvas.translate(size.width/2 * (1 - scale), size.height/2 * (1 - scale));
    canvas.scale(scale);
    Offset center = Offset(size.width / 2, size.height / 2 );
    canvas.clipRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: center, width: size.width, height: size.width), Radius.circular(size.width/2 - strokeWidth)));
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    for (int i = 1; i < rowsNumber; i++){
      canvas.drawLine(Offset(i * size.width / rowsNumber, 0), Offset(i * size.width / rowsNumber, size.height), paint);
      canvas.drawLine(Offset(0, i * size.height / rowsNumber), Offset(size.width,  i * size.height / rowsNumber), paint);
    }
    canvas.drawCircle(center, size.width / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
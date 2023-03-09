import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pizza_cut_helper/painters/painters.dart';

class CircularCut extends CustomPainter implements CutPainter {
  int numberParts;
  double scale;

  CircularCut(this.numberParts, this.scale);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    //Centrer le point d'origine du canvas (il est dans le coin supérieur gauche d'origine)
    canvas.translate(size.width / 2, size.height / 2);
    //Ajout d'un "padding" autour du dessin
    canvas.scale(0.90);
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawCircle(Offset.zero, size.width / 2 * scale, paint);
    for (var i = 0; i < numberParts; i++) {
      canvas.drawLine(
          Offset.zero, Offset.fromDirection((((i + 1) / numberParts) * 2 * pi) - (1 / 2) * pi, size.width / 2 * scale), paint);
    }
    paint.color = Colors.black;
    paint.strokeWidth = 2;
    canvas.drawCircle(Offset.zero, size.width / 2 * scale + 4.5, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
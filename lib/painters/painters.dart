import 'package:flutter/material.dart';
import 'package:pizza_cut_helper/painters/circular_cut.dart';
import 'package:pizza_cut_helper/painters/grid_cut.dart';

enum CutPainterType {
  circular, grid
}

abstract class CutPainter extends CustomPainter{
  factory CutPainter(CutPainterType type, int rowsNumber, double scale){
    switch (type){
      case CutPainterType.circular:
        return CircularCut(rowsNumber, scale);
      case CutPainterType.grid:
        return GridCut(rowsNumber, scale);
    }
  }
}
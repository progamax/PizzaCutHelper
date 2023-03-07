import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pizza_cut_helper/painters/circular_cut.dart';
import 'package:pizza_cut_helper/painters/grid_cut.dart';

class CameraViewer extends StatefulWidget {
  final CameraController controller;
  final int nbParts;

  const CameraViewer(this.controller, this.nbParts, {super.key});

  @override
  State<CameraViewer> createState() => _CameraViewerState();
}

class _CameraViewerState extends State<CameraViewer> {
  double helperScale = 1;
  double pinchScale = 1;
  bool isScaling = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CameraPreview(widget.controller),
        GestureDetector(
          onScaleStart: onScaleStart,
          onScaleEnd: onScaleEnd,
          onScaleUpdate: onScaleUpdate,
          child: Center(child: CustomPaint(painter: GridCut(widget.nbParts, helperScale * pinchScale), size: Size.infinite,),),
        )
      ],
    );
  }

  void onScaleStart(ScaleStartDetails details) {
    isScaling = true;
  }

  void onScaleEnd(ScaleEndDetails details) {
    isScaling = false;
    setState(() {
      helperScale = helperScale * pinchScale;
      pinchScale = 1;
    });
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      pinchScale = details.scale;
    });
  }
}

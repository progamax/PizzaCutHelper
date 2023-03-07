import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pizza_cut_helper/painters/circular_cut.dart';

class CameraViewer extends StatelessWidget {
  final CameraController controller;
  final int nbParts;

  const CameraViewer(this.controller, this.nbParts, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CameraPreview(controller),
        Center(child: CustomPaint(painter: CircularCut(nbParts), size: Size.infinite,),)
      ],
    );
  }
}

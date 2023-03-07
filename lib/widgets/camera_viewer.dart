import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraViewer extends StatelessWidget {
  final CameraController controller;

  const CameraViewer(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CameraPreview(controller),
      ],
    );
  }
}

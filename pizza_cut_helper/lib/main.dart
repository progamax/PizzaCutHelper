import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<CameraController> futureCameraController;

  @override
  void initState() {
    super.initState();
    futureCameraController = availableCameras().then((value) {
      var controller = CameraController(value.where((element) => element.lensDirection == CameraLensDirection.back).first, ResolutionPreset.high);
      return controller.initialize().then((value) => controller);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PizzaCutHelper',
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.red),
      home: Scaffold(
        appBar: AppBar(title: const Text("Pizza Cutter Helper"),),
        body: FutureBuilder<CameraController>(
          future: futureCameraController,
          builder: (context, snapshot){
            if (snapshot.hasData){
              var controller = snapshot.data!;
              return CameraPreview(controller);
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
}


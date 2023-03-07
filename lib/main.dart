import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pizza_cut_helper/widgets/camera_viewer.dart';

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
  int sliderValue = 2;

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
              return Align(
                  alignment: Alignment.topCenter,
                  child: Column(children: <Widget>[
                    Flexible(flex: 4, child: CameraViewer(controller)),
                    Slider(
                        value: sliderValue.toDouble(),
                        onChanged: (change) {
                          setState(() {
                            sliderValue = change.toInt();
                          });
                        },
                        min: 2,
                        max: 20,
                        divisions: 18,
                        label: sliderValue.toString()),
                    Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.center,
                            child: InkResponse(
                                child: LayoutBuilder(
                                  builder: (context, constraints) => IconButton(
                                      iconSize: constraints.biggest.height * .85,
                                      onPressed: (){},
                                      icon: const Icon(Icons.pause)),
                                )))),
                  ]));
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
}

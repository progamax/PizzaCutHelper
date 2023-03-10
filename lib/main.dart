import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pizza_cut_helper/painters/painters.dart';
import 'package:pizza_cut_helper/widgets/camera_viewer.dart';
import 'package:pizza_cut_helper/widgets/helper_chooser.dart';
import 'package:pizza_cut_helper/widgets/switch_button.dart';

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
  bool frozenPreview = false;
  CutPainterType cutPainterType = CutPainterType.circular;

  @override
  void initState() {
    super.initState();
    futureCameraController = availableCameras().then((value) {
      var controller = CameraController(
          value.where((element) => element.lensDirection == CameraLensDirection.back).first, ResolutionPreset.high);
      return controller.initialize().then((value) => controller);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PizzaCutHelper',
      theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Pizza Cutter Helper"),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: FutureBuilder<CameraController>(
            future: futureCameraController,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var controller = snapshot.data!;
                return Align(
                    alignment: Alignment.topCenter,
                    child: Column(children: <Widget>[
                      Flexible(flex: 4, child: CameraViewer(controller, sliderValue, cutPainterType)),
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
                                builder: (context, constraints) => SwitchButton(const Icon(Icons.play_arrow),
                                    const Icon(Icons.pause), constraints.biggest.height * .85, (activated) {
                                  if (activated) {
                                    controller.resumePreview();
                                  } else {
                                    controller.pausePreview();
                                  }
                                }),
                              )))),
                      Align(
                        alignment: Alignment.center,
                        child: HelperChooser(CutPainterType.values.map((e){
                          switch (e){
                            case CutPainterType.circular:
                              return const Icon(Icons.incomplete_circle);
                            case CutPainterType.grid:
                              return const Icon(Icons.grid_4x4);
                          }
                        }).toList(), size: 56, onSelectedIcon: onSelectedHelper,),
                      )
                    ]));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void onSelectedHelper(int helperIndex) {
    setState(() {
      cutPainterType = CutPainterType.values[helperIndex];
    });
  }
}

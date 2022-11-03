import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'dart:io';

import 'testClassifier.dart';

import 'package:camera/camera.dart';

class FirstPage extends StatefulWidget {
  const FirstPage(
      {Key? key,
      required this.onValueChanged,
      required this.cameras,
      required this.active})
      : super(key: key);

  final void Function(dynamic) onValueChanged;
  final List<CameraDescription> cameras;
  final bool active;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late CameraController controller;
  String pictureFile = "";

  final Test _classifier = Test();

  late List _results;

  late File _image;

  bool _loading = false;

  String prediction = "";

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        )),
        child: Column(
          children: [
            if (!widget.active && !_loading)
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(0 / 360),
                        child: CameraPreview(
                          controller,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    final CameraController cameraController =
                                        controller;
                                    cameraController
                                        .setFlashMode(FlashMode.off);
                                    final a =
                                        await cameraController.takePicture();
                                    var temp = "";

                                    setState(() {
                                      pictureFile = a.path;
                                       _image = File(pictureFile);
                                      _loading = true;
                                    });

                                    temp = await _classifier.predict(_image);
                                    
                                    setState(() {
                                      pictureFile = a.path;
                                      prediction = temp;
                                      _loading = false;
                                      widget.onValueChanged(temp);
                                    });
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 4,
                                              color: Colors.white,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(60)),
                                        width: 80,
                                        height: 80,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(60),
                                        ),
                                        width: 60,
                                        height: 60,
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ),
            if (_loading)
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.file(fit: BoxFit.cover, _image),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Getting Prediction",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ]
                    ),
                  ),
                ),
              ),
            if (widget.active)
              Container(
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * (8 / 13),
                        child: Image.file(fit: BoxFit.cover, File(pictureFile)),
                      ),
                      Text(
                        prediction ?? "",
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ));
  }
}

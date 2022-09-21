import 'package:image/image.dart' as img;
import 'package:carapp/classifier.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:camera/camera.dart';

class FirstPage extends StatefulWidget {
  const FirstPage(
      {Key? key,
      required this.onValueChanged,
      required this.cameras,
      required this.active})
      : super(key: key);

  final void Function() onValueChanged;
  final List<CameraDescription> cameras;
  final bool active;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late CameraController controller;
  String pictureFile = "";

  final Classifier _classifier = Classifier();

  late List _results;

  File? _image;

  var prediction;

  @override
  void initState() {
    super.initState();
    print("redrawing");
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
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final xScale = controller.value.aspectRatio / deviceRatio;

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
            if (!widget.active)
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
                                    widget.onValueChanged();
                                    setState(() {
                                      pictureFile = a.path;
                                      _image = File(pictureFile);

                                      img.Image imageInput = img.decodeImage(
                                          _image!.readAsBytesSync())!;
                                      _classifier.predict(imageInput);
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
                        prediction,
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

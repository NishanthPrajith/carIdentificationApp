import 'dart:typed_data';

import 'package:pytorch_mobile/model.dart';
import 'package:pytorch_mobile/pytorch_mobile.dart';
import 'package:image/image.dart' as img;

import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class Test {

  String? _imagePrediction;
  
  List? _prediction;
  File? _image;

  Future<File> getImageFileFromAssets() async {
    final byteData = await rootBundle.load('assets/car_img.jpeg');

    final file = File('${(await getTemporaryDirectory()).path}/car_img.jpeg');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Future<String> predict(File img) async {
    // File f = await getImageFileFromAssets();

    final meanOurs = [0.485, 0.456, 0.406];
    final stdOurs = [0.229, 0.224, 0.225];

    Model imageModel = await PyTorchMobile.loadModel("assets/models/model_save_actual.pt");

    _imagePrediction = await imageModel!.getImagePrediction(
        img, 300, 300, "assets/labels/labels.csv", mean: meanOurs, std: stdOurs);

    print(_imagePrediction);

    return _imagePrediction ?? "No prediction";
  }
}

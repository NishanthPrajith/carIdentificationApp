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
  String? _imageTwo;
  
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

    Model imageModel = await PyTorchMobile.loadModel("assets/models/test_original.pt");

    Model two = await PyTorchMobile.loadModel("assets/models/model_save_actual.pt");


    final Uint8List image1 =
        (await rootBundle.load("assets/001.jpg")).buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    File image = await File('${tempDir.path}/001.jpg').create();
    image.writeAsBytesSync(image1);

    _imagePrediction = await imageModel!.getImagePrediction(
        img, 300, 300, "assets/labels/labels.csv", mean: meanOurs, std: stdOurs);

    _imageTwo = await two!.getImagePrediction(
        img, 300, 300, "assets/labels/labels.csv", mean: meanOurs, std: stdOurs);

    print(_imagePrediction);
    _imagePrediction = (_imagePrediction ?? "No") + "," + (_imageTwo ?? "No");

    return _imagePrediction ?? "No prediction";
  }
}

import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

import 'package:image/image.dart' as img;
import 'package:logger/logger.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class Classifier {
  late Interpreter interpreter;
  late InterpreterOptions _interpreterOptions;

  var logger = Logger();

  late List<int> _inputShape;
  late List<int> _outputShape;

  late TensorImage _inputImage;
  late TensorBuffer _outputBuffer;

  late TfLiteType _inputType;
  late TfLiteType _outputType;

  final String _labelsFileName = 'assets/label.txt';

  final int _labelsLength = 196;

  late var _probabilityProcessor;

  late List<String> labels;

  String get modelName => 'tflite_model.tflite';

  NormalizeOp get preProcessNormalizeOp => NormalizeOp(0, 255);
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 1);

  Classifier({int? numThreads}) {
    _interpreterOptions = InterpreterOptions();

    if (numThreads != null) {
      _interpreterOptions.threads = numThreads;
    }

    loadModel();
    loadLabels();
  }

  Future<void> loadModel() async {
    try {
      interpreter =
          await Interpreter.fromAsset(modelName, options: _interpreterOptions);
      print('Interpreter Created Successfully');

      _inputShape = interpreter.getInputTensor(0).shape;
      _outputShape = interpreter.getOutputTensor(0).shape;
      _inputType = interpreter.getInputTensor(0).type;
      _outputType = interpreter.getOutputTensor(0).type;

      _outputBuffer = TensorBuffer.createFixedSize(_outputShape, _outputType);
      _probabilityProcessor =
          TensorProcessorBuilder().build();
    } catch (e) {
      print('Unable to create interpreter, Caught Exception: ${e.toString()}');
    }
  }

  Future<void> loadLabels() async {
    labels = await FileUtil.loadLabels(_labelsFileName);
    if (labels.length == _labelsLength) {
      print('Labels loaded successfully');
    } else {
      print('Unable to load labels');
    }
  }

  TensorImage _preProcess() {
    int cropSize = 300;
    return ImageProcessorBuilder()
        .add(ResizeOp(cropSize, cropSize, ResizeMethod.NEAREST_NEIGHBOUR))
        .build()
        .process(_inputImage);
  }

  Future<String> predict(img.Image image) async {
    final Uint8List inputImg = (await rootBundle.load("assets/car_img.jpeg")).buffer.asUint8List();
    final decoder = JpegDecoder();
    img.Image imageInput = img.decodeImage(inputImg)!;
    _inputImage = TensorImage(_inputType);
    _inputImage.loadImage(imageInput);
    _inputImage = _preProcess();

    final decodedBytes = _inputImage.image.getBytes();

    print(_inputImage.getHeight());

    print(decodedBytes.length);

    var convertedBytes = Float32List(1 * 300 * 300 * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < 300; i++) {
      for (var j = 0; j < 300; j++) {
        var pixel = _inputImage.image.getPixel(j, i);

        double red = img.getRed(pixel) / 255.0;
        double green = img.getGreen(pixel) / 255.0;
        double blue = img.getBlue(pixel) / 255.0;

        buffer[pixelIndex++] = (red - 0.485) / 0.229;
        buffer[pixelIndex++] = (green - 0.456) / 0.224;
        buffer[pixelIndex++] = (blue  - 0.406) / 0.225;
      }
    }

    interpreter.run(convertedBytes.buffer, _outputBuffer.getBuffer());

    Map<String, double> labeledProb = TensorLabel.fromList(
            labels, _outputBuffer)
        .getMapWithFloatValue();

    var result = labeledProb.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    print(result);
    /*
    for(String temp: labeledProb.values())
    {
  
     */
    return result[0].key;
  }

  void close() {
    interpreter.close();
  }
}
int compare(MapEntry<String, double> e1, MapEntry<String, double> e2) {
  if (e1.value > e2.value) {
    return -1;
  } else if (e1.value == e2.value) {
    return 0;
  } else {
    return 1;
  }
}
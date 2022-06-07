import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

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

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Future<String> predict(img.Image image) async {
    final Uint8List inputImg = (await rootBundle.load("assets/01126.jpg")).buffer.asUint8List();
    final decoder = JpegDecoder();
    img.Image imageInput = img.decodeImage(inputImg)!;
    _inputImage = TensorImage(_inputType);
    _inputImage.loadImage(imageInput);
    _inputImage = _preProcess();

    final decodedBytes = _inputImage.image.getBytes();

    print(_inputImage.getHeight());

    for(int y = 0; y < 300; y++) {
      for(int x = 0; x < 300; x++) {
        int red = decodedBytes[y*300*3 + x*3];
        int green = decodedBytes[y*300*3 + x*3 + 1];
        int blue = decodedBytes[y*300*3 + x*3 + 2];
        print(red);
        print(green);
        print(blue);
        break;
      }
      break;
    }



    interpreter.run(_inputImage.buffer, _outputBuffer.getBuffer());

    Map<String, double> labeledProb = TensorLabel.fromList(
            labels, _probabilityProcessor.process(_outputBuffer))
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
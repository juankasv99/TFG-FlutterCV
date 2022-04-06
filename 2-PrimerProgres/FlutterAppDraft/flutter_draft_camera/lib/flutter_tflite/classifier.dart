import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_draft_camera/flutter_tflite/recognition.dart';
import 'package:flutter_draft_camera/flutter_tflite/stats.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:image/image.dart' as imageLib;


class Classifier {
  late Interpreter _interpreter;

  late List<String> _labels;

  static const String MODEL_FILE_NAME = 'models/custom_model.tflite';
  static const String LABEL_FILE_NAME = 'models/labels.txt';
  static const int INPUT_SIZE = 1280;
  static const double THRESHOLD = 0.5;

  late List<List<int>> _outputShapes;
  late List<TfLiteType> _outputTypes;

  late ImageProcessor imageProcessor;
  late int padSize;

  static const int NUM_RESULTS = 2;


  Classifier({
    required Interpreter interpreter,
    required List<String> labels,
  }) {
    loadModel(interpreter: interpreter);
    loadLabels(labels: labels);
  }

  void loadModel({required Interpreter interpreter}) async {
    try {
      _interpreter = await Interpreter.fromAsset(
          MODEL_FILE_NAME
        );
      
      var outputTensors = _interpreter.getOutputTensors();
      _outputShapes = [];
      _outputTypes = [];
      outputTensors.forEach((tensor) {
        _outputShapes.add(tensor.shape);
        _outputTypes.add(tensor.type);
      });
    } catch (e) {
      print("Error while creating interpreter: $e");
    }
  }

  void loadLabels({required List<String> labels}) async {
    try {
      _labels = 
        await FileUtil.loadLabels("assets/" + LABEL_FILE_NAME);
    } catch (e) {
      print("Error while loading labels: $e");
    }
  }

  Interpreter get interpreter => _interpreter;

  List<String> get labels => _labels;


  TensorImage getProcessedImage(TensorImage inputImage) {
    padSize = max(inputImage.height, inputImage.width);

    var _inputShape = _interpreter.getInputTensor(0).shape;

    imageProcessor = ImageProcessorBuilder()
      .add(ResizeWithCropOrPadOp(padSize, padSize))
      //.add(NormalizeOp(0, 255))
      .add(CastOp(TfLiteType.uint8))
      .add(ResizeOp(_inputShape[1], _inputShape[2], ResizeMethod.BILINEAR))
      .build();
    
    inputImage = imageProcessor.process(inputImage);
    return inputImage;
  }

  Map<String, dynamic>? predict(imageLib.Image image) {
    var predictStartTime = DateTime.now().millisecondsSinceEpoch;

    if(_interpreter == null) {
      print("Interpreter not initialized");
      return null;
    }


    loadModel(interpreter: interpreter);
    loadLabels(labels: labels);
    var preProcessStart = DateTime.now().millisecondsSinceEpoch;
    TensorImage inputImage = TensorImage.fromImage(image);
    inputImage = getProcessedImage(inputImage);

    var preProcessElapsedTime = 
      DateTime.now().millisecondsSinceEpoch - preProcessStart;

    TensorBuffer outputLocations = TensorBufferFloat(_outputShapes[0]);
    //TensorBuffer outputClasses = TensorBufferFloat(_outputShapes[1]);
    //TensorBuffer outputScores = TensorBufferFloat(_outputShapes[2]);
    //TensorBuffer numLocations = TensorBufferFloat(_outputShapes[3]);


    List<Object> inputs = [inputImage.buffer];
    

    Map<int, Object> outputs = {
      0: outputLocations.buffer,
      //1: outputClasses.buffer,
      //2: outputScores.buffer,
      //3: numLocations.buffer,
    };


    var inferenceTimeStart = DateTime.now().millisecondsSinceEpoch;
    //_interpreter.allocateTensors();

    _interpreter.run(inputImage.buffer, outputs);

    //_interpreter.runForMultipleInputs(inputs, outputs);


    var inferenceTimeElapsed =
      DateTime.now().millisecondsSinceEpoch - inferenceTimeStart;

    //int resultsCount = min(NUM_RESULTS, numLocations.getIntValue(0));
    int resultsCount = min(NUM_RESULTS, outputLocations.getIntValue(0));

    int labelOffset = 1;

    /* List<Rect> locations = BoundingBoxUtils.convert(
      tensor: outputLocations,
      valueIndex: [1, 0, 3, 2],
      boundingBoxAxis: 2,
      boundingBoxType: BoundingBoxType.BOUNDARIES,
      coordinateType: CoordinateType.RATIO,
      height: INPUT_SIZE,
      width: INPUT_SIZE,
    ); */

    List<Recognition> recognitions = [];

    for(int i = 0; i < resultsCount; i++) {
      //var score = outputScores.getDoubleValue(i);
      var score = outputLocations.getDoubleValue(i);

      //var labelIndex = outputClasses.getIntValue(i) + labelOffset;
      var labelIndex = outputLocations.getIntValue(i) + labelOffset;
      var label = _labels.elementAt(labelIndex);

      if(score > THRESHOLD) {
        Rect transformedRect = imageProcessor.inverseTransformRect(Rect.zero, image.height, image.width);

        recognitions.add(Recognition(i, label, score, transformedRect),);
      }
    }

    var predictElapsedTime = 
      DateTime.now().millisecondsSinceEpoch - predictStartTime;
    
    return {
      "recognitions": recognitions,
      "stats": Stats(
        totalPredictTime: predictElapsedTime,
        inferenceTime: 3,
        preProcessingTime: preProcessElapsedTime)
      
    };

    
  }

  //Interpreter get interpreter => _interpreter;

  //List<String> get labels => _labels;

}
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class NewStaticImage extends StatefulWidget {
  const NewStaticImage({ Key? key }) : super(key: key);

  @override
  State<NewStaticImage> createState() => _NewStaticImageState();
}

class _NewStaticImageState extends State<NewStaticImage> {

  bool _busy = false;
  File ?_image;
  final picker = ImagePicker();
  Interpreter? _interpreter;
  late ImageProcessor _imageProcessor;
  late List<String> _labels;
  late List<List<int>> _outputShapes;
  late List<TfLiteType> _outputTypes;

  loadTfModel() async {
    _interpreter = await Interpreter.fromAsset("models/custom_model.tflite");
    //return interpreter;

    setState(() {
      _busy = false;
    });
  }

  loadTfImgProcessor(){
    ImageProcessor imageProcessor = ImageProcessorBuilder()
      .add(ResizeOp(1280, 1280, ResizeMethod.NEAREST_NEIGHBOUR))
      .build();
    return imageProcessor;
  }

  loadTfLabels() async {
    _labels = await FileUtil.loadLabels("assets/models/labels.txt");
  }

  loadtfOutputs() async {
    var outputTensors = await _interpreter!.getOutputTensors();
    _outputShapes = [];
    _outputTypes = [];
    outputTensors.forEach((tensor) {
      _outputShapes.add(tensor.shape);
      _outputTypes.add(tensor.type);
    });
    
    return [_outputShapes, _outputTypes];
  }



  @override
  void initState() {
    super.initState();
    _busy = true;

    loadTfModel();
    loadTfLabels();



  _imageProcessor = loadTfImgProcessor();
  loadTfLabels().then((val){{
    _labels = val;
    setState(() {
      //_busy = false;
    });
  }});
  loadtfOutputs().then((val){{
    _outputShapes = val[0];
    _outputTypes = val[1];
    setState(() {
      //_busy = false;
    });
  }});
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;



    List<Widget> stackChildren = [];

    stackChildren.add(
      Positioned(
        child: _image == null ?
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Please Select an Image"),
            ],
          ),
        )
      :
        Container(
          child: Image.file(_image!),
        ),
      )
    );

    //stackChildren.addAll(renderBoxes(size));

    if(_busy) {
      stackChildren.add(
        Center(
          child: CircularProgressIndicator(),
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Object Detector"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "Fltbtn2",
            child: Icon(Icons.camera_alt),
            onPressed: () => getImageFromGallery(_interpreter!),
          ),
          SizedBox(width: 10,),
          FloatingActionButton(
            heroTag: "Fltbtn1",
            child: Icon(Icons.photo),
            onPressed: () => getImageFromGallery(_interpreter!),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: stackChildren,
        ),
      ),
    );
  }

  Future getImageFromGallery(Interpreter interpreter) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Selected");
      }
    });
    try{
      TensorImage tensorImage = TensorImage.fromFile(_image!);
      tensorImage = _imageProcessor.process(tensorImage);
      TensorBuffer probabilityBuffer = TensorBuffer.createFixedSize(<int>[1,25200,70], TfLiteType.uint8);
      runModel(tensorImage.buffer, probabilityBuffer.buffer);
      //interpreter.run(tensorImage.buffer, probabilityBuffer.buffer);



      TensorProcessor? probabilityProcessor = TensorProcessorBuilder().add(DequantizeOp(0, 1 / 25500.0)).build() as TensorProcessor?;
      TensorLabel tensorLabel = TensorLabel.fromList(_labels, probabilityProcessor!.process(probabilityBuffer));
      Map<String, double> doubleMap = tensorLabel.getMapWithFloatValue();
      print(doubleMap);

    } catch (e) {
      print("Error loading the model: " + e.toString());
    }
  }

  void runModel(ByteBuffer buffer, ByteBuffer buffer2) async {
    try {
      _labels = await FileUtil.loadLabels("assets/models/labels.txt");
      _interpreter = await Interpreter.fromAsset("models/custom_model.tflite");
      _interpreter?.run(buffer, buffer2);
    } catch (e) {
      print("Error loading model: " + e.toString());
    }
    
  }
}

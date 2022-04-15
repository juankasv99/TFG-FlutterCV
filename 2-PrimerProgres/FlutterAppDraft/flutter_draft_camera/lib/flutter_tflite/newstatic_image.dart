// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:pytorch_mobile/model.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
// import 'package:image/image.dart' as imageLib;
// import 'package:pytorch_mobile/pytorch_mobile.dart';

// import 'classifier.dart';

// class NewStaticImage extends StatefulWidget {
//   const NewStaticImage({ Key? key }) : super(key: key);

//   @override
//   State<NewStaticImage> createState() => _NewStaticImageState();
// }

// class _NewStaticImageState extends State<NewStaticImage> {

//   bool _busy = false;
//   File ?_image;
//   final ImagePicker _picker = ImagePicker();
//   Interpreter? _interpreter;
//   late ImageProcessor _imageProcessor;
//   late List<String> _labels;
//   late List<List<int>> _outputShapes;
//   late List<TfLiteType> _outputTypes;

//   late Model customModel;

//   late Classifier classifier;

//   loadTfModel() async {
//     Interpreter interpreter = await Interpreter.fromAsset("models/custom_model.tflite");
//     return interpreter;
//   }

//   loadTfImgProcessor(){
//     ImageProcessor imageProcessor = ImageProcessorBuilder()
//       .add(ResizeOp(1280, 1280, ResizeMethod.NEAREST_NEIGHBOUR))
//       .build();
//     return imageProcessor;
//   }

//   loadTfLabels() async {
//     List<String> labels = await FileUtil.loadLabels("assets/models/labels.txt");
//     return labels;
//   }

//   loadtfOutputs() async {
//     var outputTensors = await _interpreter!.getOutputTensors();
//     _outputShapes = [];
//     _outputTypes = [];
//     outputTensors.forEach((tensor) {
//       _outputShapes.add(tensor.shape);
//       _outputTypes.add(tensor.type);
//     });
    
//     return [_outputShapes, _outputTypes];
//   }

//   Future<Model> loadCustomModel() async {
//     Model cm = await PyTorchMobile.loadModel('assets/models/best.pt');
//     return cm;
//   }



//   @override
//   void initState() {
//     super.initState();
//     _busy = true;

//     //customModel = loadCustomModel() as Model;
//     //_busy = false;

//      loadCustomModel().then((val) {{
//        customModel = val;

       

//        setState(() {
//          _busy = false;
//        });
//      }});

//     loadTfModel().then((val) {{
//       _interpreter = val;
//       _imageProcessor = loadTfImgProcessor();
//       _labels = loadTfLabels();
//       var tmp = loadtfOutputs();
//       _outputShapes = tmp[0];
//       _outputTypes = tmp[1];
//       classifier = Classifier(interpreter: _interpreter!, labels: _labels);

//       setState(() {
//         _busy = false;
//       });
//     }});
//   //   loadTfImgProcessor().then((val){{
//   //     _imageProcessor = val;
//   //     setState(() {
//   //       //_busy = false;
//   //     });
//   //   }});
//   // loadTfLabels().then((val){{
//   //   _labels = val;
//   //   setState(() {
//   //     //_busy = false;
//   //   });
//   // }});
//   // loadtfOutputs().then((val){{
//   //   _outputShapes = val[0];
//   //   _outputTypes = val[1];
//   //   setState(() {
//   //     //_busy = false;
//   //   });
//   // }});
//   }



//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;



//     List<Widget> stackChildren = [];

//     stackChildren.add(
//       Positioned(
//         child: _image == null ?
//         Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text("Please Select an Image"),
//             ],
//           ),
//         )
//       :
//         Container(
//           child: Image.file(_image!),
//         ),
//       )
//     );

//     //stackChildren.addAll(renderBoxes(size));

//     if(_busy) {
//       stackChildren.add(
//         Center(
//           child: CircularProgressIndicator(),
//         )
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Object Detector"),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           FloatingActionButton(
//             heroTag: "Fltbtn2",
//             child: Icon(Icons.camera_alt),
//             onPressed: () => getImageFromGallery(_interpreter!),
//           ),
//           SizedBox(width: 10,),
//           FloatingActionButton(
//             heroTag: "Fltbtn1",
//             child: Icon(Icons.photo),
//             onPressed: () => getImageFromGallery(_interpreter!),
//           ),
//         ],
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         child: Stack(
//           children: stackChildren,
//         ),
//       ),
//     );
//   }

//   Future getImageFromGallery(Interpreter interpreter) async {
//     //final pickedFile = await picker.getImage(source: ImageSource.gallery);
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if(pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print("No Image Selected");
//       }
//     });
//     try{
//       classifier = Classifier(interpreter: _interpreter!, labels: ["1","2","3"]);
//       final path = pickedFile!.path;
//       final bytes = await File(path).readAsBytes();
//       final imageLib.Image? image = imageLib.decodeImage(bytes);
//       var prediction = classifier.predict(image!);
//       print(prediction.toString());

//       // getPrediction(customModel, _image).then((val) {
//       //   prediction = val;

//       //   print(prediction);
//       // });
      
      




//       // TensorImage tensorImage = TensorImage.fromFile(_image!);
//       // tensorImage = _imageProcessor.process(tensorImage);
//       // TensorBuffer probabilityBuffer = TensorBuffer.createFixedSize(<int>[1, 70], TfLiteType.uint8);
//       // interpreter.run(tensorImage.buffer, probabilityBuffer.buffer);

//       // TensorProcessor? probabilityProcessor = TensorProcessorBuilder().add(DequantizeOp(0, 1 / 25500.0)).build() as TensorProcessor?;
//       // TensorLabel tensorLabel = TensorLabel.fromList(_labels, probabilityProcessor!.process(probabilityBuffer));
//       // Map<String, double> doubleMap = tensorLabel.getMapWithFloatValue();
//       // print(doubleMap);

//     } catch (e) {
//       print("Error loading the model: " + e.toString());
//     }
//   }
// }


// Future getPrediction(customModel, image) async {
//   String prediction = await customModel.getImagePrediction(image!, 1280, 1280, 'assets/models/labels.txt') as String;

//   return prediction;
// }

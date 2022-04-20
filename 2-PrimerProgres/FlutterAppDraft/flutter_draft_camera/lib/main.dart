import 'dart:convert';
import 'dart:io';
import 'package:flutter_draft_camera/firebase_options.dart';
import 'package:flutter_draft_camera/new_classification/classifier_quant.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_draft_camera/new_classification/classifier.dart';
import 'package:flutter_draft_camera/new_classification/classifier_float.dart';
import 'package:logger/logger.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Classification',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Classifier _classifier;

  var logger = Logger();

  File? _image;
  final picker = ImagePicker();

  Image? _imageWidget;

  img.Image? fox;

  Category? category;

  FirebaseModelDownloader downloader = FirebaseModelDownloader.instance;
  
  FirebaseCustomModel ?_model;
  List<FirebaseCustomModel> ?_models;

  String uploadURL = 'http://192.168.1.43:5000/predict';

  @override
  void initState() {
    super.initState();
    _classifier = ClassifierQuant();
    //getCloudModel();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);

      

      _predict();
    });
  }


  Future getCameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);//, maxHeight: 1280, maxWidth: 1280,);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);

      _predict();
    });
  }

  void _predict() async {
    category = null;
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    //var pred = _classifier.predict(imageInput);
    var uri = Uri.parse(uploadURL);
    var request = new http.MultipartRequest("POST", uri);
    request.files.add(new http.MultipartFile.fromBytes("file", _image!.readAsBytesSync(), filename: "Photo.jpg", contentType: new MediaType("image", "jpg")));

    var response = await request.send();
    Map ?parsed;
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      parsed = json.decode(value);

      setState(() {
        this.category = Category(parsed!["prediction"], parsed!["confidence"]);
      });
    });

    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TFG-FlutterCV',
            style: TextStyle(color: Colors.black87)),
        backgroundColor: Color(0xFFF9dffb0),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Center(
            child: _image == null
                ? Text('No image selected.')
                : Container(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 2),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: _imageWidget,
                  ),
          ),
          SizedBox(
            height: 36,
          ),
          Text(
            category != null ? category!.label : '',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            category != null
                ? 'Confidence: ${category!.score.toStringAsFixed(3)}'
                : '',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Color(0xFFF81f1f7),
            heroTag: "Fltbtn2",
            onPressed: getImage,
            tooltip: 'Pick Image',
            child: Icon(Icons.add_a_photo),
          ),
          SizedBox(width: 10,),
          FloatingActionButton(
            backgroundColor: Color(0xFFF81f1f7),
            heroTag: "Fltbtn1",
            onPressed: getCameraImage,
            child: Icon(Icons.camera_alt),
          ),
        ],
      ),
      backgroundColor: Colors.amber[100]
       
    );
  }

  void getCloudModel() async {
    _model = await FirebaseModelDownloader.instance.getModel("AC-Art-Detector", FirebaseModelDownloadType.latestModel);
    _models = await FirebaseModelDownloader.instance.listDownloadedModels();
  }
}

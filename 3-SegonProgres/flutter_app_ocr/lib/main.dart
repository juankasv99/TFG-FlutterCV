import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:path_provider/path_provider.dart';



void main(){

  
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

  var logger = Logger();

  File? _image;
  final picker = ImagePicker();

  Image? _imageWidget;

  img.Image? fox;

  String uploadURL = 'http://192.168.1.43:5000/predict';
  String? path;

  @override
  void initState() {
    super.initState();
  }

  Future getImage() async {
    //final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    path = image!.path;

    final Directory copy_dic = await getApplicationDocumentsDirectory();
    
    

    //image.saveTo(path!);
    //image.saveTo('./assets/temp.jpg');

    setState(() {
      _image = File(image.path);
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
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    // //var pred = _classifier.predict(imageInput);
    // var uri = Uri.parse(uploadURL);
    // var request = new http.MultipartRequest("POST", uri);
    // request.files.add(new http.MultipartFile.fromBytes("file", _image!.readAsBytesSync(), filename: "Photo.jpg", contentType: new MediaType("image", "jpg")));

    // var response = await request.send();
    // Map ?parsed;
    // print(response.statusCode);
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    //   parsed = json.decode(value);

    //   setState(() {
        
    //   });
    // });

    String text = await FlutterTesseractOcr.extractText(path!, language: 'spa+eng',
          args: {
            "psm": "12",
            "preserve_interword_spaces": "0",
          });

    print(text);
    
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
          Text("test",
            //category != null ? category!.label : '',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            // category != null
            //     ? 'Confidence: ${category!.score.toStringAsFixed(3)}'
            //     : '',
            "test",
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
}

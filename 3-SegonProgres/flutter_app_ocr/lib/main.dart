import 'dart:convert';
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
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
  bool textScanning = false;

  String OCRtext = "";
  String prediction = "";

  img.Image? fox;

  String uploadURL = 'http://192.168.1.43:5000/predict';
  String? path;

  List<String> fishList = ['carpín',
'pez dorado',
'amarguillo',
'cacho',
'leucisco',
'carpa',
'koi',
'pez telescopio',
'killi',
'cangrejo de río',
'tortuga caparazón blando',
'renacuajo',
'rana',
'gobio de río',
'locha',
'siluro',
'pez cabeza de serpiente',
'pez sol',
'perca amarilla',
'perca',
'lucio',
'eperlano',
'ayu',
'salmón japonés',
'trucha',
'taimén',
'salmón',
'salmón real',
'cangrejo de Shanghái',
'gupi',
'pez doctor',
'pez ángel',
'tetra neón',
'piraña',
'arowana',
'dorado',
'pez caimán',
'pirarucú',
'bichir ensillado',
'mariposa marina',
'caballito de mar',
'pez payaso',
'pez cirujano',
'pez mariposa',
'pez napoleón',
'pez león',
'pez globo',
'pez erizo',
'jurel',
'dorada japonesa',
'lubina',
'pargo rojo',
'gallo',
'rodaballo',
'calamar',
'morena',
'anguila de listón azul',
'pez balón',
'atún',
'pez espada',
'jurel gigante',
'raya',
'pez luna',
'pez martillo',
'tiburón',
'pez sierra',
'tiburón ballena',
'pez remo',
'celacanto',
'esturión',
'tilapia',
'betta',
'tortuga mordedora',
'trucha dorada',
'pez arcoíris',
'boquerón',
'lampuga',
'rémora',
'pez cabeza transparente',
'ranchú'];


  List<String> insectList = ['cigarra marrón',
'mariposa tigre',
'mariposa alas de Brooke',
'libélula roja',
'mariposa alas de pájaro',
'zapatero',
'hormiga',
'cochinilla',
'cochinilla de arena',
'polilla',
'escarabajo nadador',
'libélula caballito del diablo',
'goliat',
'mosca',
'mantis orquídea',
'escarabajo tigre',
'escarabajo astado hércules',
'cigarrilla',
'esc. ciervo cyclommatus',
'luciérnaga',
'escarabajo pelotero',
'langosta',
'mosquito',
'mantis religiosa',
'chinche',
'longicornio asiático',
'mariposa bianor',
'caracol',
'escarabajo astado japonés',
'saltamontes',
'escarabajo geotrúpido',
'escarabajo astado atlas',
'insecto hoja',
'grillo común',
'cigarra gigante',
'araña',
'mariposa narciso',
'cigarra oriental',
'oruga de bolsón',
'abeja melífera',
'escarabajo ciervo Miyama',
'mariposa colias',
'mariposa común',
'mariposa celeste',
'ciempiés',
'insecto palo',
'escarabajo ciervo arcoíris',
'escarabajo ciervo sierra',
'pulga',
'grillo cebollero',
'libélula tigre',
'mariposa monarca',
'escarabajo ciervo gigante',
'escarabajo ciervo tornasol',
'escarabajo oro',
'escorpión',
'muda de cigarra',
'grillo campana',
'avispa',
'langosta alargada',
'escarabajo joya',
'tarántula',
'mariquita',
'langosta migratoria',
'cigarra común',
'escarabajo violín',
'cangrejo ermitaño',
'polilla atlas',
'escarabajo astado elefante',
'mariposa triángulo azul',
'mariposa cometa de papel',
'marip. emperador japonés',
'escarabajo verde japonés',
'escarabajo ciervo jirafa',
'chinche con rostro humano',
'polilla crepuscular',
'gorgojo azul',
'escarabajo rosalia batesi',
'chinche acuática gigante',
'libélula damisela',];

  @override
  void initState() {
    super.initState();
  }

  Future getImage() async {
    prediction = "";
    //final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    

    //image.saveTo(path!);
    //image.saveTo('./assets/temp.jpg');
    textScanning = true;
    setState(() {
      _image = File(image!.path);
      _imageWidget = Image.file(_image!);

      

      _predict();
    });
  }


  Future getCameraImage() async {
    prediction = "";
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
      _imageWidget = Image.file(_image!);

      _predict();
    });
  }

  void _predict() async {
    //img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;

    final inputImage = InputImage.fromFilePath(_image!.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    RecognizedText recognisedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    String scannedText = "";

    for(TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }

    textScanning = false;

    print(scannedText);
    var encoded = utf8.encode(scannedText.replaceAll("\n", " ").toLowerCase());
    OCRtext = utf8.decode(encoded);


    getResult();

    setState(() {
      
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
          Text(prediction != "" ? prediction : "",
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

  void getResult() {
    for (var i = 0; i < fishList.length; i++) {
      if(OCRtext.contains(fishList[i])) {
        prediction = fishList[i];
        break;
      }
    }
    if(prediction == "") {
      for (var i = 0; i < insectList.length; i++) {
        if(OCRtext.contains(insectList[i])) {
          prediction = insectList[i];
          break;
        }
      }
    }
  }
}

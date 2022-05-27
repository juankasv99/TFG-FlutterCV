import 'package:final_app/model/art_model.dart';
import 'package:final_app/model/fishes_model.dart';
import 'package:final_app/model/sea_model.dart';
import 'package:final_app/network/network.dart';
import 'package:final_app/ui/art_info.dart';
import 'package:final_app/ui/art_list.dart';
import 'package:final_app/ui/fish_list.dart';
import 'package:final_app/ui/sea_list.dart';
import 'package:flutter/material.dart';
import 'package:final_app/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:final_app/ui/insect_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

import 'package:final_app/model/insects_model.dart';


class Category {
  String _label;
  double _score;

  Category(this._label, this._score);

  /// Gets the reference of category's label.
  String get label => _label;

  /// Gets the score of the category.
  double get score => _score;

  @override
  bool operator ==(Object o) {
    if (o is Category) {
      return (o.label == _label && o.score == _score);
    }
    return false;
  }
}

class ACNHapp extends StatefulWidget {
  const ACNHapp({Key? key}) : super(key: key);

  @override
  State<ACNHapp> createState() => _ACNHappState();
}

class _ACNHappState extends State<ACNHapp> {


  int _selectedIndex = 0;
  String _selectedIndexName = "Insects";

  Map<String, Insects>? _insectObject;
  Map<String, Fishes>? _fishObject;
  Map<String, Sea>? _seaObject;
  Map<String, Art>? _artObject;

  bool _isInsectLoaded = false;
  bool _isFishLoaded = false;
  bool _isSeaLoaded = false;
  bool _isArtLoaded = false;

  List<bool> _insectChecks = List.filled(80, false);
  List<bool> _insectMuseumChecks = List.filled(80, false);
  List<bool> _fishChecks = List.filled(80,false);
  List<bool> _fishMuseumChecks = List.filled(80,false);
  List<bool> _seaChecks = List.filled(40, false);
  List<bool> _seaMuseumChecks = List.filled(40, false);
  List<bool> _artChecks = List.filled(43, false);
  List<bool> _artMuseumChecks = List.filled(43, false);

  static const Map<int, String> titlesInIndex = {
    0: "Insects",
    1: "Fishes",
    2: "Home",
    3: "Deep-Sea",
    4: "Art"
  };

  static const List artPredictionNames = [
    
    "VitruvianMan",
    "NightWatch",
    "Doguu",
    "BlueBoy",
    "Milo",
    "SundayOn",
    "Gleaners",
    "Ajisaisoukeizu",
    "Kanagawa",
    "Thinker",
    "MonaLisa",
    "Sunflower",
    "David",
    "FightingTemeraire",
    "Mikaeri",
    "Kamehameha",
    "RosettaStone",
    "Summer",
    "Slower",
    "Capitolini",
    "BirthVenus",
    "IsleOfDead",
    "Nefertiti",
    "FifePlayer",
    "AppleOrange",
    "BarFB",
    "Milkmaid",
    "Diskobolos",
    "OlmecaHead",
    "OotaniOniji",
    "HunterSnow",
    "PortraitCecilia",
    "Ophelia",
    "LasMeninas",
    "HoumuwuDing",
    "StarryNight",
    "Samothrace",
    "ClothedMaja",
    "Heibayo",
    "Raijin",
    "Fuujin",
    "PearlEarring",
    "LibertyLeading",
  ];

  static const List statues = [
    "Doguu",
    "DoguuFake",
    "Milo",
    "MiloFake",
    "Thinker",
    "David",
    "DavidFake",
    "Kamehameha",
    "RosettaStone",
    "RosettaStoneFake",
    "Capitolini",
    "CapitoliniFake",
    "Nefertiti",
    "NefertitiFake",
    "Diskobolos",
    "DiskobolosFake",
    "OlmecaHead",
    "OlmecaHeadFake",
    "HoumuwuDing",
    "HoumuwuDingFake",
    "Samothrace",
    "SamothraceFake",
    "Heibayo",
    "HeibayoFake",
  ];

  bool textScanning = false;

  

  File? _image;
  final picker = ImagePicker();

  Category? category;
  String uploadURL = 'http://192.168.1.43:5000/predict';
  String uploadOCRURL = 'http://192.168.1.43:5000/predictocr';

  @override
  void initState() {
    super.initState();
    _insectObject = getInsects();
    _fishObject = getFishes();
    _seaObject = getSea();
    _artObject = getArt();
  }

  

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
    _isInsectLoaded ? insectList(insects:_insectObject!, checks:_insectChecks, notifyParent: refreshInsects,) : Center(child: const CircularProgressIndicator()),
    _isFishLoaded ? fishList(fishes:_fishObject!, checks:_fishChecks, notifyParent: refreshFishes,) : Center(child: const CircularProgressIndicator()),
    Container(child: Text("HOME"),),
    _isSeaLoaded ? seaList(sea:_seaObject!, checks:_seaChecks, notifyParent: refreshSea,) : Center(child: const CircularProgressIndicator()),
    _isArtLoaded ? artList(notifyParent: refreshArt, checks: _artChecks, art: _artObject!) : Center(child: CircularProgressIndicator(),)
    
  ];

    List<Function?> galleryFunctions = [
      getOCRImage,
      getOCRImage,
      getArtImage,
      getOCRImage,
      getArtImage,
    ];

    List<Function?> cameraFunctions = [
      getOCRCameraImage,
      getOCRCameraImage,
      getArtCameraImage,
      getOCRCameraImage,
      getArtCameraImage,
    ];


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF94cead),
        title: Text(_selectedIndexName),
      ),

      //_isInsectLoaded ? insectList(_insectObject, _insectChecks) : Center(child: const CircularProgressIndicator()),
      body: Container(
        color: Colors.orange[50],
        child: _widgetOptions.elementAt(_selectedIndex),
        //child: _isInsectLoaded ? insectList(insects:_insectObject!, checks:_insectChecks, notifyParent: refreshInsects,) : Center(child: const CircularProgressIndicator()),
        //child: _isFishLoaded ? fishList(fishes:_fishObject!, checks:_fishChecks, notifyParent: refreshFishes,) : Center(child: const CircularProgressIndicator()),
      ),

      floatingActionButton: _selectedIndex == 2 ? null : Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              backgroundColor: Color(0xFF91d7db),
              heroTag: "Fltbtn2",
              onPressed: () => galleryFunctions[_selectedIndex]!(),
              tooltip: 'Pick Image',
              child: Icon(Icons.photo),
            ),
            SizedBox(width: 10,),
            FloatingActionButton(
              backgroundColor: Color(0xFF91d7db),
              heroTag: "Fltbtn1",
              onPressed: () => cameraFunctions[_selectedIndex]!(),
              child: Icon(Icons.camera_alt),
          ),
          ]
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        backgroundColor: Color(0xFF91d7db),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bug),
            label: "Insects"),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.fish),
            label: "Fishes"),
          BottomNavigationBarItem(
            activeIcon: Icon(FontAwesomeIcons.house),
            icon: Icon(FontAwesomeIcons.house, color: Colors.black54),
            label: "Home",),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.personSwimming),
            label: "Deep-Sea"),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.palette),
            label: "Art"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal[900],
        unselectedItemColor: Colors.grey[100],
        onTap: _onItemTapped,
        elevation: 10,
      ),
    );
  }

  Future getArtImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);

      _predictArt();
    });
  }

  Future getArtCameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    File image = new File(pickedFile!.path);
    
    setState(() {
      _image = File(pickedFile.path);

      _predictArt();
    });
  }

  void _predictArt() async {
    category = null;
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;

    var uri = Uri.parse(uploadURL);
    var request = http.MultipartRequest("POST", uri);
    request.files.add(new http.MultipartFile.fromBytes("file", _image!.readAsBytesSync(), filename: "Photo.jpg", contentType: new MediaType("image", "jpg")));

    var response = await request.send();
    Map ?parsed;
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      parsed = json.decode(value);

      setState(() {
        this.category = Category(parsed!["prediction"], 1.0);

        if(category != null){
          showDialog(context: context, barrierDismissible: false, builder: (context){
            return Dialog(
            elevation: 5,
            backgroundColor: Colors.orange[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
            ),
            child: Container(
              height: 500,
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Prediction",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0
                    ),),
                  //category!._label.contains("Fake") ?  Image.network(_artObject![category!._label]!.artFakeUri!) : Image.network(_artObject![category!._label]!.artUri!),
                  statues.contains(category!._label) ?
                  Image.network("https://acnhcdn.com/latest/FtrIcon/FtrSculpture${category!.label}.png")
                  :
                  Image.network("https://acnhcdn.com/art/FtrArt${category!.label}.png"),
                  category!._label.contains("Fake") ?
                  RichText(text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(FontAwesomeIcons.triangleExclamation, color: Colors.red[900], size: 18,)
                      ),
                      TextSpan(
                        text: "  " + category!._label + "  ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        )
                      ),
                      WidgetSpan(
                        child: Icon(FontAwesomeIcons.triangleExclamation, color: Colors.red[900], size: 18,)
                      ),
                    ]
                  ))
                  :
                  Text(category!._label),
                  Text("Is this correct?",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w100
                    ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    SizedBox(
                      height: 35,
                      width: 100,
                      child: ElevatedButton(
                      onPressed: (){
                        print(_artObject![_artObject!.keys.elementAt(artPredictionNames.indexOf(category!._label.replaceAll("Fake", "")))]!.name.nameEUen);
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => artInfoPage(art: _artObject![_artObject!.keys.elementAt(artPredictionNames.indexOf(category!._label.replaceAll("Fake", "")))]!, artChecks: _artChecks, artMuseumChecks: _artMuseumChecks, notifyParent: updateArtChecks,)
                        )
                        );
                      },
                      child: Text("Yes"),
                      style: ButtonStyle(
                        
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF91d7db))
                      ),),
                    ),
                    
                    SizedBox(width: 20.0,),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text("No"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red[700]!)
                      ),),
                  ],),
                  
                  
                ],
              ),
            ),

          );
          });
          
        }
      });
    });

    
    
    
  }

  Future getOCRImage() async {
    //prediction = "";
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    textScanning = true;
    setState(() {
      _image = File(image!.path);

      _predictOCR();
    });
  }

  Future getOCRCameraImage() async {
    //prediction = "";
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);

      _predictOCR();
    });
  }

  void _predictOCR() async {
    category = null;
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;

    var uri = Uri.parse(uploadOCRURL);
    var request = http.MultipartRequest("POST", uri);
    request.files.add(new http.MultipartFile.fromBytes("file", _image!.readAsBytesSync(), filename: "Photo.jpg", contentType: new MediaType("image", "jpg")));

    var response = await request.send();
    Map ?parsed;
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      parsed = json.decode(value);

      setState(() {
        this.category = Category(parsed!["prediction"], 1.0);

        if(category != null) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Dialog(
                elevation: 5,
                backgroundColor: Colors.orange[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: Container(
                  height: 500,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Prediction",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0
                        ))
                    ],
                  ),
                ),
              );
            }
          );
        }
      });
    });
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
      _selectedIndexName = titlesInIndex[value].toString();
      print(_selectedIndex);
    });
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:  (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      });
  }
  
  getInsects() {
    Future.delayed(Duration(seconds: 2), () {
      Network.getInsects().then((result) {
        print(result);
        setState(() {
          _insectObject = result;
          _isInsectLoaded = true;
        });
      });
    });
  } 

  refreshInsects(dynamic childValue) {
    setState(() {
      _insectChecks = childValue;
    });
  }
  
  getFishes() {
    Future.delayed(Duration(seconds: 2), () {
      Network.getFishes().then((result) {
        print(result);
        setState(() {
          _fishObject = result;
          _isFishLoaded = true;
        });
      });
    });
  }

  refreshFishes(dynamic childValue) {
    setState(() {
      _fishChecks = childValue;
    });
  }
  
  getSea() {
    Future.delayed(Duration(seconds: 2), () {
      Network.getSea().then((result) {
        print(result);
        setState(() {
          _seaObject = result;
          _isSeaLoaded = true;
        });
      });
    });
  }

  refreshSea(dynamic childValue) {
    setState(() {
      _seaChecks = childValue;
    });
  }
  
  getArt() {
    Future.delayed(Duration(seconds: 2), () {
      Network.getArt().then((result) {
        print(result);
        setState(() {
          _artObject = result;
          _isArtLoaded = true;
        });
      });
    });
  }

  refreshArt(dynamic childValue) {
    setState(() {
      _artChecks = childValue;
    });
  }

  updateArtChecks(dynamic childValue1, dynamic childValue2) {
    Future.delayed(Duration(seconds:1), () async {
      setState(() {
      _artChecks = childValue1;
      _artMuseumChecks = childValue2;
    });
    });
    
  }
}

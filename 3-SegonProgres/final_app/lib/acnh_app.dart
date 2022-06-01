import 'package:final_app/model/art_model.dart';
import 'package:final_app/model/fishes_model.dart';
import 'package:final_app/model/sea_model.dart';
import 'package:final_app/network/network.dart';
import 'package:final_app/ui/art_info.dart';
import 'package:final_app/ui/art_list.dart';
import 'package:final_app/ui/fish_info.dart';
import 'package:final_app/ui/fish_list.dart';
import 'package:final_app/ui/insect_info.dart';
import 'package:final_app/ui/sea_info.dart';
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
import 'package:percent_indicator/percent_indicator.dart';

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

  //OUTDATED
  static const List oldfishes = ['crucian_carp', 'goldfish', 'bitterling', 'pale_chub', 'dace', 'carp', 'koi', 'pop-eyed_goldfish', 'killifish', 'crawfish', 'soft-shelled_turtle', 'tadpole', 'frog', 'freshwater_goby', 'loach', 'catfish', 'giant_snakehead', 'bluegill', 'yellow_perch', 'black_bass', 'pike', 'pond_smelt', 'sweetfish', 'cherry_salmon', 'char', 'stringfish', 'salmon', 'king_salmon', 'mitten_crab', 'guppy', 'nibble_fish', 'angelfish', 'neon_tetra', 'piranha', 'arowana', 'dorado', 'gar', 'arapaima', 'saddled_bichir', 'sea_butterfly', 'sea_horse', 'clownfish', 'surgeonfish', 'butterfly_fish', 'napoleonfish', 'zebra_turkeyfish', 'blowfish', 'puffer_fish', 'horse_mackerel', 'barred_knifejaw', 'sea_bass', 'red_snapper', 'dab', 'olive_flounder', 'squid', 'moray_eel', 'ribbon_eel', 'football_fish', 'tuna', 'blue_marlin', 'giant_trevally', 'ray', 'ocean_sunfish', 'hammerhead_shark', 'great_white_shark', 'saw_shark', 'whale_shark', 'oarfish', 'coelacanth', 'sturgeon', 'tilapia', 'betta', 'snapping_turtle', 'golden_trout', 'rainbowfish', 'anchovy', 'mahi-mahi', 'suckerfish', 'barreleye', 'ranchu_goldfish'];
  static const List oldinsects = ['brown_cicada', 'tiger_butterfly', 'rajah_brookes_birdwing', 'red_dragonfly', 'queen_alexandras_birdwing', 'pondskater', 'ant', 'pill_bug', 'wharf_roach', 'moth', 'diving_beetle', 'darner_dragonfly', 'goliath_beetle', 'fly', 'orchid_mantis', 'tiger_beetle', 'horned_hercules', 'evening_cicada', 'cyclommatus_stag', 'firefly', 'dung_beetle', 'rice_grasshopper', 'mosquito', 'mantis', 'stinkbug', 'citrus_long-horned_beetle', 'peacock_butterfly', 'snail', 'horned_dynastid', 'grasshopper', 'earth-boring_dung_beetle', 'horned_atlas', 'walking_leaf', 'cricket', 'giant_cicada', 'spider', 'agrias_butterfly', 'robust_cicada', 'bagworm', 'honeybee', 'miyama_stag', 'yellow_butterfly', 'common_butterfly', 'emperor_butterfly', 'centipede', 'walking_stick', 'rainbow_stag', 'saw_stag', 'flea', 'mole_cricket', 'banded_dragonfly', 'monarch_butterfly', 'giant_stag', 'golden_stag', 'scarab_beetle', 'scorpion', 'cicada_shell', 'bell_cricket', 'wasp', 'long_locust', 'jewel_beetle', 'tarantula', 'ladybug', 'migratory_locust', 'walker_cicada', 'violin_beetle', 'hermit_crab', 'atlas_moth', 'horned_elephant', 'common_bluebottle', 'paper_kite_butterfly', 'great_purple_emperor', 'drone_beetle', 'giraffe_stag', 'man-faced_stink_bug', 'madagascan_sunset_moth', 'blue_weevil_beetle', 'rosalia_batesi_beetle', 'giant_water_bug', 'damselfly'];
  static const List oldsea = ['seaweed', 'sea_grapes', 'sea_cucumber', 'sea_pig', 'sea_star', 'sea_urchin', 'slate_pencil_urchin', 'sea_anemone', 'moon_jellyfish', 'sea_slug', 'pearl_oyster', 'mussel', 'oyster', 'scallop', 'whelk', 'turban_shell', 'abalone', 'gigas_giant_clam', 'chambered_nautilus', 'octopus', 'umbrella_octopus', 'vampire_squid', 'firefly_squid', 'gazami_crab', 'dungeness_crab', 'snow_crab', 'red_king_crab', 'acorn_barnacle', 'spider_crab', 'tiger_prawn', 'sweet_shrimp', 'mantis_shrimp', 'spiny_lobster', 'lobster', 'giant_isopod', 'horseshoe_crab', 'sea_pineapple', 'spotted_garden_eel', 'flatworm', 'venus_flower_basket'];


  //NEW
  static const List fishes = ['Funa', 'Kingyo', 'Tanago', 'Oikawa', 'Ugui', 'Koi', 'Nishikigoi', 'Demekin', 'Medaka', 'Zarigani', 'Suppon', 'Otamajakusi', 'Kaeru', 'Donko', 'Dojou', 'Namazu', 'Raigyo', 'Blueguill', 'Yellowparch', 'Blackbass', 'Paiku', 'Wakasagi', 'Ayu', 'Yamame', 'Ooiwana', 'Itou', 'Sake', 'Kingsalmon', 'Syanhaigani', 'Guppi', 'Dokutaafish', 'Angelfish', 'Neontetora', 'Pirania', 'Arowana', 'Dolado', 'Ga', 'Piraruku', 'Endorikerii', 'Kurione', 'Tatsunootoshigo', 'Kumanomi', 'Nanyouhagi', 'Chouchouuo', 'Naporeonfish', 'Minokasago', 'Fugu', 'Harisenbon', 'Aji', 'Ishidai', 'Suzuki', 'Tai', 'Karei', 'Hirame', 'Ika', 'Utsubo', 'Hanahigeutubo', 'Chouchinankou', 'Maguro', 'Kajiki', 'Rouninaji', 'Ei', 'Manbou', 'Shumokuzame', 'Same', 'Nokogirizame', 'Jinbeezame', 'Ryuuguunotukai', 'Sirakansu', 'Tyouzame', 'Thirapia', 'Beta', 'Kamitsukigame', 'GoldenTorauto', 'Rainbowfish', 'Antyobi', 'Shiira', 'Kobanzame', 'Demenigisu', 'Ranchu'];  
  static const List insects = ['Aburazemi', 'Agehacho', 'Akaeritoribaneageha', 'Akiakane', 'Arekisandoratoribaneageha', 'Amenbo', 'Ari', 'Dangomushi', 'Funamushi', 'Ga', 'Gengorou', 'Ginyanma', 'Goraiasuohtsunohanamuguri', 'Hae', 'Hanakamakiri', 'Hanmyou', 'Herakuresuohkabuto', 'Higurashi', 'Hosoakakuwagata', 'Hotaru', 'Funkorogashi', 'Inago', 'Ka', 'Kamakiri', 'Kamemushi', 'Gomadarakamikiri', 'Karasuageha', 'Katatsumuri', 'Kabutomushi', 'Kirigirisu', 'Ohsenchikogane', 'Kohkasasuohkabuto', 'Konohamushi', 'Kohrogi', 'Kumazemi', 'Kumo', 'Miirotateha', 'Minminzemi', 'Minomushi', 'Mitsubachi', 'Miyamakuwagata', 'Monkicho', 'Monshirocho', 'Morufuocho', 'Mukade', 'Nanafushi', 'Nijiirokuwagata', 'Nokogirikuwagata', 'Nomi', 'Okera', 'Oniyanma', 'Ohkabamadara', 'Ohkuwagata', 'Ougononikuwagata', 'Purachinakogane', 'Sasori', 'Seminonukegara', 'Suzumushi', 'Hachi', 'Shoryobatta', 'Tamamushi', 'Taranchura', 'Tentoumushi', 'Tonosamabatta', 'Tsukutsukuhousi', 'Baiorinmushi', 'Yadokari', 'Yonagunisan', 'Zoukabuto', 'Aosujiageha', 'Ohgomamadara', 'Ohmurasaki', 'Kanabun', 'Girafanokogirikuwagata', 'Jinmenkamemushi', 'Nishikiohtsubamega', 'Housekizoumushi', 'Ruriboshikamikiri', 'Tagame', 'Itotonbo'];
  static const List sea = ['Wakame', 'Umibudou', 'Namako', 'Senjunamako', 'Hitode', 'Uni', 'Paipuuni', 'Isogintyaku', 'Mizukurage', 'Umiushi', 'Akoyagai', 'Muhrugai', 'Kaki', 'Hotate', 'Baigai', 'Sazae', 'Awabi', 'Shakogai', 'Oumugai', 'Tako', 'Mendako', 'Koumoridako', 'Hotaruika', 'Gazami', 'DungenessCrab', 'Zuwaigani', 'Tarabagani', 'Fujitsubo', 'Takaashigani', 'Kurumaebi', 'Amaebi', 'Shako', 'Iseebi', 'Fish54', 'Daiougusokumushi', 'Kabutogani', 'Hoya', 'Chinanago', 'Hiramushi', 'Kairoudouketsu'];
  
  bool textScanning = false;

  int _insectCheckCount = 0;
  int _fishCheckCount = 0;
  int _seaCheckCount = 0;
  int _artCheckCount = 0;

  

  File? _image;
  final picker = ImagePicker();

  Category? category;
  String uploadURL = 'http://192.168.1.81:5000/predict';
  String uploadOCRURL = 'http://192.168.1.81:5000/predictocr';

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
    _isInsectLoaded ? insectList(insects:_insectObject!, checks:_insectChecks, notifyParent: refreshInsects, museumChecks: _insectMuseumChecks,) : Center(child: const CircularProgressIndicator()),
    _isFishLoaded ? fishList(fishes:_fishObject!, checks:_fishChecks, notifyParent: refreshFishes, museumChecks: _fishMuseumChecks,) : Center(child: const CircularProgressIndicator()),
    Container(child: Text("HOME"),),
    _isSeaLoaded ? seaList(sea:_seaObject!, checks:_seaChecks, notifyParent: refreshSea, museumChecks: _seaMuseumChecks,) : Center(child: const CircularProgressIndicator(),),
    _isArtLoaded ? artList(notifyParent: refreshArt, checks: _artChecks, art: _artObject!, museumChecks: _artMuseumChecks,) : Center(child: CircularProgressIndicator(),)
  ];

    _insectCheckCount = _insectChecks.where((item) => item == true).length;
    _fishCheckCount = _fishChecks.where((item) => item == true).length;
    _seaCheckCount = _seaChecks.where((item) => item == true).length;
    _artCheckCount = _artChecks.where((item) => item == true).length;

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

    List<Widget> progressIndicator = [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[ 
        //SizedBox(height: 5,),
          LinearPercentIndicator(
            
            width: 130,
            lineHeight: 14,
            linearStrokeCap: LinearStrokeCap.roundAll,
            percent: (_insectCheckCount / 80),
            backgroundColor: Colors.white60,
            progressColor: Colors.white,
            center: Text("${_insectCheckCount}/80", style: TextStyle(color: Colors.black38, fontSize: 12)),
      ),
      //SizedBox(height:5),
      //Text("${_insectCheckCount}/80", style: TextStyle(color: Colors.white, fontSize: 12)),
      ]),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[ 
        //SizedBox(height: 5,),
          LinearPercentIndicator(
            
            width: 130,
            lineHeight: 14,
            linearStrokeCap: LinearStrokeCap.roundAll,
            percent: (_fishCheckCount / 80),
            backgroundColor: Colors.white60,
            progressColor: Colors.white,
            center: Text("${_fishCheckCount}/80", style: TextStyle(color: Colors.black38, fontSize: 12)),
      ),
      //SizedBox(height:5),
      //Text("${_insectCheckCount}/80", style: TextStyle(color: Colors.white, fontSize: 12)),
      ]),
      SizedBox(height:1),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[ 
        //SizedBox(height: 5,),
          LinearPercentIndicator(
            
            width: 130,
            lineHeight: 14,
            linearStrokeCap: LinearStrokeCap.roundAll,
            percent: (_seaCheckCount / 40),
            backgroundColor: Colors.white60,
            progressColor: Colors.white,
            center: Text("${_seaCheckCount}/40", style: TextStyle(color: Colors.black38, fontSize: 12)),
      ),
      //SizedBox(height:5),
      //Text("${_insectCheckCount}/80", style: TextStyle(color: Colors.white, fontSize: 12)),
      ]),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[ 
        //SizedBox(height: 5,),
          LinearPercentIndicator(
            
            width: 130,
            lineHeight: 14,
            linearStrokeCap: LinearStrokeCap.roundAll,
            percent: (_artCheckCount / 43),
            backgroundColor: Colors.white60,
            progressColor: Colors.white,
            center: Text("${_artCheckCount}/43", style: TextStyle(color: Colors.black38, fontSize: 12)),
      ),
      //SizedBox(height:5),
      //Text("${_insectCheckCount}/80", style: TextStyle(color: Colors.white, fontSize: 12)),
      ]),
    ];


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF94cead),
        title: Text(_selectedIndexName),
        actions: <Widget>[
          progressIndicator[_selectedIndex]
        ],
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
                  Image.network("https://acnhcdn.com/latest/FtrIcon/FtrSculpture${category!.label}.png", height: 300,)
                  :
                  Image.network("https://acnhcdn.com/art/FtrArt${category!.label}.png", height: 300,),
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
          showDialog(            context: context,
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
                        )),
                      SizedBox(height: 5,),
                      
                      fishes.contains(category!._label) ?
                      Image.network("https://acnhcdn.com/latest/BookFishIcon/Fish${category!._label}Cropped.png", height: 300,)
                      :
                      insects.contains(category!._label) ?
                      Image.network("https://acnhcdn.com/latest/BookInsectIcon/Insect${category!._label}Cropped.png", height: 300)
                      :
                      Image.network("https://acnhcdn.com/latest/BookDiveFishIcon/DiveFish${category!._label}Cropped.png", height: 300),
                      SizedBox(height: 5,),
                      
                      fishes.contains(category!._label) ?
                      Text(oldfishes.elementAt(fishes.indexOf(category!._label)).toString().replaceAll("_", " ").capitalizeFirstofEach)
                      :
                      insects.contains(category!._label) ?
                      Text(oldinsects.elementAt(insects.indexOf(category!._label)).toString().replaceAll("_", " ").capitalizeFirstofEach)
                      :
                      Text(oldsea.elementAt(sea.indexOf(category!._label)).toString().replaceAll("_", " ").capitalizeFirstofEach),
                
                      SizedBox(height: 5,),
                
                      Text("Is this correct?",
                        style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w100
                      ),),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        SizedBox(
                          height: 35,
                          width: 100,
                          child: ElevatedButton(
                          onPressed: (){
                            if(fishes.contains(category!._label))
                              {
                                //fishes
                                print(_fishObject![oldfishes.elementAt(fishes.indexOf(category!._label))]!.name.nameEUen);
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => fishInfoPage(fish: _fishObject![oldfishes.elementAt(fishes.indexOf(category!._label))]!, fishChecks: _fishChecks, fishMuseumChecks: _fishMuseumChecks, notifyParent: updateFishChecks,)
                                ));
                              }
                            else {
                              if(insects.contains(category!._label)) {
                                //insects
                                print(_insectObject![oldinsects.elementAt(insects.indexOf(category!._label))]!.name.nameEUen);
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => insectInfoPage(insect: _insectObject![oldinsects.elementAt(insects.indexOf(category!._label))]!, insectChecks: _insectChecks, insectMuseumChecks: _insectMuseumChecks, notifyParent: updateInsectChecks,)
                                ));
                              } else {
                                //sea
                                print(_seaObject![oldsea.elementAt(sea.indexOf(category!._label))]!.name.nameEUen);
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => seaInfoPage(sea: _seaObject![oldsea.elementAt(sea.indexOf(category!._label))]!, seaChecks: _seaChecks, seaMuseumChecks: _seaMuseumChecks, notifyParent: updateSeaChecks,)
                                ));
                              }
                            }
                            
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
      _insectCheckCount = _insectChecks.where((item) => item == true).length;
    
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
      _fishCheckCount = _fishChecks.where((item) => item == true).length;
    
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
      _seaCheckCount = _seaChecks.where((item) => item == true).length;
    
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
      _artCheckCount = _artChecks.where((item) => item == true).length;
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

  updateFishChecks(dynamic childValue1, dynamic childValue2) {
    Future.delayed(Duration(seconds:1), () async {
      setState(() {
      _fishChecks = childValue1;
      _fishMuseumChecks = childValue2;
    });
    });
    
  }

  updateInsectChecks(dynamic childValue1, dynamic childValue2) {
    Future.delayed(Duration(seconds:1), () async {
      setState(() {
      _insectChecks = childValue1;
      _insectMuseumChecks = childValue2;
    });
    });
    
  }

  updateSeaChecks(dynamic childValue1, dynamic childValue2) {
    Future.delayed(Duration(seconds:1), () async {
      setState(() {
      _seaChecks = childValue1;
      _seaMuseumChecks = childValue2;
    });
    });
    
  }

  
}

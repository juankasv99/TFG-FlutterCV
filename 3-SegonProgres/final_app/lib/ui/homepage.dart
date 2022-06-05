import 'dart:math';

import 'package:final_app/main.dart';
import 'package:final_app/model/sea_model.dart';
import 'package:final_app/model/insects_model.dart';
import 'package:final_app/model/art_model.dart';
import 'package:final_app/model/fishes_model.dart';
import 'package:final_app/ui/fish_info.dart';
import 'package:final_app/ui/insect_info.dart';
import 'package:final_app/ui/sea_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:intl/intl.dart';

class homePage extends StatefulWidget {
  homePage({Key? key, required this.artChecks, required this.insectChecks, required this.fishChecks, required this.seaChecks, required this.artMuseumChecks, required this.insectMuseumChecks, required this.fishMuseumChecks, required this.seaMuseumChecks, required this.arts, required this.insects, required this.fishes, required this.sea}) : super(key: key);
  final List<bool> artChecks;
  final List<bool> insectChecks;
  final List<bool> fishChecks;
  final List<bool> seaChecks;
  final List<bool> artMuseumChecks;
  final List<bool> insectMuseumChecks;
  final List<bool> fishMuseumChecks;
  final List<bool> seaMuseumChecks;

  final Map<String, Art> arts;
  final Map<String, Insects> insects;
  final Map<String, Fishes> fishes;
  final Map<String, Sea> sea;

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<bool>? _artChecks;
  List<bool>? _insectChecks;
  List<bool>? _fishChecks;
  List<bool>? _seaChecks;
  List<bool>? _artMuseumChecks;
  List<bool>? _insectMuseumChecks;
  List<bool>? _fishMuseumChecks;
  List<bool>? _seaMuseumChecks;

  Map<String, Art>? _arts;
  Map<String, Insects>? _insects;
  Map<String, Fishes>? _fishes;
  Map<String, Sea>? _sea;

  Map<String, Insects>? _newInsects;
  Map<String, Fishes>? _newFishes;
  Map<String, Sea>? _newSea;
  

  int _insectCheckCount = 0;
  int _fishCheckCount = 0;
  int _seaCheckCount = 0;
  int _artCheckCount = 0;


  @override
  void initState() {
    super.initState();
    _artChecks = widget.artChecks;
    _insectChecks = widget.insectChecks;
    _fishChecks = widget.fishChecks;
    _seaChecks = widget.seaChecks;
    _artMuseumChecks = widget.artMuseumChecks;
    _insectMuseumChecks = widget.insectMuseumChecks;
    _fishMuseumChecks = widget.fishMuseumChecks;
    _seaMuseumChecks = widget.seaMuseumChecks;
    _arts = widget.arts;
    _insects = widget.insects;
    _fishes = widget.fishes;
    _sea = widget.sea;

    _newInsects = getNewInsects();
    _newFishes = getNewFishes();
    _newSea = getNewSea();
    
  }

  @override
  Widget build(BuildContext context) {

    _insectCheckCount = _insectChecks!.where((item) => item == true).length;
    _fishCheckCount = _fishChecks!.where((item) => item == true).length;
    _seaCheckCount = _seaChecks!.where((item) => item == true).length;
    _artCheckCount = _artChecks!.where((item) => item == true).length;

    return Container(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      color: Colors.orange[100],
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ],
                        color: Colors.white70,
                        border: Border.all(
                          color: Colors.white70
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Today is:"),
                          SizedBox(height: 10,),
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  )
                                ],
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white30
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Text(DateFormat('EEEE, d MMMM y').format(DateTime.now()),
                                style: TextStyle(
                                  fontSize: 20
                                ),),
                            ),
                          ),
                          SizedBox(height: 5,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                  color: Colors.white70,
                  border: Border.all(
                    color: Colors.white70
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  children: <Widget>[
                    Text("Your Progress", style: TextStyle(fontSize: 18),),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset('assets/flick.png', height: 30,),
                        Text("Insects"),
                        LinearPercentIndicator(
                          lineHeight: 16,
                          barRadius: const Radius.circular(16),
                          percent: (_insectCheckCount / 80),
                          width: 250,
                          backgroundColor: Colors.white,
                          progressColor: Color(0xFF91d7db),
                          animation: true,
                          animationDuration: randomNumber(),
                          center: Text("${_insectCheckCount}/80", style: TextStyle(color: Colors.black38, fontSize: 12)),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset('assets/cj.webp', height: 30,),
                        Text("Fishes"),
                        LinearPercentIndicator(
                          lineHeight: 16,
                          barRadius: const Radius.circular(16),
                          percent: (_fishCheckCount / 80),
                          width: 250,
                          backgroundColor: Colors.white,
                          progressColor: Color(0xFF91d7db),
                          animation: true,
                          animationDuration: randomNumber(),
                          center: Text("${_fishCheckCount}/80", style: TextStyle(color: Colors.black38, fontSize: 12)),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset('assets/cj.webp', height: 30,),
                        Text("Sea"),
                        LinearPercentIndicator(
                          lineHeight: 16,
                          barRadius: const Radius.circular(16),
                          percent: (_seaCheckCount / 40),
                          width: 250,
                          backgroundColor: Colors.white,
                          progressColor: Color(0xFF91d7db),
                          animation: true,
                          animationDuration: randomNumber(),
                          center: Text("${_seaCheckCount}/40", style: TextStyle(color: Colors.black38, fontSize: 12)),
                        )
                      ],
                    ),
                     SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset('assets/redd.png', height: 30,),
                        Text("Art"),
                        LinearPercentIndicator(
                          lineHeight: 16,
                          barRadius: const Radius.circular(16),
                          percent: (_artCheckCount / 43),
                          width: 250,
                          backgroundColor: Colors.white,
                          progressColor: Color(0xFF91d7db),
                          animation: true,
                          animationDuration: randomNumber(),
                          center: Text("${_artCheckCount}/43", style: TextStyle(color: Colors.black38, fontSize: 12)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height:15),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                  color: Colors.white70,
                  border: Border.all(
                    color: Colors.white70
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  children: <Widget>[
                    Text("New this season", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      height: 110,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => SizedBox(width: 8,),
                        itemCount: _newInsects!.length,
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => insectInfoPage(insect: _newInsects![_newInsects!.keys.elementAt(index)]!, insectChecks: _insectChecks!, insectMuseumChecks: _insectMuseumChecks!, notifyParent: voidfunc,)
                              ));
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white30
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)), 
                                ),
                                child: Column(
                                  children: [
                                    Image.network(_newInsects![_newInsects!.keys.elementAt(index)]!.imageUri, width: 80, fit: BoxFit.none, scale: 6,),
                                    Text(_newInsects![_newInsects!.keys.elementAt(index)]!.name.nameEUen.capitalizeFirstofEach,
                                      style: TextStyle(
                                        fontSize: 10
                                      ),)
                                  ]
                                ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      thickness: 0.5,
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      height: 80,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => SizedBox(width: 8,),
                        itemCount: _newFishes!.length,
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => fishInfoPage(fish: _newFishes![_newFishes!.keys.elementAt(index)]!, fishChecks: _fishChecks!, fishMuseumChecks: _fishMuseumChecks!, notifyParent: voidfunc,)
                              ));
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white30
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)), 
                                ),
                                child: Column(
                                  children: [
                                    //, height: 70, fit: BoxFit.none, scale: 6,
                                    Image.network(_newFishes![_newFishes!.keys.elementAt(index)]!.imageUri, width: 90, fit: BoxFit.none, scale: 11,),
                                    Text(_newFishes![_newFishes!.keys.elementAt(index)]!.name.nameEUen.capitalizeFirstofEach,
                                      style: TextStyle(
                                        fontSize: 10
                                      ),)
                                  ]
                                ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      thickness: 0.5,
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      height: 100,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => SizedBox(width: 8,),
                        itemCount: _newSea!.length,
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => seaInfoPage(sea: _newSea![_newSea!.keys.elementAt(index)]!, seaChecks: _seaChecks!, seaMuseumChecks: _seaMuseumChecks!, notifyParent: voidfunc,)
                              ));
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: 80,
                                decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white30
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)), 
                                ),
                                child: Column(
                                  children: [
                                    Image.network(_newSea![_newSea!.keys.elementAt(index)]!.imageUri, height: 70, fit: BoxFit.none, scale: 6,),
                                    Text(_newSea![_newSea!.keys.elementAt(index)]!.name.nameEUen.capitalizeFirstofEach,
                                      style: TextStyle(
                                        fontSize: 10
                                      ),)
                                  ]
                                ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
      
    );
  }

  randomNumber() {
    var random = new Random();
    
    int min = 400;
    int max = 1000;

    int result = min + random.nextInt(max - min);
    
    return result;
  }

  Map<String, Insects>? getNewInsects() {
    Map<String, Insects>? newInsects = {};

    for(int i = 0; i < _insects!.length; i++) {
      Insects tmp = _insects!.values.elementAt(i);
      if(tmp.availability.monthArrayNorthern.contains(DateTime.now().month)) {
        
        if(DateTime.now().month == 1 && !(tmp.availability.monthArrayNorthern.contains(12))) {
          newInsects[tmp.fileName] = tmp;
          print(tmp.name.nameEUen);
        } else {
          if(DateTime.now().month != 1 && !(tmp.availability.monthArrayNorthern.contains(DateTime.now().month - 1))) {
            newInsects[tmp.fileName] = tmp;
            print(tmp.name.nameEUen);
          }
        }
      }
    }

    return newInsects;
  }

  Map<String, Fishes>? getNewFishes() {
    Map<String, Fishes>? newFishes = {};

    for(int i = 0; i < _fishes!.length; i++) {
      Fishes tmp = _fishes!.values.elementAt(i);
      if(tmp.availability.monthArrayNorthern.contains(DateTime.now().month)) {
        
        if(DateTime.now().month == 1 && !(tmp.availability.monthArrayNorthern.contains(12))) {
          newFishes[tmp.fileName] = tmp;
          print(tmp.name.nameEUen);
        } else {
          if(DateTime.now().month != 1 && !(tmp.availability.monthArrayNorthern.contains(DateTime.now().month - 1))) {
            newFishes[tmp.fileName] = tmp;
            print(tmp.name.nameEUen);
          }
        }
      }
    }

    return newFishes;
  }

  Map<String, Sea>? getNewSea() {
    Map<String, Sea>? newSea = {};

    for(int i = 0; i < _sea!.length; i++) {
      Sea tmp = _sea!.values.elementAt(i);
      if(tmp.availability.monthArrayNorthern.contains(DateTime.now().month)) {
        
        if(DateTime.now().month == 1 && !(tmp.availability.monthArrayNorthern.contains(12))) {
          newSea[tmp.fileName] = tmp;
          print(tmp.name.nameEUen);
        } else {
          if(DateTime.now().month != 1 && !(tmp.availability.monthArrayNorthern.contains(DateTime.now().month - 1))) {
            newSea[tmp.fileName] = tmp;
            print(tmp.name.nameEUen);
          }
        }
      }
    }

    return newSea;
  }

  dynamic voidfunc(dynamic one, dynamic two) {
    print("enter func");
  }
}
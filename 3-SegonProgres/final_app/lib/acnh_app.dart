import 'package:final_app/model/art_model.dart';
import 'package:final_app/model/fishes_model.dart';
import 'package:final_app/model/sea_model.dart';
import 'package:final_app/network/network.dart';
import 'package:final_app/ui/art_list.dart';
import 'package:final_app/ui/fish_list.dart';
import 'package:final_app/ui/sea_list.dart';
import 'package:flutter/material.dart';
import 'package:final_app/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:final_app/ui/insect_list.dart';
import 'dart:io';

import 'package:final_app/model/insects_model.dart';

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
  List<bool> _fishChecks = List.filled(80,false);
  List<bool> _seaChecks = List.filled(40, false);
  List<bool> _artChecks = List.filled(43, false);

  static const Map<int, String> titlesInIndex = {
    0: "Insects",
    1: "Fishes",
    2: "Home",
    3: "Deep-Sea",
    4: "Art"
  };

  

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
              onPressed: () => {},
              tooltip: 'Pick Image',
              child: Icon(Icons.photo),
            ),
            SizedBox(width: 10,),
            FloatingActionButton(
              backgroundColor: Color(0xFF91d7db),
              heroTag: "Fltbtn1",
              onPressed: () => {},
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

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
      _selectedIndexName = titlesInIndex[value].toString();
      print(_selectedIndex);
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
}

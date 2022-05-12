import 'package:final_app/model/fishes_model.dart';
import 'package:final_app/model/sea_model.dart';
import 'package:final_app/network/network.dart';
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

  bool _isInsectLoaded = false;
  bool _isFishLoaded = false;
  bool _isSeaLoaded = false;

  List<bool> _insectChecks = List.filled(80, false);
  List<bool> _fishChecks = List.filled(80,false);
  List<bool> _seaChecks = List.filled(40, false);

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

  }

  

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
    _isInsectLoaded ? insectList(insects:_insectObject!, checks:_insectChecks, notifyParent: refreshInsects,) : Center(child: const CircularProgressIndicator()),
    _isFishLoaded ? fishList(fishes:_fishObject!, checks:_fishChecks, notifyParent: refreshFishes,) : Center(child: const CircularProgressIndicator()),
    Container(child: Text("HOME"),),
    _isSeaLoaded ? seaList(sea:_seaObject!, checks:_seaChecks, notifyParent: refreshSea,) : Center(child: const CircularProgressIndicator()),

    
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
}

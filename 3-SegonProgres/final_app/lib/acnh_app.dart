import 'package:final_app/network/network.dart';
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

  bool _isInsectLoaded = false;

  List<bool> _insectChecks = List.filled(80, false);

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF94cead),
        title: Text(_selectedIndexName),
      ),

      //_isInsectLoaded ? insectList(_insectObject, _insectChecks) : Center(child: const CircularProgressIndicator()),
      body: Container(
        color: Colors.orange[50],
        child: _isInsectLoaded ? insectList(insects:_insectObject!, checks:_insectChecks, notifyParent: refresh,) : Center(child: const CircularProgressIndicator()),
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

  refresh(dynamic childValue) {
    setState(() {
      _insectChecks = childValue;
    });
  }
}

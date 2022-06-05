import 'package:flutter/material.dart';

import 'acnh_app.dart';

extension CapExtension on String {
  String get inCaps => length > 0 ?'${this[0].toUpperCase()}${substring(1)}':'';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach => replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.inCaps).join(" ");
}

void main() => runApp(MaterialApp(
  theme: ThemeData(fontFamily: "RodinWanpaku", textTheme: const TextTheme(bodyText2: TextStyle(height: 1.25), headline6: TextStyle(height: 0.5),)),
  home: ACNHapp(),
  
));
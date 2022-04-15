// import 'dart:math';

// import 'package:flutter/material.dart';

// class Recognition {
//   int _id;
//   String _label;
//   double _score;
//   Rect _location;

//   Recognition(this._id, this._label, this._score, this._location);

//   int get id => _id;

//   String get label => _label;

//   double get score => _score;

//   Rect get location => _location;

//   Rect get renderLocation {
//     double ratioX = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width / 1280.0;
//     double ratioY = ratioX;

//     double transLeft = max(0.1, location.left * ratioX);
//     double transTop = max(0.1, location.top * ratioY);
//     double transWidth = min(
//         location.width * ratioX, MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width);
//     double transHeight = min(
//         location.height * ratioY, MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height);

//     Rect transformedRect =
//       Rect.fromLTWH(transLeft, transTop, transWidth, transHeight);
//     return transformedRect;
//   }

//   @override
//   String toString() {
//     return 'Recognition(id: $id, label: $label, score: $score, location: $location)';
//   }
// }
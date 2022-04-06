import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_draft_camera/realtime/live_camera.dart';
import 'package:flutter_draft_camera/flutter_tflite/newstatic_image.dart';
import 'package:flutter_draft_camera/static_image/static.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_draft_camera/flutter_tflite/classification.dart';

List<CameraDescription> ?cameras;

Future<void> main() async {
  //Initialize the cameras when the app starts
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  cameras = await availableCameras();


  //running the app
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Object Detector App"),
        actions: <Widget>[
          IconButton(onPressed: AboutDialog, icon: Icon(Icons.info)),
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                minWidth: 170,
                child: ElevatedButton(
                  child: Text("Detect an image"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ImageClassification(),
                    ));
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 160,
                child: ElevatedButton(
                  child: Text("Real Time Detection"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: ((context) => LiveFeed(cameras: cameras!))
                    ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: "Object Detector App",
      applicationLegalese: "By Juan Carlos Soriano",
      applicationVersion: "0.1",
      children: <Widget>[
        Text("www.github.com/juankasv99")
      ] 
    );
  }
}
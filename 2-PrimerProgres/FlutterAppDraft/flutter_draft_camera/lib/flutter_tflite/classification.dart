import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class ImageClassification extends StatefulWidget {
  const ImageClassification({ Key? key }) : super(key: key);

  @override
  State<ImageClassification> createState() => _ImageClassificationState();
}

class _ImageClassificationState extends State<ImageClassification> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _busy = false;
    File ?_image;
    //List _output;
    List<dynamic> _output = List.filled(70, 0);
    
    final picker = ImagePicker();

    loadModel() async{
      await Tflite.loadModel(
        model: 'assets/models/custom_model_fp16.tflite', labels: 'assets/models/labels.txt'
      );
      print("Model loaded");
    }


    @override
    void initState() {
      super.initState();
      print("Entrando en initstate");
      loadModel().then((value) {
        print("Entrando en el then del loadmodel");
        setState(() {
          
        });
      });
    }

    @override
    void dispose() { 
      super.dispose();
      Tflite.close();
    }

    classifyImage(File image) async {
      var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 70,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
        );
      setState(() {
        _output = output!;
        _busy = false;
        print("This object is $_output");
      });
    }
    

    List<Widget> stackChildren = [];



    
    




    

    pickImage() async {
      var pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if(pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("No Image Selected");
        }
      });
      classifyImage(_image!);
    }

    stackChildren.add(
      Positioned(
        child: _image == null ?
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Please Select an Image"),
            ],
          ),
        )
      :
        Container(
          child: Image.file(_image!),
        ),
      )
    );

    if(_busy) {
      stackChildren.add(
        Center(
          child: CircularProgressIndicator(),
        )
      );
    }

    loadModel();
    return Scaffold(
      appBar: AppBar(
        title: Text("Object Detector"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "Fltbtn2",
            child: Icon(Icons.camera_alt),
            onPressed: () => pickImage(),
          ),
          SizedBox(width: 10,),
          FloatingActionButton(
            heroTag: "Fltbtn1",
            child: Icon(Icons.photo),
            onPressed: () => pickImage(),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: stackChildren,
        ),
      ),
    );
  }
}
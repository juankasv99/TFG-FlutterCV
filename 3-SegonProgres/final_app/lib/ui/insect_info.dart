import 'package:final_app/main.dart';
import 'package:final_app/model/insects_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class insectInfoPage extends StatefulWidget {
  insectInfoPage({ Key? key, required this.notifyParent, required this.insect, required this.insectChecks, required this.insectMuseumChecks}) : super(key: key);
  final Function(dynamic, dynamic) notifyParent;
  final Insects insect;
  List<bool> insectMuseumChecks;
  List<bool> insectChecks;

  @override
  State<insectInfoPage> createState() => _insectInfoPageState();
}

class _insectInfoPageState extends State<insectInfoPage> {
  Insects? insects;
  List<bool>? insectMuseumChecks;
  List<bool>? insectChecks;

  @override
  Widget build(BuildContext context) {
    insects = widget.insect;
    insectChecks = widget.insectChecks;
    insectMuseumChecks = widget.insectMuseumChecks;

    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        title: Text(insects!.name.nameEUen.capitalizeFirstofEach),
        centerTitle: true,
        leading: Image.network(insects!.iconUri),
        backgroundColor: const Color(0xFF94cead),
      ),
      body: Center(
        child: Container(
          child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Obtained"),
                Checkbox(
                  shape: CircleBorder(),
                  activeColor: const Color(0xFF69d196),
                  checkColor: Colors.orange[50],
                  value: insectChecks![insects!.id-1], 
                  onChanged: (bool? value) {
                    setState(() {
                      insectChecks![insects!.id-1] = value!;
                      widget.notifyParent(insectChecks, insectMuseumChecks);  
                    }); 
                  }
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Museum"),
                Checkbox(
                  shape: CircleBorder(),
                  activeColor: Colors.blueAccent[700],
                  checkColor: Colors.orange[50],
                  value: insectMuseumChecks![insects!.id-1],
                  onChanged: (bool? value) {
                    setState(() {
                      insectMuseumChecks![insects!.id-1] = value!;
                      widget.notifyParent(insectChecks, insectMuseumChecks);  
                    }); 
                  }
                ),
              ],
            )
          ]
        ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(FontAwesomeIcons.arrowLeft),
        backgroundColor: const Color(0xFF91d7db),
      ),
    );
  }
}
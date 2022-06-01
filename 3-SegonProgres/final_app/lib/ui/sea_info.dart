import 'package:final_app/main.dart';
import 'package:final_app/model/sea_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class seaInfoPage extends StatefulWidget {
  seaInfoPage({ Key? key, required this.notifyParent, required this.sea, required this.seaChecks, required this.seaMuseumChecks}) : super(key: key);
  final Function(dynamic, dynamic) notifyParent;
  final Sea sea;
  List<bool> seaMuseumChecks;
  List<bool> seaChecks;

  @override
  State<seaInfoPage> createState() => _seaInfoPageState();
}

class _seaInfoPageState extends State<seaInfoPage> {
  Sea? sea;
  List<bool>? seaMuseumChecks;
  List<bool>? seaChecks;

  @override
  Widget build(BuildContext context) {
    sea = widget.sea;
    seaChecks = widget.seaChecks;
    seaMuseumChecks = widget.seaMuseumChecks;

    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        title: Text(sea!.name.nameEUen.capitalizeFirstofEach),
        centerTitle: true,
        leading: Image.network(sea!.iconUri),
        backgroundColor: const Color(0xFF94cead),
      ),
      body: Center(
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
                  value: seaChecks![sea!.id-1], 
                  onChanged: (bool? value) {
                    setState(() {
                      seaChecks![sea!.id-1] = value!;
                      widget.notifyParent(seaChecks, seaMuseumChecks);  
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
                  value: seaMuseumChecks![sea!.id-1],
                  onChanged: (bool? value) {
                    setState(() {
                      seaMuseumChecks![sea!.id-1] = value!;
                      widget.notifyParent(seaChecks, seaMuseumChecks);  
                    }); 
                  }
                ),
              ],
            ),
          ],
        ),
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
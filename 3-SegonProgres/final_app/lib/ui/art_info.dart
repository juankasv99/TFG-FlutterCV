import 'package:final_app/main.dart';
import 'package:final_app/model/art_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class artInfoPage extends StatefulWidget {
  artInfoPage({Key? key, required this.art, required this.artChecks, required this.artMuseumChecks, required this.notifyParent}) : super(key: key);
  final Function(dynamic, dynamic) notifyParent;
  final Art art;
  List<bool> artMuseumChecks;
  List<bool> artChecks;

  @override
  State<artInfoPage> createState() => _artInfoPageState();
}

class _artInfoPageState extends State<artInfoPage> {
  Art? art;
  List<bool>? artChecks;
  List<bool>? artMuseumChecks;

  @override
  Widget build(BuildContext context) {
    art = widget.art;
    artChecks = widget.artChecks;
    artMuseumChecks = widget.artMuseumChecks;
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        title: Text(art!.name.nameEUen.capitalizeFirstofEach),
        centerTitle: true,
        leading: Image.network(art!.imageUri),
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
                  value: artChecks![art!.id-1], 
                  onChanged: (bool? value) {
                    setState(() {
                      artChecks![art!.id-1] = value!;
                      widget.notifyParent(artChecks, artMuseumChecks);  
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
                  value: artMuseumChecks![art!.id-1],
                  onChanged: (bool? value) {
                    setState(() {
                      artMuseumChecks![art!.id-1] = value!;
                      widget.notifyParent(artChecks, artMuseumChecks);  
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
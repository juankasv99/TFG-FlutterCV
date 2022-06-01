import 'package:final_app/main.dart';
import 'package:final_app/model/fishes_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class fishInfoPage extends StatefulWidget {
  fishInfoPage({Key? key, required this.notifyParent, required this.fish, required this.fishChecks, required this.fishMuseumChecks}) : super(key: key);
  final Function(dynamic, dynamic) notifyParent;
  final Fishes fish;
  List<bool> fishMuseumChecks;
  List<bool> fishChecks;

  @override
  State<fishInfoPage> createState() => _fishInfoPageState();
}

class _fishInfoPageState extends State<fishInfoPage> {
  Fishes? fish;
  List<bool>? fishMuseumChecks;
  List<bool>? fishChecks;

  @override
  Widget build(BuildContext context) {
    fish = widget.fish;
    fishChecks = widget.fishChecks;
    fishMuseumChecks = widget.fishMuseumChecks;
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        title: Text(fish!.name.nameEUen.capitalizeFirstofEach),
        centerTitle: true,
        leading: Image.network(fish!.iconUri),
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
                  value: fishChecks![fish!.id-1], 
                  onChanged: (bool? value) {
                    setState(() {
                      fishChecks![fish!.id-1] = value!;
                      widget.notifyParent(fishChecks, fishMuseumChecks);  
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
                  value: fishMuseumChecks![fish!.id-1],
                  onChanged: (bool? value) {
                    setState(() {
                      fishMuseumChecks![fish!.id-1] = value!;
                      widget.notifyParent(fishChecks, fishMuseumChecks);
                    }); 
                  }
                ),
              ],
            )
            ],
          ),
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
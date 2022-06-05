import 'package:final_local_app/main.dart';
import 'package:final_local_app/model/art_model.dart';
import 'package:final_local_app/ui/art_info.dart';
import 'package:final_local_app/ui/insect_info.dart';
import 'package:flutter/material.dart';
import 'package:final_local_app/model/insects_model.dart';
import 'package:final_local_app/util/get_available_month.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class artList extends StatefulWidget {
  final Function(dynamic, dynamic) notifyParent;
  final List<bool> checks;
  final List<bool> museumChecks;
  final Map<String, Art> art;
  artList({Key? key, required this.notifyParent, required this.checks, required this.art, required this.museumChecks}) : super(key: key);

  @override
  State<artList> createState() => _artListState();
}

class _artListState extends State<artList> {
  List<bool>? _checks;
  List<bool>? _museumChecks;
  Map<String, Art>? _art;

  double opacityLevel = 1.0;

  

  @override
  void initState() {
    super.initState();
    _checks = widget.checks;
    _art = widget.art;
    _museumChecks = widget.museumChecks;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) => SizedBox(width: 8),
            itemCount: _art!.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Container(
                height: 80,
                child: ListTile(
                  enabled: _checks![index],
                  isThreeLine: true,
                  leading: _checks![index] ? Image.network(_art![_art!.keys.elementAt(index)]!.imageUri)
                  :
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(Colors.black54,
                      BlendMode.srcATop),
                    child: Image.network(_art![_art!.keys.elementAt(index)]!.imageUri),
                  ),
                  title: Text(_art![_art!.keys.elementAt(index)]!.name.nameEUen.capitalizeFirstofEach,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: -0.5
                    ),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(FontAwesomeIcons.dollarSign,
                            size: 16.0,
                            color: Colors.red[700],),
                        ),
                        TextSpan(
                          text: _art![_art!.keys.elementAt(index)]!.buyPrice.toString() + "\n",
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        WidgetSpan(
                          child: Icon(FontAwesomeIcons.dollarSign,
                            size: 16.0,
                            color: const Color(0xFF69d196),),
                        ),
                        TextSpan(
                          text: _art![_art!.keys.elementAt(index)]!.sellPrice.toString() + "          ",
                          style: TextStyle(
                            color: const Color(0xFF69d196),
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            height: 1.8,
                          )
                        ),
                        WidgetSpan(
                          child: _art![_art!.keys.elementAt(index)]!.hasFake ?
                            Icon(FontAwesomeIcons.solidImages, size: 16.0, color: const Color(0xFF65d5db)) 
                            :
                            Icon(FontAwesomeIcons.solidImage, size: 16.0, color: Colors.red[700])
                        ),
                        TextSpan(
                          text: _art![_art!.keys.elementAt(index)]!.hasFake ?
                            "   Fakes"
                            :
                            "  No fakes",
                          style: TextStyle(
                            color: _art![_art!.keys.elementAt(index)]!.hasFake ?
                              const Color(0xFF65d5db)
                              :
                              Colors.red[700],
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            height: 1.8,
                          )
                        )
                      ]
                    ),
                  ),
                  trailing: Transform.scale(
                    scale: 1.2,
                    child: Wrap(
                    spacing: -10,
                    children: <Widget>[
                      Checkbox(
                        shape: CircleBorder(),
                        activeColor: const Color(0xFF69d196),
                        checkColor: Colors.orange[50],
                        value: _checks![index],
                        onChanged: (bool? value) {
                          setState(() {
                            _checks![index] = value!;
                            opacityLevel == 1.0 ? 0.5 : 1.0;
                            print("Pressed ${index}");
                            widget.notifyParent(_checks,_museumChecks);
                          });
                        }, 
                      ),
                      Checkbox(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        activeColor: Colors.blueAccent[700],
                        checkColor: Colors.orange[50],
                        value: _museumChecks![index],
                        onChanged: (bool? value) {
                          setState(() {
                            _museumChecks![index] = value!;
                            opacityLevel == 1.0 ? 0.5 : 1.0;
                            print("Pressed ${index}");
                            widget.notifyParent(_checks,_museumChecks);
                          });
                        },
                      ),
                    ],
                  ),),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => artInfoPage(art: _art![_art!.keys.elementAt(index)]!, artChecks: _checks!, artMuseumChecks: _museumChecks!, notifyParent: updateArtChecks,)
                  ));
                },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  updateArtChecks(dynamic childValue1, dynamic childValue2) {
    Future.delayed(Duration(seconds:1), () async {
      setState(() {
      _checks = childValue1;
      _museumChecks = childValue2;
    });
    });
    
  }
}
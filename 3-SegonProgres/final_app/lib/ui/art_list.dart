import 'package:final_app/main.dart';
import 'package:final_app/model/art_model.dart';
import 'package:flutter/material.dart';
import 'package:final_app/model/insects_model.dart';
import 'package:final_app/util/get_available_month.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class artList extends StatefulWidget {
  final Function(dynamic) notifyParent;
  final List<bool> checks;
  final Map<String, Art> art;
  artList({Key? key, required this.notifyParent, required this.checks, required this.art}) : super(key: key);

  @override
  State<artList> createState() => _artListState();
}

class _artListState extends State<artList> {
  List<bool>? _checks;
  Map<String, Art>? _art;

  @override
  void initState() {
    super.initState();
    _checks = widget.checks;
    _art = widget.art;
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
                  isThreeLine: true,
                  leading: Image.network(_art![_art!.keys.elementAt(index)]!.imageUri),
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
                  scale: 1.3,
                  child: Checkbox(
                    shape: CircleBorder(),
                    activeColor: const Color(0xFF69d196),
                    checkColor: Colors.orange[50],
                    value: _checks![index],
                    onChanged: (bool? value) {
                      setState(() {
                        _checks![index] = value!;
                        print("Pressed ${index}");
                        widget.notifyParent(_checks);
                      });
                    },
                    
                  ),
                ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
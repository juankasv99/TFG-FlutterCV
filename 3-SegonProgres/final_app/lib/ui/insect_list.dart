import 'package:final_app/main.dart';
import 'package:flutter/material.dart';
import 'package:final_app/model/insects_model.dart';
import 'package:final_app/util/get_available_month.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class insectList extends StatefulWidget {
  final Function(dynamic) notifyParent;
  final List<bool> checks;
  final Map<String, Insects> insects;
  const insectList({Key? key, required this.checks, required this.insects, required this.notifyParent}) : super(key: key);

  @override
  State<insectList> createState() => _insectListState();
}

class _insectListState extends State<insectList> {
  List<bool>? _checks;
  Map<String, Insects>? _insects;
  
  @override
  void initState() {
    
    super.initState();
    _checks = widget.checks;
    _insects = widget.insects;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Expanded(
        //color: Colors.orange[50],
        //height: 640,
        //padding: EdgeInsets.symmetric(vertical: 16.0),
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => SizedBox(width: 8),
          itemCount: _insects!.length,
          itemBuilder: (context, index) => ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Container(
              height: 80,
              child: ListTile(
                isThreeLine: true,
                
                leading: Image.network(_insects![_insects!.keys.elementAt(index)]!.iconUri),
                title: Text(_insects![_insects!.keys.elementAt(index)]!.name.nameEUen.capitalizeFirstofEach,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: -0.5, height: 1.2
                  ),
                ),
                subtitle: _checks![index] ?
                  Text(_insects![_insects!.keys.elementAt(index)]!.catchPhrase,
                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.5,
                                      fontFamily: "Rubik",
                                      letterSpacing: -0.5
                                    ),
                        )
                        :
                        RichText(
                          text: TextSpan(children: [
                          WidgetSpan(
                            child: Icon(FontAwesomeIcons.calendarDay,
                                    size: 15.0,
                                    color: const Color(0xFF69d196),)),
                          TextSpan(
                            text: " " + getAvailableMonth(_insects![_insects!.keys.elementAt(index)]!) + "\n",
                            style: TextStyle(
                                            
                                            color: const Color(0xFF69d196),
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold)
                          ),
                          WidgetSpan(
                                        child: Icon(FontAwesomeIcons.solidClock,
                                            size: 16.0,
                                            color: const Color(0xFF65d5db))),
                          TextSpan(
                                        text: " " +
                                            getAvailableHours(_insects![
                                                _insects!.keys
                                                    .elementAt(index)]!) + "      ",
                                        style: TextStyle(
                                          height: 1.75,
                                          color: const Color(0xFF65d5db),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold)),
                          WidgetSpan(
                                        child: Icon(FontAwesomeIcons.dollarSign,
                                            size: 16.0,
                                            color: Colors.red[700]),),
                          TextSpan(
                                        text:
                                          _insects![_insects!.keys.elementAt(index)]!.price.toString(),
                                        style: TextStyle( 
                                          color: Colors.red[700],
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                          )
                        ])),
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

  String getAvailableHours(Insects insect) {
    String result = insect.availability.time.replaceAll(" ", "").replaceAll("&", " & ");

    if (insect.availability.isAllDay) {
      result = "All day";
    }

    return result;

  }
}



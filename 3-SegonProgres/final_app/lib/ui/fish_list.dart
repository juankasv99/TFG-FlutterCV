import 'package:final_app/main.dart';
import 'package:final_app/model/fishes_model.dart';
import 'package:flutter/material.dart';
import 'package:final_app/model/insects_model.dart';
import 'package:final_app/util/get_available_month.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class fishList extends StatefulWidget {

  final Function(dynamic) notifyParent;
  final List<bool> checks;
  final Map<String, Fishes> fishes;

  fishList({Key? key, required this.notifyParent, required this.checks, required this.fishes}) : super(key: key);

  @override
  State<fishList> createState() => _fishListState();
}

class _fishListState extends State<fishList> {
  List<bool>? _checks;
  Map<String, Fishes>? _fishes;

  @override
  void initState() {
    super.initState();
    _checks = widget.checks;
    _fishes = widget.fishes;
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
            itemCount: _fishes!.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Container(
                height: 80,
                child: ListTile(
                  isThreeLine: true,
                  leading: Image.network(_fishes![_fishes!.keys.elementAt(index)]!.iconUri),
                  title: Text(_fishes![_fishes!.keys.elementAt(index)]!.name.nameEUen.capitalizeFirstofEach,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: -0.5
                    ),
                  ),
                  subtitle: _checks![index] ?
                    Text(_fishes![_fishes!.keys.elementAt(index)]!.catchPhrase,
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
                            text: " " + getAvailableMonth(_fishes![_fishes!.keys.elementAt(index)]!) + "\n",
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
                                            getAvailableHours(_fishes![
                                                _fishes!.keys
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
                                          _fishes![_fishes!.keys.elementAt(index)]!.price.toString(),
                                        style: TextStyle( 
                                          color: Colors.red[700],
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),),
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

                )
              )
            )
          )
        ),
      ],
    );
  }

  String getAvailableHours(Fishes fishes) {
    String result = fishes.availability.time.replaceAll(" ", "").replaceAll("&", " & ");

    if (fishes.availability.isAllDay) {
      result = "All day";
    }

    return result;
  }
}
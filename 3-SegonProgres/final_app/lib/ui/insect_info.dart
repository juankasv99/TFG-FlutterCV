import 'package:final_app/main.dart';
import 'package:final_app/model/insects_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:math';

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
    DateTime now = DateTime.now();
    //String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        title: Text(insects!.name.nameEUen.capitalizeFirstofEach),
        centerTitle: true,
        leading: Image.network(insects!.iconUri),
        backgroundColor: const Color(0xFF94cead),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
            children: <Widget>[
              Container(
                height: 150,
                width: double.infinity,
                //padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                  color: Colors.white70,
                  border: Border.all(
                    color: Colors.white70
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: FullScreenWidget(
                  child: Center(
                    child: Hero(
                      tag: "smallImage",
                      child: Image.network(insects!.imageUri,
                      fit: BoxFit.none,
                      width: 300,
                      scale: 4,
                      ),
                    ),
                  ),
                ),
      
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                  color: Colors.white70,
                  border: Border.all(
                    color: Colors.white70
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: 
                  Text('"'+insects!.catchPhrase+'"', textAlign: TextAlign.justify, style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[600]),)
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ],
                        color: Colors.white70,
                        border: Border.all(
                          color: Colors.white70
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Column(
                        children: <Widget>[
                          Text("Common Sell Price", style: TextStyle(fontSize: 14),),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset("assets/bell.png", height: 30,),
                              SizedBox(width: 20,),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 1),
                                  )
                                ],
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white30
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)), 
                                ),
                                child: Text(insects!.price.toString()+r"$"),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text("Flick Sell Price"),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset("assets/flick.png", height: 30,),
                              SizedBox(width: 20,),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 1),
                                  )
                                ],
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white30
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)), 
                                ),
                                child: Text(insects!.priceFlick.toString()+r"$"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ],
                        color: Colors.white70,
                        border: Border.all(
                          color: Colors.white70
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(FontAwesomeIcons.warehouse, size: 16, color: Colors.black87,),
                              SizedBox(width: 10,),
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
                              Icon(FontAwesomeIcons.landmark, size: 19, color: Colors.black87,),
                              SizedBox(width: 5,),
                              Text("Museum"),
                              Checkbox(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
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
                          ),
                        ],
                      ),
                    ))
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ],
                      color: Colors.white70,
                      border: Border.all(
                        color: Colors.white70
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Column(children: <Widget>[
                      Text("Availability"),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Jan
                          Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7.5),
                                    decoration: insects!.availability.monthArrayNorthern.contains(1) ?
                                    BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white30
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7)), 
                                    )
                                    :
                                    null,
                                    child: Text("Jan", style: now.month == 1 ? TextStyle(color: const Color(0xFF94cead)) : !(insects!.availability.monthArrayNorthern.contains(1)) ? TextStyle(color: Colors.grey[500]) : null,),
                                  ),
                          // Feb
                          Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7.5),
                                    decoration: insects!.availability.monthArrayNorthern.contains(2) ?
                                    BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white30
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7)), 
                                    )
                                    :
                                    null,
                                    child: Text("Feb", style: now.month == 2 ? TextStyle(color: const Color(0xFF91d7db)) : !(insects!.availability.monthArrayNorthern.contains(2)) ? TextStyle(color: Colors.grey[500]) : null,),
                                  ),
                          // Mar
                          Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7.5),
                                    decoration: insects!.availability.monthArrayNorthern.contains(3) ?
                                    BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white30
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7)), 
                                    )
                                    :
                                    null,
                                    child: Text("Mar", style: now.month == 3 ? TextStyle(color: const Color(0xFF91d7db)) : !(insects!.availability.monthArrayNorthern.contains(3)) ? TextStyle(color: Colors.grey[500]) : null,),
                                  ),
                          // Apr
                          Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7.5),
                                    decoration: insects!.availability.monthArrayNorthern.contains(4) ? 
                                    BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white30
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7)), 
                                    )
                                    :
                                    null,
                                    child: Text("Apr", style: now.month == 4 ? TextStyle(color: const Color(0xFF91d7db)) : !(insects!.availability.monthArrayNorthern.contains(4)) ? TextStyle(color: Colors.grey[500]) : null,),
                                  ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // May
                          Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7.5),
                                    decoration: insects!.availability.monthArrayNorthern.contains(5) ?
                                    BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white30
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7)), 
                                    )
                                    :
                                    null,
                                    child: Text("May", style: now.month == 5 ? TextStyle(color: const Color(0xFF91d7db)) : !(insects!.availability.monthArrayNorthern.contains(5)) ? TextStyle(color: Colors.grey[500]) : null,),
                                  ),
                          // Jun
                          Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7.5),
                                    decoration: insects!.availability.monthArrayNorthern.contains(6) ?
                                    BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white30
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7)), 
                                    )
                                    :
                                    null,
                                    child: Text("Jun", style: now.month == 6 ? TextStyle(color: Colors.green[400]) : !(insects!.availability.monthArrayNorthern.contains(6)) ? TextStyle(color: Colors.grey[500]) : null,),
                                  ),
                          // Jul
                          Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7.5),
                                    decoration: insects!.availability.monthArrayNorthern.contains(7) ?
                                    BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white30
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7)), 
                                    )
                                    :
                                    null,
                                    child: Text("Jul", style: now.month == 7 ? TextStyle(color: Colors.green[400]) : !(insects!.availability.monthArrayNorthern.contains(7)) ? TextStyle(color: Colors.grey[500]) : null,),
                                  ),
                          // Aug
                          Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7.5),
                                    decoration: insects!.availability.monthArrayNorthern.contains(8) ?
                                    BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white30
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7)), 
                                    )
                                    :
                                    null,
                                    child: Text("Aug", style: now.month == 8 ? TextStyle(color: Colors.green[400]) : !(insects!.availability.monthArrayNorthern.contains(8)) ? TextStyle(color: Colors.grey[500]) : null,),
                                  ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Sep
                          Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7.5),
                                    decoration: insects!.availability.monthArrayNorthern.contains(9) ?
                                    BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white30
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7)), 
                                    )
                                    :
                                    null,
                                    child: Text("Sep", style: now.month == 9 ? TextStyle(color: Colors.green[400]) : !(insects!.availability.monthArrayNorthern.contains(9)) ? TextStyle(color: Colors.grey[500]) : null,),
                                  ),
                          // Oct
                          Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7.5),
                                    decoration: insects!.availability.monthArrayNorthern.contains(10) ?
                                    BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white30
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7)), 
                                    )
                                    :
                                    null,
                                    child: Text("Oct", style: now.month == 10 ? TextStyle(color: Colors.green[400]) : !(insects!.availability.monthArrayNorthern.contains(10)) ? TextStyle(color: Colors.grey[500]) : null,),
                                  ),
                          // Nov
                          Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7.5),
                                    decoration: insects!.availability.monthArrayNorthern.contains(11) ?
                                    BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white30
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7)), 
                                    )
                                    :
                                    null,
                                    child: Text("Nov", style: now.month == 11 ? TextStyle(color: Colors.green[400]) : !(insects!.availability.monthArrayNorthern.contains(11)) ? TextStyle(color: Colors.grey[500]) : null,),
                                  ),
                          // Dec
                          Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7.5),
                                    decoration: insects!.availability.monthArrayNorthern.contains(12) ?
                                    BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white30
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7)), 
                                    )
                                    :
                                    null,
                                    child: Text("Dec", style: now.month == 12 ? TextStyle(color: Colors.green[400]) : !(insects!.availability.monthArrayNorthern.contains(12)) ? TextStyle(color: Colors.grey[500]) : null,),
                                  ),
                        ],
                      ),
                    ],)
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 1,
                  child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: Offset(0, 1),
                            )
                          ],
                          color: Colors.white70,
                          border: Border.all(
                            color: Colors.white70
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)), 
                          ),
                          child: Column(
                            children: [
                              Text("Location"),
                              SizedBox(height: 5,),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 1),
                                  )
                                ],
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white30
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)), 
                                ),
                                child: Text(insects!.availability.location, style: TextStyle(fontSize: 10), textAlign: TextAlign.center,),
                              ),
                              SizedBox(height: 5,),
                              Text("Rarity"),
                              SizedBox(height: 5,),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 1),
                                  )
                                ],
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white30
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)), 
                                ),
                                child: Text(Rarity.values[insects!.availability.rarity!.index].name.toLowerCase().capitalizeFirstofEach, style: TextStyle(fontSize: 10),),
                              ),
                              
                            ],
                          ),
                        ),
                )
              ],
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(left:15, right: 15, bottom: 15, top: 5),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                  color: Colors.white70,
                  border: Border.all(
                    color: Colors.white70
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(children: <Widget>[
                  Text("Available Hours"),
                  SizedBox(height: 10,),
                  SfLinearGauge(
                    minimum: 0,
                    maximum: 24,
                    interval: 3,
                    minorTicksPerInterval: 2,
                    ranges: getRanges(),
                    markerPointers: [LinearShapePointer(value: getCurrentHourPointer(), color: const Color(0xFF91d7db), offset: 1,)]
                  ),
                ],)
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(left:15, right: 15, bottom: 15),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                  color: Colors.white70,
                  border: Border.all(
                    color: Colors.white70
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Blathers Space", style: TextStyle(fontSize: 20), ),
                      Image.asset("assets/blathers.png", height: 50,)
                    ],
                  ),
                  Text(insects!.museumPhrase, textAlign: TextAlign.justify,)
                ],)
              ),
              SizedBox(height: 40,)
            ]
          ),
          )
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

  getCurrentHourPointer() {
    double value;
    DateTime now = DateTime.now();
    double minutes = now.minute / 60;

    value = now.hour + minutes;
    return value;
  }

  getRanges() {
    List hours = insects!.availability.timeArray;
    List <LinearGaugeRange>ranges = [];

    int maxsep = 0;
    for(int i = 1; i < hours.length; i++) {
      if((hours[i-1] - hours[i]).abs() > maxsep) {
        maxsep = (hours[i-1] - hours[i]).abs();
      }
    }

    if(maxsep == 1){
      if(hours.contains(23) && hours.contains(0)) {
        ranges.add(LinearGaugeRange(startValue: 0.0, endValue: 24.0, position: LinearElementPosition.cross, color: const Color(0xFF94cead),));
      } else {
        ranges.add(LinearGaugeRange(startValue: hours[0].toDouble(), endValue: hours[hours.length - 1].toDouble(), position: LinearElementPosition.cross, color: const Color(0xFF94cead),));
      }
    }
    else {
      if(hours.contains(23) && hours.contains(0)) {
        ranges.add(LinearGaugeRange(startValue: hours[0].toDouble(), endValue: 24.0, position: LinearElementPosition.cross, color: const Color(0xFF94cead),));
        ranges.add(LinearGaugeRange(startValue: 0.0, endValue: hours[hours.length - 1].toDouble(), position: LinearElementPosition.cross, color: const Color(0xFF94cead),));
      } else {
        for(int i = 1; i < hours.length; i++) {
          if((hours[i-1] - hours[i]).abs() == 1) {
            ranges.add(LinearGaugeRange(startValue: hours[i-1].toDouble(), endValue: hours[i].toDouble(), position: LinearElementPosition.cross, color: const Color(0xFF94cead),));
          }
        }
      }
    }
    print(hours);
    return ranges;

  }
}
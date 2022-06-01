import 'package:final_app/main.dart';
import 'package:final_app/model/art_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';

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

  Map statuesImages = {
    'ancient_statue' : 'Doguu',
    'beautiful_statue':"Milo",
    'familiar_statue':"Thinker",
    'gallant_statue':"David",
    'great_statue':"Kamehameha",
    'informative_statue':"RosettaStone",
    'motherly_statue':"Capitolini",
    'mystic_statue':"Nefertiti",
    'robust_statue':"Diskobolos",
    'rock-head_statue':"OlmecaHead",
    'tremendous_statue':"HoumuwuDing",
    'valiant_statue':"Samothrace",
    'warrior_statue':"Heibayo",
  };

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            //width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      //constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/2.2, maxHeight: MediaQuery.of(context).size.height/3.7,),
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
                          Text("Real", style: TextStyle(
                            fontSize: 24
                          ),),
                          SizedBox(height: 10,),
                          FullScreenWidget(
                            child: Center(
                              child: Hero(
                                tag: "smallImage",
                                child: Image.network(
                                  art!.fileName.contains("statue") ?
                                  "https://acnhcdn.com/latest/FtrIcon/FtrSculpture${statuesImages[art!.fileName]}.png"
                                  :
                                  art!.artUri!,
                                  fit: BoxFit.cover,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    flex: 1,
                    child: Container(
                      //constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/2.2, maxHeight: MediaQuery.of(context).size.height/3.7,),
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
                          Text("Fake", style: TextStyle(
                            fontSize: 24
                          ),),
                          SizedBox(height: 10,),
                          !(art!.hasFake) ?
                          Container(
                            padding: EdgeInsets.only(bottom:10, top: 5),
                            child: Text("No fake",
                              style: TextStyle(
                                fontStyle: FontStyle.italic
                              ),))
                          :
                          FullScreenWidget(
                            child: Center(
                              child: Hero(
                                tag: "smallFakeImage",
                                child: Image.network(
                                  art!.fileName.contains("statue") ?
                                  "https://acnhcdn.com/latest/FtrIcon/FtrSculpture${statuesImages[art!.fileName]}Fake.png"
                                  :
                                  art!.artFakeUri!,
                                  fit: BoxFit.cover,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
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
                        Text("Redd Sell Price", style: TextStyle(fontSize: 14),),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/redd.png", height: 30,),
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
                              child: Text(art!.buyPrice.toString()+r"$"),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text("Nook's Buy Price"),
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
                              child: Text(art!.sellPrice.toString()+r"$"),
                            )
                          ],
                        )
                      ],
                    )
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
                            Icon(FontAwesomeIcons.landmark, size: 19, color: Colors.black87,),
                            SizedBox(width: 5,),
                            Text("Museum"),
                            Checkbox(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
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
                        ),
                      ],
                    ),
                    ),
                  ),
                  
            ]),
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
                            Text(art!.museumDesc!, textAlign: TextAlign.justify,)
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
}
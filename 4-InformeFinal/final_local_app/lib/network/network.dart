import 'dart:convert';

import 'package:final_local_app/model/art_model.dart';
import 'package:final_local_app/model/fishes_model.dart';
import 'package:final_local_app/model/sea_model.dart';
import 'package:final_local_app/util/json_art.dart';
import 'package:flutter/services.dart';
import 'package:final_local_app/model/insects_model.dart';
import 'package:http/http.dart';


class Network {
  static var insectUrl = "https://acnhapi.com/v1/bugs/";
  static var fishUrl = "https://acnhapi.com/v1/fish/";
  static var seaUrl = "https://acnhapi.com/v1/sea/";
  static var artUrl = "https://acnhapi.com/v1/art/";
  static var artJson = artJSON;

  static Future<Map<String, Insects>> getInsects() async {
    try{
      final response = await get(Uri.parse(insectUrl));
      if(response.statusCode == 200) {
        final Map<String, Insects> insects = insectsFromJson(response.body);
        return insects;
      } else {
        return <String, Insects>{};
      }
    } catch (e) {
      return <String, Insects>{};
    }
  }

  static Future<Map<String, Fishes>> getFishes() async {
    try{
      final response = await get(Uri.parse(fishUrl));
      if(response.statusCode == 200) {
        final Map<String, Fishes> fishes = fishesFromJson(response.body);
        return fishes;
      } else {
        return <String, Fishes>{};
      }
    } catch (e) {
      return <String, Fishes>{};
    }
  }

  static Future<Map<String, Sea>> getSea() async {
    try{
      final response = await get(Uri.parse(seaUrl));
      if(response.statusCode == 200) {
        final Map<String, Sea> sea = seaFromJson(response.body);
        return sea;
      } else {
        return <String, Sea>{};
      }
    } catch (e) {
      return <String, Sea>{};
    }
  }

  static Future<Map<String, Art>> getArt() async {
    try{
      final response = await rootBundle.loadString('assets/art.json');
      final Map<String, Art> art = artFromJson(response);
      return art;
    } catch (e) {
      print(e);
      return <String, Art>{};
    }
    
  }
}


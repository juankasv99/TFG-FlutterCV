import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:final_app/model/insects_model.dart';
import 'package:http/http.dart';


class Network {
  static var insectUrl = "https://acnhapi.com/v1/bugs/";
  static var fishUrl = "https://acnhapi.com/v1/fish/";

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
}


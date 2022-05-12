import 'package:flutter/material.dart';
import 'package:final_app/model/insects_model.dart';

const Map<int, String> monthsInYear = {
    1: "Jan",
    2: "Feb",
    3: "Mar",
    4: "Apr",
    5: "May",
    6: "Jun",
    7: "Jul",
    8: "Aug",
    9: "Sep",
    10: "Oct",
    11: "Nov",
    12: "Dec",
  };

  String getAvailableMonth(dynamic animal) {
  String dateSpan = animal.availability.monthNorthern;
  String result = "";

  if (dateSpan == "") {
    //Todo el año
    result = "All year";
  } else {
    if (dateSpan.contains("&")) {
      //Dos franjas
      List months = dateSpan.split(" & ");

      for (var i = 0; i < months.length; i++) {
        List nums;
        nums = months[i].split("-");
        for (var j = 0; j < nums.length; j++) {
          nums[j] = monthsInYear[int.parse(nums[j])];
          result = result + nums[j].toString();

          j == 0 && nums.length > 1 ? result = result + "-" : null;
        }
        i == 0 ? result = result + " & " : null;
      }
    } else {
      //Caso normal
      List nums;
      nums = dateSpan.split("-");
      for (var j = 0; j < nums.length; j++) {
        //nums[j] = monthsInYear[int.parse(nums[j])];
        result = result + monthsInYear[int.parse(nums[j])].toString();
        j == 0 && nums.length > 1 ? result = result + "-" : null;
      }
    }
  }

  return result;
}
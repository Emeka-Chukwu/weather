import 'dart:convert' show jsonDecode;

import 'package:flutter/cupertino.dart';
import "package:geolocator/geolocator.dart";
import 'package:weatherapp/models/weathers_details.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  var fetch = http.Client();
  var API_KEY = "b7c14ea8982cdf8fcd9b8ffa1b87e289";
  var URL = "http://api.openweathermap.org/data/2.5/weather";

// api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={your api key}

  Position position;
  String name;
  Geolocator geolocator = Geolocator();
  TextEditingController initialTextName = TextEditingController();
  TextEditingController completedTextName = TextEditingController();

  Future<WeatherDetails> getCurrentLocation() async {
    if (initialTextName.text != "") {
      print(initialTextName);
      var urrl = "$URL?q=abeokuta&lon&$API_KEY";
      // Permissions permissions;
      // permissions.request();
      // await geolocator.forceAndroidLocationManager;
      // await geolocator
      //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      //     .then((Position position) {
      //   final url =
      //       "$URL+lat=${position.latitude}&lon=${position.longitude}&$API_KEY";
      // print("llllllllll");

      final details = await fetch.get(
          "http://api.openweathermap.org/data/2.5/weather?q=${initialTextName.text}&appid=b7c14ea8982cdf8fcd9b8ffa1b87e289&units=metric");
      // print(details.body);
      var json = jsonDecode(details.body);
      return WeatherDetails.fromJson(json);
    } else {
      Future.error("field cannot be empty");
    }
    // });
  }

  stringController(String value) => print(initialTextName.text);
}

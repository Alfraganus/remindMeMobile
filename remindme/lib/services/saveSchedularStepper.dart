import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class SaveSchedular {


  static void saveSchedular(String key,  val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, Function> specialKeys = {
      'color': (value) => prefs.setString('color', value),
      'title': (value) => prefs.setString('title', value),
      'is_everyday': (value) => prefs.setString('is_everyday', value),
      'oraliq_dates': (value) => prefs.setStringList('oraliq_dates', value),
      'week_days': (value) => prefs.setStringList('week_days', value),
      'times': (value) => prefs.setStringList('times', value),
    };

    if (specialKeys.containsKey(key)) {
      specialKeys[key]!(val);
    } else {
      prefs.setString(key, val.toString());
    }
    print( prefs.getString(key));
  }

  static Future<bool> getData(String Key) async  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(Key);
  }


  static Future<Map<String, dynamic>> values() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> specialKeys = {
      'color': prefs.getString('color'),
      'title': prefs.getString('title'),
      'is_everyday': prefs.getString('is_everyday'),
      'oraliq_dates': prefs.getStringList('oraliq_dates'),
      'week_days': prefs.getStringList('week_days'),
      'times': prefs.getStringList('times'),
    };
    return specialKeys;
  }

  static void send() async {
    Map<String, dynamic> specialKeys = await values();

    final url = Uri.parse("http://127.0.0.1:8000/create-solo-todo");

    specialKeys.forEach((key, value) {
      if (value is Function) {
        specialKeys[key] = value();
      }
    });

    final jsonData = jsonEncode(specialKeys);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonData,
    );

    if (response.statusCode == 200) {
      print("Data sent successfully");
    } else {
      print("Failed to send data. Status code: ${response.statusCode}");
    }
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class SaveSchedular {


  static void saveSchedular(String key,  val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, Function> specialKeys = {
      'oraliq_dates': (value) => prefs.setStringList('oraliq_dates', value),
    };

    if (specialKeys.containsKey(key)) {
      specialKeys[key]!(val);
    } else {
      prefs.setString(key, val.toString());
      print(prefs.getString('color'));
    }

  }

  static Future<bool> getData(String Key) async  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(Key);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class SaveSchedular {
  static void saveSchedular(String key, String val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
    print(prefs.getString('color'));
  }

  static Future<bool> getData(String Key) async  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(Key);
  }
}

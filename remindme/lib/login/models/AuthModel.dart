import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginModel {
  final String username;
  final String password;

  LoginModel({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

Future<http.Response> auth(String url, username, password) async {
  final result = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );
  if (result.statusCode == 200) {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> responseMap = jsonDecode(result.body);
    await prefs.setString('token', responseMap['access_token']);
    await prefs.setBool('logged_in', true);

  }
  return result;
}

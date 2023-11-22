import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Column(
        children: [
          Text("Hello world"),
          ElevatedButton(onPressed:() async{
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('logged_in', false);
            context.router.pushNamed('/login');
          },
              child: Text('click to log out',style: TextStyle(color: Colors.white),)
          )
        ],
      ),
    );
  }
}

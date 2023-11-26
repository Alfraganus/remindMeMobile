import 'package:auto_route/auto_route.dart';
import 'package:remindme/login/Screens/Login/components/login_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool loggedIn = pref.getBool('logged_in') ?? false;
    if (loggedIn) {
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      router.push(WelcomeRoute());
    }
  }
} 

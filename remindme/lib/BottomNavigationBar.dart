import 'package:flutter/material.dart';
import 'package:remindme/Test.dart';
import 'login/Screens/Login/login_screen.dart';
import 'login/Screens/Welcome/welcome_screen.dart';
import 'notifications/addNotification/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<Widget> bottomWidgetList = <Widget>[
  AddNotification(),
  Test(),
  WelcomeScreen(),
];

List<BottomNavigationBarItem> Navigation = [
  BottomNavigationBarItem(
    icon: Image.asset(
      'assets/icons/payment.png', // Replace 'your_image_file.png' with the actual path to your image asset
      width: 40,
    ),
    label: 'Upcoming events',
  ),
  BottomNavigationBarItem(
    icon: Image.asset(
      'assets/icons/add-reminderr.png', // Replace 'your_image_file.png' with the actual path to your image asset
      width: 40,
    ),
    label: 'Add notification',
  ),
  BottomNavigationBarItem(
    icon: Image.asset(
      'assets/icons/spin-around.png', // Replace 'your_image_file.png' with the actual path to your image asset
      width: 40,
    ),
    label: 'Event history',
  ),
];


class CommonBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

 final List<Widget> _widgetOptions = <Widget>[
    Test(),
    LoginScreen(),
    WelcomeScreen(),
  ];

  CommonBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/payment.png', // Replace 'your_image_file.png' with the actual path to your image asset
            width: 40,
          ),
          label:AppLocalizations.of(context)!.upcoming_events,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/add-reminderr.png', // Replace 'your_image_file.png' with the actual path to your image asset
            width: 40,
          ),
          label: AppLocalizations.of(context)!.add_notification,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/spin-around.png', // Replace 'your_image_file.png' with the actual path to your image asset
            width: 40,
          ),
          label: AppLocalizations.of(context)!.event_history,
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}








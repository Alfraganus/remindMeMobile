import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remindme/notifications/addNotification/components/StepColor.dart';
import '../../BottomNavigationBar.dart';

@RoutePage()
class AddNotification extends StatelessWidget {
  const AddNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        type: StepperType.horizontal,
        margin: EdgeInsets.zero,
        currentStep: 0,
        steps: [
          Step(title: Text("Choose color"), content: StepColor())
        ],
      ),

    );
  }
}

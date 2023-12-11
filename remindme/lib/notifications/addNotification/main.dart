import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remindme/notifications/addNotification/components/StepColor.dart';
import 'package:remindme/notifications/addNotification/components/StepTaskTitle.dart';
import '../../BottomNavigationBar.dart';
import 'components/StepScheduler.dart';

@RoutePage()
class AddNotification extends StatefulWidget {
  const AddNotification({Key? key}) : super(key: key);

  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  int currentStep = 0;

  continueStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep = currentStep + 1;
      });
    }
  }
  stepStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }
  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      // physics: ScrollPhysics(),
      type: StepperType.horizontal,
      // margin: EdgeInsets.zero,
      currentStep: /*currentStep*/ 2 ,
      onStepContinue: continueStep,
      onStepCancel: stepStep,
      onStepTapped:onStepTapped,
      steps: [
        Step(
            title: Text("Color"),
            content: SingleChildScrollView(child: StepColor()),
            isActive: currentStep >= 0,
            state:currentStep >= 1 ? StepState.complete : StepState.disabled
        ),
        Step(
            title: Text("Title"),
            content:SingleChildScrollView(child: StepTitle()),
            isActive: currentStep >= 1,
            state:currentStep >= 2 ? StepState.complete : StepState.disabled
        ),
        Step(
            title: Text("Timing"),
            content:StepSchedular(),
            isActive: currentStep >= 2,
            state:currentStep >= 3 ? StepState.complete : StepState.disabled
        )
      ],
    );
  }
}

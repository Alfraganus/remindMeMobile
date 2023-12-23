import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remindme/bloc/EventFormCubit.dart';
import 'package:remindme/notifications/addNotification/components/StepColor.dart';
import 'package:remindme/notifications/addNotification/components/StepTaskTitle.dart';
import '../../bloc/ColorChooserCubit.dart';
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
    bool stepForward = false;
    if (currentStep < 2) {
      if(currentStep == 0 && BlocProvider.of<ColorChooserCubit>(context).state.selectedColor!.length > 1) {
        stepForward = true;
      }
      if(currentStep == 1 &&
          BlocProvider.of<EventFormCubit>(context).state.title != 'Tap plus to set a title for the event' &&
          BlocProvider.of<EventFormCubit>(context).state.title != ''
      ) {
        stepForward = true;
      }
    }
    if (currentStep == 2) {
      print(123);
    }
    setState(() {
      if (stepForward) {
        currentStep = currentStep + 1;
        stepForward = false;
        print('Current Step: $currentStep');
      }
    });
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
      physics:AlwaysScrollableScrollPhysics(),
      // margin: EdgeInsets.zero,
      currentStep: currentStep,
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
            content:SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: StepSchedular()
            ),
            isActive: currentStep >= 2,
            state:currentStep >= 3 ? StepState.complete : StepState.disabled
        )
      ],
    );
  }
}

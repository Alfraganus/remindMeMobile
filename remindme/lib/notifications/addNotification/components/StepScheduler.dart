import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../bloc/EventFormCubit.dart';

class StepSchedular extends StatefulWidget {
  const StepSchedular({Key? key}) : super(key: key);

  @override
  State<StepSchedular> createState() => _SchedularState();
}

class _SchedularState extends State<StepSchedular> {
  DateTime? selectedTime;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventFormCubit, EventForm>(
      builder: (context, state) {
        return Column(
          children: [
            GestureDetector(
              onTap: () async {
                var time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        // This uses the _timePickerTheme defined above
                        timePickerTheme: _timePickerTheme,
                        textButtonTheme: TextButtonThemeData(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.orange),
                            foregroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white),
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.deepOrange),
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (time != null) {
                  List<String?>? currentList = state.dates;
                  currentList.add(time.hour.toString());
                  BlocProvider.of<EventFormCubit>(context).setNewTime(currentList);
                }

              },
              child: Icon(
                Icons.add_circle,
                color: Colors.green,
                size: 60.0,
              ),
            ),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.dates.length,
                itemBuilder: (context, index) {
                  var date = state.dates[index] ?? 'N/A'; // Provide a default value if null
                  return ListTile(
                    title: Text(date),
                  );
                },
              ),
            )

          ],
        );
      },
    );
  }
}

final _timePickerTheme = TimePickerThemeData(
  backgroundColor: Colors.blueGrey,
  hourMinuteShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Colors.orange, width: 4),
  ),
  dayPeriodBorderSide: const BorderSide(color: Colors.orange, width: 4),
  dayPeriodColor: Colors.blueGrey.shade600,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Colors.orange, width: 4),
  ),
  dayPeriodTextColor: Colors.white,
  dayPeriodShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Colors.orange, width: 4),
  ),
  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? Colors.orange
          : Colors.blueGrey.shade800),
  hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? Colors.white : Colors.orange),
  dialHandColor: Colors.blueGrey.shade700,
  dialBackgroundColor: Colors.blueGrey.shade800,
  hourMinuteTextStyle:
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  dayPeriodTextStyle:
      const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  helpTextStyle: const TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(0),
  ),
  dialTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? Colors.orange : Colors.white),
  entryModeIconColor: Colors.orange,
);

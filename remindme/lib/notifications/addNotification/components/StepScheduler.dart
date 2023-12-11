import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:toggle_switch/toggle_switch.dart';
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
            RepeatDaily(),
            MultpleDateChooser(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Yangi vaqt kiritish",
                      style: TextStyle(fontSize: 25),
                    )),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
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
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.orange),
                                  foregroundColor:
                                      MaterialStateColor.resolveWith(
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
                        currentList.add(time.hour.toString() +
                            " : " +
                            time.minute.toString());
                        BlocProvider.of<EventFormCubit>(context)
                            .setNewTime(currentList);
                      }
                    },
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.green,
                      size: 60.0,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.dates.length,
                itemBuilder: (context, index) {
                  int timeOrder = index + 1;
                  var date = state.dates[index] ??
                      'N/A'; // Provide a default value if null
                  return Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 60,
                              decoration: new BoxDecoration(
                                color: HexColor("#24A19C"),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(
                                      15.0), // Adjust the radius as needed
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    '${timeOrder}-vaqt',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            VerticalDivider(width: 2.0),
                            Expanded(
                              child: Container(
                                width: 100,
                                // color: HexColor('#24A19C'),
                                child: BlocBuilder<EventFormCubit, EventForm>(
                                  builder: (context, state) {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        date,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<EventFormCubit>(context)
                                    .removeTimeByIndex(index);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                  size: 35.0,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(color: Colors.black12),
                      ],
                    ),
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

class MultpleDateChooser extends StatelessWidget {
  const MultpleDateChooser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Oraliq kun tanlarda",
          style: TextStyle(fontSize: 18),
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              // isScrollControlled: true,
              builder: (BuildContext context) {
               return  SfDateRangePicker(
                 view: DateRangePickerView.month,
                 selectionMode: DateRangePickerSelectionMode.multiple,
                 // initialSelectedDate: selectedDate,
                 onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                   // Handle date selection changes if needed
                   print(args.value);
                 },
               );
              },
            );
            // FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text("Tap me"),
        ),
      ],
    );
  }

  void _showDatePickerPopup(BuildContext context) async {
    DateTime selectedDate =
        DateTime.now(); // Set initial selected date if needed

    await showDialog(
      context: context,
      builder: (BuildContext builderContext) {
        return AlertDialog(
          title: Text('Select Date'),
          content: Container(
            height: 500, // Adjust the height as needed
            width: MediaQuery.of(context).size.width, // Set a fixed width
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.multiple,
              initialSelectedDate: selectedDate,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                // Handle date selection changes if needed
                print(args.value);
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(builderContext).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class RepeatDaily extends StatelessWidget {
  const RepeatDaily({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Har kuni takrorlansin",
          style: TextStyle(fontSize: 18),
        ),
        ToggleSwitch(
          customWidths: [90.0, 50.0],
          cornerRadius: 20.0,
          activeBgColors: [
            [Colors.cyan],
            [Colors.redAccent]
          ],
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.white,
          totalSwitches: 2,
          labels: ['XA', 'Yo\'q'],
          // icons: [null, FontAwesomeIcons.times],
          onToggle: (index) {
            print('switched to: $index');
          },
        ),
      ],
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

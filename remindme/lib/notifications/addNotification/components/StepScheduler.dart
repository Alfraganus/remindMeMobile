import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remindme/bloc/EventFormCalendarCubit.dart';
import 'package:remindme/bloc/EventFormTimeCubit.dart';
import 'package:remindme/bloc/EventFormWeekCubit.dart';
import 'package:remindme/services/saveSchedularStepper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:weekday_selector/weekday_selector.dart';
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
            SizedBox(height: 20),
            if (state.isEveryday == 'no') ...[
              MultpleDateChooser(),
              SizedBox(height: 20),
              MultipleWeekDateChooser(),
            ],
            SizedBox(height: 20),
            TimeList(),
          ],
        );
      },
    );
  }
}

class TimeList extends StatelessWidget {
  const TimeList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventFormTimeCubit, EventFormTime>(
  builder: (context, state) {
    return Column(
      children: [
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
        SizedBox(height: 20),
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
                            child: BlocBuilder<EventFormTimeCubit, EventFormTime>(
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
                            BlocProvider.of<EventFormTimeCubit>(context)
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
    return BlocBuilder<EventFormCalendarCubit, EventFormCalendar>(
  builder: (context, state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Oraliq kun tanlarda",
          style: TextStyle(fontSize: 18),
        ),
        if (state.calendarDates != null && state.calendarDates!.isNotEmpty)
          Icon(
            Icons.done_outline_sharp,
            color: Colors.green,
          ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              // isScrollControlled: true,
              builder: (BuildContext context) {
                return  ListView(
                  children: [
                    Container(
                      height: 400, // Adjust the height as needed
                      width: MediaQuery.of(context).size.width, // Set a fixed width
                      child: SfDateRangePicker(
                        initialSelectedDates: state.calendarDates,
                        view: DateRangePickerView.month,
                        selectionMode: DateRangePickerSelectionMode.multiple,
                        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                          context.read<EventFormCalendarCubit>().setDates(args.value);
                          print(state.calendarDates);
                          // print(args.value.runtimeType);
                        },
                      ),
                    ),

                  ],
                );
              },
            );
            // FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.calendar_month_outlined,
              size: 40,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  },
);
  }

}

class MultipleWeekDateChooser extends StatefulWidget {
  const MultipleWeekDateChooser({
    Key? key,
  }) : super(key: key);

  @override
  _MultipleWeekDateChooserState createState() => _MultipleWeekDateChooserState();
}

class _MultipleWeekDateChooserState extends State<MultipleWeekDateChooser> {
  List<bool> values = List.filled(7, false);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventFormWeekCubit, EventFormWeek>(
  builder: (context, state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Xafta kunlarida",
          style: TextStyle(fontSize: 18),
        ),
        if (state.weekListBool.any((bool value) => value))
          Icon(
            Icons.done_outline_sharp,
            color: Colors.green,
          ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return ListView(
                      children: [
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: WeekdaySelector(
                            onChanged: (int day) {
                              context.read<EventFormWeekCubit>().setWeekDays(day);
                            },
                            values: state.weekListBool,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle button press
                          },
                          child: Text(
                            "Choose weekdays",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
          child : Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.calendar_month_outlined,
              size: 40,
              color: Colors.green,
            ),
          ),
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
    return BlocBuilder<EventFormCubit, EventForm>(
  builder: (context, state) {
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
          initialLabelIndex:state.toggleSwich,
          activeFgColor: Colors.white,
          activeBgColors: [
            [Colors.red],
            [Colors.green],
          ],
          // inactiveBgColor: Colors.red,
          inactiveFgColor: Colors.white,
          totalSwitches: 2,
          labels: ['Yo\'q', 'XA'],
          // icons: [null, FontAwesomeIcons.times],
          onToggle: (index) {
            int changeToggle = index!;
            String val = index == 0 ? 'no' : 'yes';
            BlocProvider.of<EventFormCubit>(context).changeToggle(changeToggle,val);
            if(val == 'yes') {
              SaveSchedular.saveSchedular('is_everyday', 'yes');
            }
            print(val);
          },
        ),
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

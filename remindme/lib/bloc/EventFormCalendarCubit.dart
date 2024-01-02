import 'package:bloc/bloc.dart';

import '../services/saveSchedularStepper.dart';

class EventFormCalendarCubit extends Cubit<EventFormCalendar> {
  EventFormCalendarCubit() : super(EventFormCalendar());


  void setDates(dateStrings) {
    List<DateTime> dates = dateStrings.map((dateString) => DateTime.parse(dateString)).toList();
    emit(EventFormCalendar(calendarDates: dateStrings));
    SaveSchedular.saveSchedular('oraliq_dates', dates);
  }



}

class EventFormCalendar {
  List<DateTime>? calendarDates;
  EventFormCalendar({
    this.calendarDates,
  });
}

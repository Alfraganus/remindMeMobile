import 'package:bloc/bloc.dart';

import '../services/saveSchedularStepper.dart';

class EventFormCalendarCubit extends Cubit<EventFormCalendar> {
  EventFormCalendarCubit() : super(EventFormCalendar());


  void setDates(dates) {
    emit(EventFormCalendar(calendarDates: dates));
    // SaveSchedular.saveSchedular('oraliq_dates', state.calendarDates.toString());
  }


}

class EventFormCalendar {
  List<DateTime>? calendarDates;
  EventFormCalendar({
    this.calendarDates,
  });
}

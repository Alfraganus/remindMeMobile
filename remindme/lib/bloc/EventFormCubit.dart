import 'package:bloc/bloc.dart';

import '../services/saveSchedularStepper.dart';

class EventFormCubit extends Cubit<EventForm> {
  EventFormCubit()
      : super(EventForm(
            title: 'Tap plus to set a title for the event')); // Initial index

  void setTitle(String Title) {
    emit(EventForm(title: Title));
  }

  void setNewTime(List<String?> time) {
    emit(EventForm(dates: time));
  }

  void removeTimeByIndex(int index) {
    if (index >= 0 && index < state.dates.length) {
      List<String?> updatedDates = List.from(state.dates);
      updatedDates.removeAt(index);
      emit(EventForm(dates: updatedDates));
    }
  }

  void changeToggle(int toggle, String isEveryday) {
    emit(EventForm(toggleSwich: toggle, isEveryday: isEveryday));
  }

  void setDates(dates) {
    emit(EventForm(calendarDates: dates));
    SaveSchedular.saveSchedular('oraliq_dates', state.calendarDates.toString());
  }

  void setWeekDays(days) {
    List<int>? currentDays = state.weekDays;
    if (currentDays != null) {
      currentDays.add(days);
    } else {
      currentDays = [days];
    }
    emit(EventForm(weekDays: currentDays));
  }
}

class EventForm {
  String? title;
  List<String?> dates;
  String? isEveryday;
  int toggleSwich;
  List<int>?weekDays;
  List<DateTime>? calendarDates;

  EventForm({
    this.title = '', // Make it a const if it's a string literal.
    this.toggleSwich = 0,
    this.calendarDates,
    this.weekDays,
    List<String?>? dates, // Use a nullable type for dates.
    this.isEveryday = 'no', // Use a nullable type for dates.
  }) : dates = dates ?? [];
}

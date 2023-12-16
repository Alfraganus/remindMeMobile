import 'package:bloc/bloc.dart';

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

  void remindEveryEveryDay(int value) {
    emit(EventForm(isEveryday: value == 0 ? true : false));
  }
}

class EventForm {
  String? title;
  List<String?> dates;
  bool? isEveryday;

  EventForm({
    this.title = '', // Make it a const if it's a string literal.
    List<String?>? dates, // Use a nullable type for dates.
    this.isEveryday = false, // Use a nullable type for dates.
  }) : dates = dates ?? [];
}

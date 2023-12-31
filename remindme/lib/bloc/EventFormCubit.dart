import 'package:bloc/bloc.dart';

import '../services/saveSchedularStepper.dart';

class EventFormCubit extends Cubit<EventForm> {
  EventFormCubit()
      : super(EventForm(
            title: 'Tap plus to set a title for the event')); // Initial index

  void setTitle(String Title) {
    SaveSchedular.saveSchedular('title', Title);
    emit(EventForm(title: Title));
  }

  void setNewTime(List<String?> time) {
    emit(EventForm(dates: time));
  }

  void changeToggle(int toggle, String isEveryday) {
    SaveSchedular.saveSchedular('is_everyday', state.isEveryday == 'no' ? false : true);
    emit(EventForm(toggleSwich: toggle, isEveryday: isEveryday));
  }

}

class EventForm {
  String? title;
  List<String?> dates;
  String? isEveryday;
  int toggleSwich;

  EventForm({
    this.title = '', // Make it a const if it's a string literal.
    this.toggleSwich = 0,
    List<String?>? dates, // Use a nullable type for dates.
    this.isEveryday = 'no', // Use a nullable type for dates.
  }) : dates = dates ?? [];
}

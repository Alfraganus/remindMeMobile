import 'package:bloc/bloc.dart';

import '../services/saveSchedularStepper.dart';

class EventFormTimeCubit extends Cubit<EventFormTime> {
  EventFormTimeCubit()
      : super(EventFormTime()); // Initial index


  void removeTimeByIndex(int index) {
    if (index >= 0 && index < state.dates.length) {
      List<String?> updatedDates = List.from(state.dates);
      updatedDates.removeAt(index);
      SaveSchedular.saveSchedular('is_everyday', updatedDates);
      emit(EventFormTime(dates: updatedDates));
    }
  }

  void changeToggle(int toggle, String isEveryday) {
    emit(EventFormTime(toggleSwich: toggle, isEveryday: isEveryday));
  }

}

class EventFormTime {
  List<String?> dates;
  String? isEveryday;
  int toggleSwich;

  EventFormTime({
    this.toggleSwich = 0,
    List<String?>? dates, // Use a nullable type for dates.
    this.isEveryday = 'no', // Use a nullable type for dates.
  }) : dates = dates ?? [];
}

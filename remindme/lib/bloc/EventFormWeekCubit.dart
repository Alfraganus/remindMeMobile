import 'package:bloc/bloc.dart';

class EventFormWeekCubit extends Cubit<EventFormWeek> {
  EventFormWeekCubit() : super(EventFormWeek(weekListBool: List.filled(7, false)));

  void setWeekDays(day) {
      int index = day % 7;
      state.weekListBool[index] = !state.weekListBool[index];
      emit(EventFormWeek(weekListBool:state.weekListBool));
  }
}

class EventFormWeek {
  List<bool>weekListBool;

  EventFormWeek({
   required this.weekListBool,
  });
}

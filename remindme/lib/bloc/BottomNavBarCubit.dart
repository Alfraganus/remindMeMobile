import 'package:bloc/bloc.dart';

import 'BottomNavBarState.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarState(WidgetIndex: 0)); // Initial index

  void changeNavIndex(index) =>
      emit(BottomNavBarState(WidgetIndex: state.WidgetIndex = index));

}

import 'package:bloc/bloc.dart';


class ColorChooserCubit extends Cubit<ColorChooserState> {
  ColorChooserCubit() : super(ColorChooserState(selectedColor: '')); // Initial index

  void changeSelectedColor(String selectedColor) {
    emit(ColorChooserState(selectedColor: selectedColor));
  }
}

class ColorChooserState {
  String? selectedColor;

  ColorChooserState({
    required this.selectedColor,
  });
}
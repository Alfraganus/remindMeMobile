import 'package:bloc/bloc.dart';
import 'package:remindme/services/saveSchedularStepper.dart';


class ColorChooserCubit extends Cubit<ColorChooserState> {
  ColorChooserCubit() : super(ColorChooserState(selectedColor: '')); // Initial index

  void changeSelectedColor(String selectedColor) {
    SaveSchedular.saveSchedular('color', selectedColor);
    emit(ColorChooserState(selectedColor: selectedColor));
  }
}

class ColorChooserState {
  String? selectedColor;

  ColorChooserState({
    required this.selectedColor,
  });
}
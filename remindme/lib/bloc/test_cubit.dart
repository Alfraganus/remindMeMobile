import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'test_state.dart';

class TestCubit extends Cubit<TestInitial> {
  TestCubit() : super(TestInitial(authState: 'nothing'));

  void authIsPending() =>
      emit(TestInitial(authState: state.authState = 'pending'));

  void authIsSuccessfull() =>
      emit(TestInitial(authState: state.authState = 'success'));

  void authIsNotSuccessfull() =>
      emit(TestInitial(authState: state.authState = 'failure'));
}

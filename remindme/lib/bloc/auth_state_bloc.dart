import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import '../login/models/AuthModel.dart';

// Define the events
enum AuthEvent { Authenticate }

// Define the states
enum AuthState { Initial, Loading, Success, Failure }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.Initial);


  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event == AuthEvent.Authenticate) {
      yield AuthState.Loading;

      try {
        var authSend = await auth(
          "https://new.spector77.uz/login",
          _loginController.text,
          _passwordController.text,
        );

        if (authSend.statusCode == 200) {
          yield AuthState.Success;
        } else {
          yield AuthState.Failure;
        }
      } catch (e) {
        yield AuthState.Failure;
      }
    }
  }
}

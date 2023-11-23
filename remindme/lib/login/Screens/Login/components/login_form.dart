import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../../../bloc/test_cubit.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../../models/AuthModel.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _loginController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _loginController,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your login",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              controller: _passwordController,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton (
              onPressed: () async{
                BlocProvider.of<TestCubit>(context).authIsPending();
                var authSend = null;
                authSend = await auth(
                    "https://new.spector77.uz/login",
                    _loginController.text,
                    _passwordController.text
                );
                if(authSend.statusCode == 200) {
                  BlocProvider.of<TestCubit>(context).authIsSuccessfull();
                  context.router.pushNamed('/');
                } else {
                  BlocProvider.of<TestCubit>(context).authIsNotSuccessfull();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Text("Login is not successful"),
                        content: Text("You are not allowed!"),
                      );
                    },
                  );
                }
              },
              child: BlocBuilder<TestCubit, TestInitial>(
                builder: (context, state) {
                  if (state.authState == 'pending') {
                    // Display a circular progress indicator while the state is pending
                    return CircularProgressIndicator();
                  } else {
                    // Display the login button with the text "Login"
                    return Text(
                      "Login".toUpperCase(),
                      style: TextStyle(color: kPrimaryLightColor),
                    );
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              context.router.pushNamed('/details');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:donatio_app/components/ParallelButton.dart';
import 'package:donatio_app/src/Auth.dart';
import 'package:donatio_app/src/Icomoon.dart';
import 'package:donatio_app/src/ThemePalette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  AppAuth authInstance;

  LoginScreen(this.authInstance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 60, 0, 10),
                  height: 80,
                  child: SvgPicture.asset(
                    "assets/logo_4.svg",
                    semanticsLabel: "DonatIO Logo",
                  ),
                ),
                Container(
                  child: Text("Donatio Login", style: FontPresets.title2),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: LoginForm(this.authInstance))
              ],
            ),
          ),
        ));
  }
}

class LoginForm extends StatefulWidget {
  AppAuth authInstance;

  LoginForm(this.authInstance, {Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState(this.authInstance);
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  AppAuth authInstance;
  _LoginFormState(this.authInstance);

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                  hintText: "email",
                  icon: Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Icon(Icomoon.profile))),
              validator: (value) {
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (emailValid) return null;
                return "Not in email format.";
              },
            ),
            Container(
              height: 30,
            ),
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                  hintText: "password",
                  icon: Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Icon(Icomoon.lock2))),
              validator: (value) {
                return null;
              },
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: ParallelButton.withAction("Login", 200, () {
                  print(_formKey.currentState.validate());

                  if (_formKey.currentState.validate()) {
                    // Attempt login if the fields are all valid
                    authInstance.login(
                        _usernameController.text, _passwordController.text,
                        onSuccess: () {
                      print("Successfully logged in!");
                      // attempt to navigate to the next scene.
                      Navigator.pushNamed(context, "/bottomTabView");
                    }, onFailure: () {
                      print("Login attempt failed...");
                    });
                  }
                  return null;
                }))
          ],
        ),
      ),
    );
  }
}

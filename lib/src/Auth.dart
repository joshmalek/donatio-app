/*
* Auth:
  - Auth class is meant to be passed to every screen that is displayed
    by the app. It will control the accessability of differernt screens
    based on if anyone is logeed in, and the permissions level of the
    user that is logged in.
*/
import 'dart:convert';

import 'package:body_parser/body_parser.dart';
import 'package:donatio_app/models/API.dart';
import 'package:http/http.dart' as http;

class AppPermission {
  static const int ENTRY = 0;
  static const int LOGGEDIN = 1;
  static const int ADMIN = 2;
}

class AppAuth {
  // attempt to load an auth token from the local app storage.
  int accessLevel = 0;
  String userId;

  final String API_URL = "http://10.0.2.2:4000/graphql";

  Auth() {
    accessLevel = 0;
    userId = null;
  }

  bool loggedIn() {
    return userId != null;
  }

  bool hasPermission(int permissionId) {
    return accessLevel >= permissionId;
  }

  Future login(String email, String password, Function() successCallack) {
    print(
        "Attempting login with credentials:\n\tEmail: ${email}\n\tPassword: ${password}");

    String loginQuery =
        'mutation { login(email: "${email}", password: "${password}") }';
    Future loginRequest = API.postQuery(API_URL, loginQuery);

    loginRequest.then((value) {
      print("Login Attempt");
      print(value.statusCode);
      print(value.headers.toString());
      print(value.body);
      print("done...");
    }).catchError((e) {
      print("Problem trying to login...");
      print(e);
    });

    return null;
  }
}

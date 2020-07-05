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
  Map<String, dynamic> userInfo = null;

  final String API_URL = "http://10.0.2.2:4000/graphql";

  Auth() {
    accessLevel = 0;
    userInfo = null;
  }

  bool loggedIn() {
    return userInfo != null;
  }

  bool hasPermission(int permissionId) {
    print(
        "User with access level ${accessLevel} attempting to access page with permisison level ${permissionId}.");
    return accessLevel >= permissionId;
  }

  Future login(String email, String password,
      {Function() onSuccess, Function() onFailure}) {
    print(
        "Attempting login with credentials:\n\tEmail: ${email}\n\tPassword: ${password}");
    print(
        "Current auth values:\n\taccessLevel: ${accessLevel}\n\t${userInfo == null ? "null" : userInfo.toString()}");

    String loginQuery =
        'mutation { login(email: "${email}", password: "${password}") {_id, firstName, lastName} }';
    Future loginRequest = API.postQuery(API_URL, loginQuery);

    loginRequest.then((res) {
      dynamic response = jsonDecode(res.body);
      print("Login attempt recieved response");
      print(response["data"]["login"]);

      if (response["data"]["login"] == null) {
        if (onFailure != null) onFailure();
      } else if (response["data"]["login"] != null) {
        // set the credentials for the auth instance
        userInfo = response["data"]["login"];
        // for now, everyone that is logged in will have accessLevel == AppPermission.LOGGEDIN
        accessLevel = AppPermission.LOGGEDIN;

        if (onSuccess != null) onSuccess();
      }
    }).catchError((e) {
      print("Problem trying to login...");
      print(e);
    });

    return null;
  }
}

/*
* Auth:
  - Auth class is meant to be passed to every screen that is displayed
    by the app. It will control the accessability of differernt screens
    based on if anyone is logeed in, and the permissions level of the
    user that is logged in.
*/
import 'dart:convert';

import 'package:donatio_app/models/API.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

    // when this Auth instance is initiated, it should try to get any data
    // of the user that is stored in the app local sorage. If any is present,
    // laod the data into the class and mark the user as logged in.
    AttemptRestoreUserSession();
  }

  void dispose() {
    // save the user information into the shared prefs.
    SaveUserSession();
  }

  void SaveUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("USER_SESSION", jsonEncode(userInfo));
    print("user session successfully set!");
  }

  void AttemptRestoreUserSession() async {
    print("Attempting to restore the user's previous session.");

    final prefs = await SharedPreferences.getInstance();
    final userSession = prefs.getString("USER_SESSION") ?? null;

    // TODO check if the session has expired.
    // TODO store session exiration information in the userInfo data.

    if (userSession != null) {
      userInfo = jsonDecode(userSession);
      accessLevel = AppPermission.ENTRY;
    }
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

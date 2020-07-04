/*
* Auth:
  - Auth class is meant to be passed to every screen that is displayed
    by the app. It will control the accessability of differernt screens
    based on if anyone is logeed in, and the permissions level of the
    user that is logged in.
*/

class AppPermission {
  static const int ENTRY = 0;
  static const int LOGGEDIN = 1;
  static const int ADMIN = 2;
}

class AppAuth {
  // attempt to load an auth token from the local app storage.
  int accessLevel = 0;
  String userId;

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

  Future login(String username, String password) {
    print(
        "Attempting login with credentials:\n\tUsername: ${username}\n\tPassword: ${password}");

    return null;
  }
}

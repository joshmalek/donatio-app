import 'package:donatio_app/components/Navbar.dart';
import 'package:donatio_app/screens/Dashboard.dart';
import 'package:donatio_app/screens/DonateScreen.dart';
import 'package:donatio_app/screens/Leaderboard.dart';
import 'package:donatio_app/screens/LockedMedals.dart';
import 'package:donatio_app/screens/LoginScreen.dart';
import 'package:donatio_app/screens/UnlockedMedals.dart';
import 'package:donatio_app/src/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteController {
  static Map<String, dynamic> RoutesConfig(AppAuth authInstance) {
    return {
      "/bottomTabView": {
        "destination": BottomNavbar(authInstance),
        "permissionLevel": AppPermission.LOGGEDIN
      },
      "/login": {
        "destination": LoginScreen(authInstance),
        "permissionLevel": AppPermission.ENTRY
      }
    };
  }

  static Route<dynamic> generateRoute(
      RouteSettings settings, AppAuth authInstance) {
    final args = settings.arguments;

    Map<String, dynamic> routesConfig = RoutesConfig(authInstance);

    // check if the name of the route exists
    if (!routesConfig.containsKey(settings.name)) {
      print("Route ${settings.name} does not exist...");
      return SlideRightRoute(page: LoginScreen(authInstance));
    }

    // check if the client has access to the page
    if (authInstance
        .hasPermission(routesConfig[settings.name]["permissionLevel"])) {
      print("User has permission to access ${settings.name}");
      return SlideRightRoute(page: routesConfig[settings.name]["destination"]);
    } else {
      print("Client attempted to access page with invalid permissions.");
      return null;
    }

    // switch (settings.name) {
    //   case '/bottomTabView':
    //     return SlideRightRoute(page: BottomNavbar());
    //   case '/dashboard':
    //     return SlideRightRoute(page: DashboardScreen());
    //   case '/unlockedMedals':
    //     return SlideRightRoute(page: UnlockedMedalsScreen());
    //   case '/lockedMedals':
    //     return SlideRightRoute(page: LockedMedalScreen());
    //   case '/leaderboard':
    //     return SlideRightRoute(page: LeaderboardScreen());
    //   case '/donate':
    //     return SlideRightRoute(page: DonateScreen());
    //   case '/login':
    //     return SlideRightRoute(page: LoginScreen());
    // }

    // // default
    // return MaterialPageRoute(
    //     builder: (BuildContext context) => DashboardScreen());
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class SlideLeftRoute extends PageRouteBuilder {
  final Widget page;
  SlideLeftRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

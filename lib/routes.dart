import 'package:donatio_app/screens/Dashboard.dart';
import 'package:donatio_app/screens/DonateScreen.dart';
import 'package:donatio_app/screens/Leaderboard.dart';
import 'package:donatio_app/screens/LockedMedals.dart';
import 'package:donatio_app/screens/UnlockedMedals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteController {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/dashboard':
        return SlideRightRoute(page: DashboardScreen());
      case '/unlockedMedals':
        return SlideRightRoute(page: UnlockedMedalsScreen());
      case '/lockedMedals':
        return SlideRightRoute(page: LockedMedalScreen());
      case '/leaderboard':
        return SlideRightRoute(page: LeaderboardScreen());
      case '/donate':
        return SlideRightRoute(page: DonateScreen());
    }

    // default
    return MaterialPageRoute(
        builder: (BuildContext context) => DashboardScreen());
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

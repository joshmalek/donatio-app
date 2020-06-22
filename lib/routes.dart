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
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case '/unlockedMedals':
        return MaterialPageRoute(builder: (_) => UnlockedMedalsScreen());
      case '/lockedMedals':
        return MaterialPageRoute(builder: (_) => LockedMedalScreen());
      case '/leaderboard':
        return MaterialPageRoute(builder: (_) => LeaderboardScreen());
      case '/donate':
        return MaterialPageRoute(builder: (_) => DonateScreen());
    }

    // default
    return MaterialPageRoute(builder: (_) => DashboardScreen());
  }
}

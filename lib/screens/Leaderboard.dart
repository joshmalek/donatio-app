import 'package:donatio_app/components/Navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Text("Leaderboard Screen Placeholder"),
        ),
        bottomNavigationBar: BottomNavbar());
  }
}

import 'package:donatio_app/components/Navbar.dart';
import 'package:donatio_app/src/ThemePalette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Dashboard.dart';

class UnlockedMedalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Text("Unlocked Medals Screen Placeholder"),
        ),
        bottomNavigationBar: BottomNavbar());
  }
}

class UnlockedMedalsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[AppHeader(), MedalsHeader()],
      ),
    );
  }
}

class MedalsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Column(
          children: <Widget>[
            Container(
              child: Text("Unlocked Medals", style: FontPresets.title1),
              alignment: Alignment.centerLeft,
            ),
            Container(
              child: Text("You unlocked 5 medals", style: FontPresets.label),
              alignment: Alignment.centerLeft,
            )
          ],
        ));
  }
}

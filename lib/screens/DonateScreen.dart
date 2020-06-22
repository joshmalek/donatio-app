import 'package:donatio_app/components/Navbar.dart';
import 'package:donatio_app/screens/Dashboard.dart';
import 'package:donatio_app/src/ThemePalette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DonateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Text("Donate Screen Placeholder"),
        ),
        bottomNavigationBar: BottomNavbar());
  }
}

class DonateBody extends StatelessWidget {
  @override
  Widget build(BuildContext conext) {
    return SafeArea(
        child: Column(
      children: <Widget>[AppHeader(), DonateHeader()],
    ));
  }
}

class DonateHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.centerLeft,
            child: Text("Donate", style: FontPresets.title1),
            margin: EdgeInsets.fromLTRB(50, 10, 50, 0)),
        Container(
            margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
            alignment: Alignment.centerLeft,
            child: Text("Want to donate to charity?"))
      ],
    ));
  }
}

class DonateParagraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

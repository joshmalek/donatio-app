import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../src/ThemePalette.dart';
import '../src/Icomoon.dart';

class Navbar extends StatelessWidget {
  String _screenName;
  Navbar(this._screenName);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.0,
        alignment: Alignment.centerLeft,
        child: SafeArea(
            child: Row(children: [
          Container(
              child: Icon(Icomoon.menu,
                  size: 17, semanticLabel: "Menu Icon", color: Colors.white),
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0)),
          Text(_screenName, style: Theme.of(context).textTheme.headline1)
        ])));
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Navbar("Dashboard"), UserProgressModal("Billy Jean")]));
  }
}

class UserProgressModal extends StatelessWidget {
  String _userName;

  UserProgressModal(this._userName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            child: Row(children: [Text(_userName), LevelPill(24)]),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 20)),
        Container(
            child: Column(
              children: [
                Container(
                  child: Text("Progress until level XX"),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                ),
                ProgressBar()
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 50)),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Lifetime Donations"),
          Container(
            child:
                Text("\$102.53", style: Theme.of(context).textTheme.headline3),
            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
          )
        ]),
      ]),
      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ThemePalette.secondary1),
    );
  }
}

class LevelPill extends StatelessWidget {
  final int _userLevel;

  LevelPill(this._userLevel);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text("Lv. ${_userLevel}",
            style: TextStyle(color: Colors.black, fontSize: 10)),
        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
        padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
        decoration: BoxDecoration(
            color: ThemePalette.inverse,
            borderRadius: BorderRadius.circular(2)));
  }
}

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: FractionallySizedBox(
          widthFactor: 0.72,
          heightFactor: 0.5,
          child: Container(
            decoration: BoxDecoration(
                color: ThemePalette.primary,
                borderRadius: BorderRadius.circular(5)),
          )),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: ThemePalette.inverse),
    );
  }
}

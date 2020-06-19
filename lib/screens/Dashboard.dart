import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(body: Navbar("Dashboard"));
  }
}

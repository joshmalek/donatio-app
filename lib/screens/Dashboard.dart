import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../src/Icomoon.dart';

class Navbar extends StatelessWidget {
  String _screen_name;
  Navbar(this._screen_name);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.0,
        color: Colors.red,
        alignment: Alignment.centerLeft,
        child: SafeArea(
            child: Row(children: [
          Icon(Icomoon.menu,
              size: 17, semanticLabel: "Menu Icon", color: Colors.white),
          Text(_screen_name)
        ])));
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Navbar("Dashboard"));
  }
}

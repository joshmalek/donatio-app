import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          SvgPicture.asset('menu.svg', semanticsLabel: "Menu Icon"),
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

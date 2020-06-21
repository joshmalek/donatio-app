import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../src/ThemePalette.dart';
import '../src/Icomoon.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavbar(),
        body: Text("Updated Dashboard"));
  }
}

class BottomNavbar extends StatelessWidget {

  @override
  Widget build (BuildContext context) {
    return Container(
            height: 40.0,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
            child: Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
              width: 150.0,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      child: Container(
                          width: (2 *
                                  ((MediaQuery.of(context).size.width - 80) /
                                      11)) -
                              10,
                          height: 40,
                          color: Colors.orange),
                      left: 5),
                  Row(
                    children: <Widget>[
                      Flexible(
                          flex: 2,
                          child: Container(
                              alignment: Alignment.center,
                              child: Icon(Icomoon.dashboard, size: 17))),
                      Flexible(
                          flex: 2,
                          child: Container(
                              alignment: Alignment.center,
                              child: Icon(Icomoon.hexagon2, size: 22))),
                      Flexible(
                          flex: 3,
                          child: Container(
                              child: SvgPicture.asset(
                                "assets/logo_2.svg",
                                semanticsLabel: "DonatIO Logo",
                              ),
                              height: 60,
                              alignment: Alignment.center)),
                      Flexible(
                          flex: 2,
                          child: Container(
                              alignment: Alignment.center,
                              child: Icon(Icomoon.trophy, size: 20))),
                      Flexible(
                          flex: 2,
                          child: Container(
                              alignment: Alignment.center,
                              child: Icon(Icomoon.coin, size: 18)))
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ))
  }
}
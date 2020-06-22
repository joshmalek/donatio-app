import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../src/ThemePalette.dart';
import '../src/Icomoon.dart';
import '../components/ParallelButton.dart';

class LockedMedalScreen extends StatefulWidget {
  @override
  LockedMedalState createState() => new LockedMedalState();
}

class LockedMedalState extends State<LockedMedalScreen>
    with TickerProviderStateMixin {
  double _height = 80.0;
  double _width = 80.0;
  var _color = Colors.blue;
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        SizedBox(height: 50),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Locked Medals",
                      style: Theme.of(context).textTheme.headline1),
                  Text("32 locked medals",
                      style: Theme.of(context).textTheme.headline2)
                ])),
        SizedBox(height: 20),
        GestureDetector(
            onTap: () {
              setState(() {
                selected = !selected;
              });
            },
            child: Center(
              child: AnimatedContainer(
                width: selected ? 250.0 : 200.0,
                height: 100,
                color: selected ? Colors.red : Colors.blue,
                alignment: selected
                    ? Alignment.center
                    : AlignmentDirectional.topCenter,
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                child: FlutterLogo(size: 75),
              ),
            ))
      ]),
    ));
  }
}
//        ParallelButton("Sample Button", 230.0)

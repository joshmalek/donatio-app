import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../src/ThemePalette.dart';
import '../src/Icomoon.dart';
import '../components/ParallelButton.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavbar(0),
        body: SafeArea(
          child: Column(children: [
            Container(
                child: Text("Dashboard: Header Placeholder"),
                height: 50,
                alignment: Alignment.centerLeft,
                color: Colors.orange),
            LevelModal(10),
            ViewLeaderboard(),
            DonatedModal(1205.23, "\$")
          ]),
        ));
  }
}

class DonatedModal extends StatelessWidget {
  double _amount;
  String _currencySymbol;

  DonatedModal(this._amount, this._currencySymbol);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
        padding: EdgeInsets.fromLTRB(20, 18, 20, 18),
        alignment: Alignment.topLeft,
        child: Column(
          children: <Widget>[
            Container(
              child: Text("${_currencySymbol}${_amount.toString()}",
                  style: FontPresets.colorTransform(
                      FontPresets.medium, ThemePalette.green2)),
              alignment: Alignment.centerLeft,
            ),
            Container(
                child: Text("Donated this week", style: FontPresets.title1),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(0, 5, 0, 15)),
          ]..addAll(_amount == 0
              ? emptyDonationView
              : donationSlider([
                  {'org': "BLM", 'amount': 102.4, 'day': 'Monday'},
                  {'org': "BLM", 'amount': 102.4, 'day': 'Monday'},
                  {'org': "BLM", 'amount': 102.4, 'day': 'Monday'},
                  {'org': "BLM", 'amount': 102.4, 'day': 'Monday'},
                  {'org': "BLM", 'amount': 102.4, 'day': 'Monday'},
                  {'org': "BLM", 'amount': 102.4, 'day': 'Monday'}
                ])),
        ),
        decoration: BoxDecoration(boxShadow: [
          new BoxShadow(
              color: ThemePalette.alphaColor(ThemePalette.shadow, 0.05),
              offset: new Offset(0.0, 1.0),
              spreadRadius: 2,
              blurRadius: 5)
        ], color: Colors.white, borderRadius: BorderRadius.circular(5)));
  }
}

List<Widget> donationSlider(List<Map<String, dynamic>> donations) {
  return <Widget>[
    Container(
      child: Stack(children: [
        Positioned(
            left: -50,
            child: Container(width: 100, height: 120, color: Colors.pink))
      ]),
      height: 120,
    )
  ];
}

// ListView(
//           children: <Widget>[
//             Container(
//                 width: 100,
//                 color: Colors.red,
//                 margin: EdgeInsets.fromLTRB(0, 0, 10, 0)),
//             Container(
//                 width: 100,
//                 color: Colors.blue,
//                 margin: EdgeInsets.fromLTRB(0, 0, 10, 0)),
//             Container(
//                 width: 100,
//                 color: Colors.cyan,
//                 margin: EdgeInsets.fromLTRB(0, 0, 10, 0)),
//             Container(
//                 width: 100,
//                 color: Colors.brown,
//                 margin: EdgeInsets.fromLTRB(0, 0, 10, 0))
//           ],
//           scrollDirection: Axis.horizontal,
//         )

List<Widget> emptyDonationView = [
  Container(
    child:
        Text("Want to start donating to charities?", style: FontPresets.small),
    alignment: Alignment.centerLeft,
  ),
  Container(
    child: ParallelButton("Donate", 150),
    margin: EdgeInsets.fromLTRB(0, 40, 0, 40),
  )
];

class ViewLeaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        height: 100,
        child: Stack(
          children: <Widget>[
            Positioned(
                child: SvgPicture.asset("assets/winner.svg",
                    semanticsLabel: 'Winner SVG'),
                width: 180,
                height: 100,
                left: 20,
                top: -10),
            Positioned(
                child: ParallelButton("View Leaderboard", 180),
                right: 40,
                top: 30),
          ],
        ));
  }
}

class LevelModal extends StatelessWidget {
  int _level;
  LevelModal(this._level);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
      padding: EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: Column(children: [
        Container(
            alignment: Alignment.centerLeft,
            child: Text("Level", style: FontPresets.title1)),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(_level.toString(), style: FontPresets.huge),
        ),
        Container(
            color: Colors.grey,
            height: 2,
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              heightFactor: 1,
              widthFactor: 0.4,
              child: Container(color: Colors.black),
            )),
        Container(
          alignment: Alignment.centerLeft,
          child: Text('20 more experience until you reach level ${_level + 1}!',
              style: FontPresets.small),
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        )
      ]),
      decoration: BoxDecoration(boxShadow: [
        new BoxShadow(
            color: ThemePalette.alphaColor(ThemePalette.shadow, 0.05),
            offset: new Offset(0.0, 1.0),
            spreadRadius: 2,
            blurRadius: 5)
      ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
    );
  }
}

class BottomNavbar extends StatelessWidget {
  int _pageIndex = 0;
  BottomNavbar(this._pageIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40.0,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
          width: 150.0,
          child: Stack(
            children: <Widget>[
              Positioned(
                  child: Container(
                      width: (2 *
                              ((MediaQuery.of(context).size.width - 60) / 11)) -
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
                            "assets/logo_4.svg",
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
          decoration: BoxDecoration(boxShadow: [
            new BoxShadow(
                color: ThemePalette.shadow,
                offset: new Offset(0.0, 1.0),
                spreadRadius: 2,
                blurRadius: 8)
          ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
        ));
  }
}

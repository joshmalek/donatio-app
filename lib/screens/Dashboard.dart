import 'package:donatio_app/components/Navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../src/ThemePalette.dart';
import '../src/Icomoon.dart';
import '../components/ParallelButton.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavbar(),
        body: SafeArea(
            child: Column(children: [
          Container(
              child: Text("Dashboard: Header Placeholder"),
              height: 50,
              alignment: Alignment.centerLeft,
              color: Colors.orange),
          LevelModal(10),
          ViewLeaderboard(),
          DonatedModal(1205.23, "\$"),
          DonatedList()
        ])));
  }
}

class DashboardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      Container(
          child: Text("Dashboard: Header Placeholder"),
          height: 50,
          alignment: Alignment.centerLeft,
          color: Colors.orange),
      LevelModal(10),
      ViewLeaderboard(),
      DonatedModal(1205.23, "\$"),
      DonatedList()
    ]));
  }
}

class AnotherBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Text("Hope this works!"));
  }
}

class DonatedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            singleDonation(),
            singleDonation(),
            singleDonation(),
            singleDonation(),
            singleDonation(),
            singleDonation(),
            singleDonation()
          ],
        ),
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0));
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
          ]..addAll(_amount == 0 ? emptyDonationView : []),
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

Widget singleDonation() {
  return Container(
    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
    width: 100,
    child: Column(
      children: <Widget>[
        Container(
          child: Text("Monday", style: FontPresets.buttonText),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
        ),
        Text("\$1302.12",
            style: FontPresets.colorTransform(
                FontPresets.title2, ThemePalette.green2)),
        Text("to Black Lives Matter", style: FontPresets.buttonText)
      ],
    ),
    decoration: BoxDecoration(
        color: ThemePalette.black, borderRadius: BorderRadius.circular(3)),
  );
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

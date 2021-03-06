import 'dart:convert';

import 'package:donatio_app/components/Navbar.dart';
import 'package:donatio_app/models/API.dart';
import 'package:donatio_app/src/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math';

import '../src/ThemePalette.dart';
import '../src/Icomoon.dart';
import '../components/ParallelButton.dart';

double evaluateExperience(double experience_value) {
  if (experience_value == 0) return 1;
  return log((5 * experience_value) + 1);
}

int getLevel(double experience) {
  // get the level of the user based on the experience
  return evaluateExperience(experience).floor();
}

double getExperiencePercent(double experience) {
  double experienceLevel = evaluateExperience(experience);
  // find the experience for the low and high level.
  int lowerLevel = getLevel(experience);
  int higherLevel = lowerLevel + 1;

  // find the experience needed for lowerLevel and the experience
  // needed for highLevel
  double base = 2.71828;
  double lowerLevelExp = (pow(base, lowerLevel) - 1) / 5;
  double higherLevelExp = (pow(base, higherLevel) - 1) / 5;

  // experience should be between lowerLevelExp and higherLevelExp
  if (experience >= lowerLevelExp && experience <= higherLevelExp) {
    double percent_ =
        (experience - lowerLevelExp) / (higherLevelExp - lowerLevelExp);
    print("Exp Percent is : ${percent_}");
    print("lower level: ${lowerLevel}, higher level: ${higherLevel}");
    print("${lowerLevelExp} < ${experience} < ${higherLevelExp}");
    return max(0, min(percent_, 1));
  } else {
    print("Calculating getExperiencePercent went wrong...");
    print("lower level: ${lowerLevel}, higher level: ${higherLevel}");
    print("${lowerLevelExp} < ${experience} < ${higherLevelExp}");
    return 0;
  }
}

int getRaminingExperience(double experience) {
  double experienceLevel = evaluateExperience(experience);
  // find the experience for the low and high level.
  int higherLevel = getLevel(experience) + 1;

  double base = 2.71828;
  double higherLevelExp = (pow(base, higherLevel) - 1) / 5;
  return (higherLevelExp - experience).floor();
}

class DashboardBody extends StatefulWidget {
  AppAuth authInstance;
  DashboardBody(this.authInstance) {
    print("DashboardBody instantiated");
  }

  @override
  _DashboardBodyState createState() => _DashboardBodyState(this.authInstance);
}

class _DashboardBodyState extends State<DashboardBody> {
  AppAuth authInstance;

  List<dynamic> user_receipts = null;

  _DashboardBodyState(this.authInstance) {
    user_receipts = null;
    fetch();
  }

  void fetch() {
    // attempt to get the user's receipts
    Future receiptsFuture = API.getUserWeekReceipts(
        authInstance.userInfo == null
            ? "<null>"
            : authInstance.userInfo["_id"]);

    receiptsFuture.then((res) {
      print("Receipts responded with status ${res.statusCode}");
      dynamic response = jsonDecode(res.body);
      print(response.toString());

      setState(() {
        user_receipts = response["data"]["weekReceipts"];
        print(user_receipts.toString());
      });
    }).catchError((error) {
      print("Fetching receipts responded with error");
      print(error);
    });
  }

  double receiptTotal() {
    // sum up the values in the receipt and return the total
    // amount.
    double total = 0;
    for (int i = 0; i < user_receipts.length; ++i) {
      if (user_receipts[i].containsKey("amount"))
        total += user_receipts[i]["amount"];
    }

    return roundDouble(total, 2);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      AppHeader(authInstance),
      LevelModal(
          getLevel(authInstance.userInfo.containsKey("experience")
              ? authInstance.userInfo["experience"]
              : 0),
          getExperiencePercent(authInstance.userInfo.containsKey("experience")
              ? authInstance.userInfo["experience"]
              : 0),
          getRaminingExperience(authInstance.userInfo.containsKey("experience")
              ? authInstance.userInfo["experience"]
              : 0)),
      ViewLeaderboard(),
      DonatedModal(user_receipts == null ? 0 : receiptTotal(), "\$"),
      user_receipts == null ? Container() : DonatedList(user_receipts)
    ]));
  }
}

class AppHeader extends StatelessWidget {
  AppAuth authInstance;

  AppHeader(this.authInstance);

  String getFullName() {
    if (authInstance.userInfo == null) return "<undefined>";
    return "${authInstance.userInfo["firstName"]} ${authInstance.userInfo["lastName"]}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: <Widget>[
            Flexible(
                flex: 1,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(3)),
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10))),
            Flexible(
                flex: 2,
                child: Text(getFullName(), style: FontPresets.buttonText)),
            Flexible(
                flex: 3,
                child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(children: [
                      Icon(Icomoon.hexagon2, size: 20, color: Colors.blue[200]),
                      Icon(Icomoon.hexagon2,
                          size: 20, color: Colors.brown[300]),
                      Icon(Icomoon.hexagon2, size: 20, color: Colors.amber[200])
                    ])))
          ],
        ),
        margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
        height: 50,
        alignment: Alignment.centerLeft);
  }
}

class DonatedList extends StatelessWidget {
  List<dynamic> receipts = null;
  DonatedList(this.receipts) {
    print("DonatedList loaded");
    print("Loaded ${receipts == null ? '<null>' : receipts.length} receipts.");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        height: receipts == null || receipts.length == 0 ? 0 : 120,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: receipts.map((e) {
            return singleDonation(e["amount"], e["date_time"]);
          }).toList(),
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
        padding: EdgeInsets.fromLTRB(20, 18, 20, _amount == 0 ? 0 : 18),
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
          ]..addAll(_amount == 0 ? emptyDonationView() : []),
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

Widget singleDonation(dynamic amount, dynamic date_time) {
  int timestamp = (int.parse(date_time));
  DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);

  String weekday = "";
  switch (dateTime.weekday) {
    case DateTime.monday:
      weekday = "Monday";
      break;
    case DateTime.tuesday:
      weekday = "Tuesday";
      break;
    case DateTime.wednesday:
      weekday = "Wednesday";
      break;
    case DateTime.thursday:
      weekday = "Thursday";
      break;
    case DateTime.friday:
      weekday = "Friday";
      break;
    case DateTime.saturday:
      weekday = "Saturday";
      break;
    case DateTime.sunday:
      weekday = "Sunday";
      break;
  }

  return Container(
    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
    width: 100,
    child: Column(
      children: <Widget>[
        Container(
          child: Text(weekday, style: FontPresets.buttonText),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
        ),
        Text("\$${amount}",
            style: FontPresets.colorTransform(
                FontPresets.title2, ThemePalette.green2)),
        Text("to Black Lives Matter", style: FontPresets.buttonText)
      ],
    ),
    decoration: BoxDecoration(
        color: ThemePalette.black, borderRadius: BorderRadius.circular(3)),
  );
}

List<Widget> emptyDonationView() {
  return [
    Container(
      child: Text("Want to start donating to charities?",
          style: FontPresets.small),
      alignment: Alignment.centerLeft,
    ),
    Container(
      child: ParallelButton("Donate", 150),
      margin: EdgeInsets.fromLTRB(0, 25, 0, 25),
    )
  ];
}

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
  double experiencePercent;
  int experienceReamining;
  LevelModal(this._level, this.experiencePercent, this.experienceReamining) {
    print("Experience Percent: ${this.experiencePercent}");
  }

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
              widthFactor: this.experiencePercent,
              child: Container(color: Colors.black),
            )),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
              '${experienceReamining} more experience until you reach level ${_level + 1}!',
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

double roundDouble(double value, int places) {
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

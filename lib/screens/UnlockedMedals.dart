import 'package:donatio_app/components/Navbar.dart';
import 'package:donatio_app/components/ParallelButton.dart';
import 'package:donatio_app/src/Auth.dart';
import 'package:donatio_app/src/Icomoon.dart';
import 'package:donatio_app/src/ThemePalette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Dashboard.dart';

// class UnlockedMedalsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//           child: Text("Unlocked Medals Screen Placeholder"),
//         ),
//         bottomNavigationBar: BottomNavbar());
//   }
// }

class UnlockedMedalsBody extends StatefulWidget {
  AppAuth authInstance;
  UnlockedMedalsBody(this.authInstance) {
    print("UnlockedMedalsBodyState initialized:");

    if (authInstance.userInfo.containsKey("medals")) {
      print(authInstance.userInfo["medals"].toString());
    } else {
      print("No medals data found in userInfo");
    }
  }

  @override
  _UnlockedMedalsBodyState createState() =>
      _UnlockedMedalsBodyState(authInstance);
}

class _UnlockedMedalsBodyState extends State<UnlockedMedalsBody> {
  AppAuth authInstance;
  List<dynamic> medalsList = null;
  _UnlockedMedalsBodyState(this.authInstance) {
    if (authInstance.userInfo.containsKey("medals")) {
      medalsList = authInstance.userInfo["medals"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppHeader(authInstance),
          MedalsHeader(medalsList),
          MedalList(medalsList)
        ],
      ),
    );
  }
}

class MedalList extends StatefulWidget {
  List<dynamic> medalsList;
  MedalList(this.medalsList);
  _MedalListState createState() => _MedalListState(medalsList);
}

class _MedalListState extends State<MedalList> {
  List<dynamic> medalsList;
  _MedalListState(this.medalsList);
  String _focusIndex = "";

  void _updateState(String newFocusIndex) {
    setState(() {
      _focusIndex = newFocusIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: <Widget>[
        Flexible(
            flex: 3,
            child: Container(
              child: ListView(
                children: medalsList == null
                    ? []
                    : medalsList.map((medal_) {
                        dynamic award_date = medal_['date_awarded'];
                        int timestamp = int.parse(award_date);
                        DateTime time_ = DateTime.fromMicrosecondsSinceEpoch(
                            timestamp * 1000);
                        String formatted_date = getDateString(time_);

                        return GestureDetector(
                          onTap: () {
                            print(medal_);
                            _updateState(medal_['_id']);
                          },
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn,
                              height: _focusIndex == medal_['_id'] ? 120 : 45,
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              margin: EdgeInsets.fromLTRB(
                                  _focusIndex == medal_['_id'] ? 0 : 10,
                                  0,
                                  _focusIndex == medal_['_id'] ? 0 : 10,
                                  10),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                      flex: 1,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(5)),
                                              color:
                                                  _focusIndex == medal_['_id']
                                                      ? ThemePalette.green3
                                                      : Colors.white),
                                          padding:
                                              EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          alignment: Alignment.topCenter,
                                          child: Icon(Icomoon.hexagon2))),
                                  Flexible(
                                      flex: 5,
                                      child: Column(
                                        children: <Widget>[
                                          Flexible(
                                              flex: 1,
                                              child: Container(
                                                  child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                      flex: 2,
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                15, 0, 0, 0),
                                                        child: Text(
                                                            medal_["name"]),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                      )),
                                                  Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                          margin:
                                                              EdgeInsets
                                                                  .fromLTRB(0,
                                                                      0, 20, 0),
                                                          child: Text(
                                                              formatted_date),
                                                          alignment:
                                                              Alignment.center))
                                                ],
                                              ))),
                                          Flexible(
                                              flex: _focusIndex == medal_['_id']
                                                  ? 3
                                                  : 0,
                                              child: Container(
                                                  alignment: Alignment.topLeft,
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 0, 0, 0),
                                                  child: _focusIndex ==
                                                          medal_['_id']
                                                      ? Text(
                                                          "You ${medal_['description']}")
                                                      : null))
                                        ],
                                      ))
                                ],
                              )),
                        );
                      }).toList(),
              ),
              margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
            )),
        Flexible(
            flex: 1,
            child: Container(
                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 10,
                      child: Container(
                        child: SvgPicture.asset(
                          'assets/vault.svg',
                          semanticsLabel: "Vault Graphic",
                        ),
                        width: 150,
                        height: 150,
                      ),
                    ),
                    Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Text("38 locked medals"),
                                    alignment: Alignment.center),
                                Container(
                                    child: ParallelButton(
                                        "View Locked medals", 260))
                              ],
                            )))
                  ],
                )))
      ],
    ));
  }
}

class MedalsHeader extends StatelessWidget {
  List<dynamic> medalsList = null;
  MedalsHeader(this.medalsList);
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Column(
          children: <Widget>[
            Container(
              child: Text("Unlocked Medals", style: FontPresets.title1),
              alignment: Alignment.centerLeft,
            ),
            Container(
              child: Text(
                  "You unlocked ${medalsList == null ? 0 : medalsList.length} medals",
                  style: FontPresets.label),
              alignment: Alignment.centerLeft,
            )
          ],
        ));
  }
}

String getDateString(DateTime time_) {
  String formatted_date = "";
  if (time_ == null) return "invalid";

  // get the month;
  switch (time_.month) {
    case DateTime.january:
      formatted_date += "January";
      break;
    case DateTime.february:
      formatted_date += "February";
      break;
    case DateTime.march:
      formatted_date += "March";
      break;
    case DateTime.april:
      formatted_date += "April";
      break;
    case DateTime.may:
      formatted_date += "May";
      break;
    case DateTime.june:
      formatted_date += "June";
      break;
    case DateTime.july:
      formatted_date += "July";
      break;
    case DateTime.august:
      formatted_date += "August";
      break;
    case DateTime.september:
      formatted_date += "September";
      break;
    case DateTime.october:
      formatted_date += "October";
      break;
    case DateTime.november:
      formatted_date += "November";
      break;
    case DateTime.december:
      formatted_date += "December";
      break;
  }

  formatted_date += " ${time_.day}, ${time_.year}";
  return formatted_date;
}

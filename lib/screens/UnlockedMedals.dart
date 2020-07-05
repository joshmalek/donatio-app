import 'package:donatio_app/components/Navbar.dart';
import 'package:donatio_app/components/ParallelButton.dart';
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

class UnlockedMedalsBody extends StatelessWidget {
  UnlockedMedalsBody() {
    print("UnlockedMedalsBody instantiated.");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [AppHeader(), MedalsHeader(), MedalList()],
      ),
    );
  }
}

class MedalList extends StatefulWidget {
  _MedalListState createState() => _MedalListState();
}

class _MedalListState extends State<MedalList> {
  int _focusIndex = 0;

  List<Map<String, dynamic>> medalsData = [
    {
      'name': 'First Donation',
      'date': 'June 10',
      'description': 'Made your first donation to a charity.',
      'id': 1
    },
    {
      'name': 'First Donation',
      'date': 'June 10',
      'description': 'Made your first donation to a charity.',
      'id': 2
    },
    {
      'name': 'First Donation',
      'date': 'June 10',
      'description': 'Made your first donation to a charity.',
      'id': 3
    },
    {
      'name': 'First Donation',
      'date': 'June 10',
      'description': 'Made your first donation to a charity.',
      'id': 4
    },
    {
      'name': 'First Donation',
      'date': 'June 10',
      'description': 'Made your first donation to a charity.',
      'id': 5
    },
    {
      'name': 'First Donation',
      'date': 'June 10',
      'description': 'Made your first donation to a charity.',
      'id': 6
    },
    {
      'name': 'First Donation',
      'date': 'June 10',
      'description': 'Made your first donation to a charity.',
      'id': 7
    }
  ];

  void _updateState(int newFocusIndex) {
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
                children: medalsData
                    .map((medal_) => GestureDetector(
                          onTap: () {
                            _updateState(medal_['id']);
                          },
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn,
                              height: _focusIndex == medal_['id'] ? 120 : 45,
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              margin: EdgeInsets.fromLTRB(
                                  _focusIndex == medal_['id'] ? 0 : 10,
                                  0,
                                  _focusIndex == medal_['id'] ? 0 : 10,
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
                                              color: _focusIndex == medal_['id']
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
                                                      flex: 3,
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
                                                          child: Text(
                                                              medal_["date"]),
                                                          alignment:
                                                              Alignment.center))
                                                ],
                                              ))),
                                          Flexible(
                                              flex: _focusIndex == medal_['id']
                                                  ? 3
                                                  : 0,
                                              child: Container(
                                                  alignment: Alignment.topLeft,
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 0, 0, 0),
                                                  child: _focusIndex ==
                                                          medal_['id']
                                                      ? Text(
                                                          medal_['description'])
                                                      : null))
                                        ],
                                      ))
                                ],
                              )),
                        ))
                    .toList(),
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
              child: Text("You unlocked 5 medals", style: FontPresets.label),
              alignment: Alignment.centerLeft,
            )
          ],
        ));
  }
}

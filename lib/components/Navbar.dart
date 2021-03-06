import 'package:donatio_app/screens/Dashboard.dart';
import 'package:donatio_app/screens/DonateScreen.dart';
import 'package:donatio_app/screens/Leaderboard.dart';
import 'package:donatio_app/screens/UnlockedMedals.dart';
import 'package:donatio_app/src/Auth.dart';
import 'package:donatio_app/src/Icomoon.dart';
import 'package:donatio_app/src/ThemePalette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavbar extends StatefulWidget {
  AppAuth authInstance;
  BottomNavbar(this.authInstance);

  @override
  _BottomNavbarState createState() => _BottomNavbarState(authInstance);
}

/* Application Authentication Details
 * - Once the application loads, check if there is any auth token present in the application. If so, fetch the user
 * information based on the saved token and user that's logged in.
 * - If the token is NOT authenticated by the backend or if no token exists, or if the token is expired, route to the login screen.
 * 
 * - If the token is authenticated by the backend, then store the data fetched into the global state.
 * - Keep track of what time the data is re-fetched.
 * - When the user routes to any page that requires data that is present in the database, if the last time the data was
 * cached was more than 5 minutes ago, then refetch the data.
 * 
 * - If the user logs in and the credentials are valid, then create an auth token that expires after 7 days.
*/

class _BottomNavbarState extends State<BottomNavbar>
    with SingleTickerProviderStateMixin {
  AppAuth authInstance;
  _BottomNavbarState(this.authInstance);

  double _left = 5;
  int _pageIndex = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double _updateState(int iconIndex) {
    _pageIndex = iconIndex;

    double targetDisp = 0;
    switch (iconIndex) {
      case 0:
        targetDisp = 0;
        break;
      case 1:
        targetDisp = 2 * (MediaQuery.of(context).size.width - 60) / 11;
        break;
      case 2:
        targetDisp = 7 * (MediaQuery.of(context).size.width - 60) / 11;
        break;
      case 3:
        targetDisp = 9 * (MediaQuery.of(context).size.width - 60) / 11;
        break;
    }
    targetDisp += 5;

    setState(() {
      _left = targetDisp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
            height: 40.0,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
              width: 150.0,
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                      child: Container(
                          width: (2 *
                                  ((MediaQuery.of(context).size.width - 60) /
                                      11)) -
                              10,
                          height: 40,
                          color: ThemePalette.black),
                      left: _left),
                  Row(
                    children: <Widget>[
                      Flexible(
                          flex: 2,
                          child: GestureDetector(
                              onTap: () {
                                _tabController.index = 0;
                                _updateState(0);
                                // Navigator.of(context)
                                //     .pushReplacementNamed('/dashboard');
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Icon(Icomoon.dashboard,
                                      size: 17,
                                      color: _pageIndex == 0
                                          ? Colors.white
                                          : ThemePalette.black)))),
                      Flexible(
                          flex: 2,
                          child: GestureDetector(
                              onTap: () {
                                _tabController.index = 1;
                                _updateState(1);
                                // Navigator.of(context)
                                //     .pushReplacementNamed('/unlockedMedals');
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Icon(Icomoon.hexagon2,
                                      size: 22,
                                      color: _pageIndex == 1
                                          ? Colors.white
                                          : ThemePalette.black)))),
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
                          child: GestureDetector(
                              onTap: () {
                                _tabController.index = 2;
                                _updateState(2);
                                // Navigator.of(context)
                                //     .pushReplacementNamed('/leaderboard');
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Icon(Icomoon.trophy,
                                      size: 20,
                                      color: _pageIndex == 2
                                          ? Colors.white
                                          : ThemePalette.black)))),
                      Flexible(
                          flex: 2,
                          child: GestureDetector(
                              onTap: () {
                                _tabController.index = 3;
                                _updateState(3);
                                // Navigator.of(context)
                                //     .pushReplacementNamed('/donate');
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Icon(Icomoon.coin,
                                      size: 18,
                                      color: _pageIndex == 3
                                          ? Colors.white
                                          : ThemePalette.black))))
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
            )),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff93A0C8), Color(0xffF993AC)],
            )),
            child: TabBarView(
              children: <Widget>[
                DashboardBody(authInstance),
                UnlockedMedalsBody(authInstance),
                LeaderboardBody(authInstance),
                DonateBody(authInstance)
              ],
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
            )));
  }
}

import 'package:donatio_app/components/Navbar.dart';
import 'package:donatio_app/screens/Dashboard.dart';
import 'package:donatio_app/src/Icomoon.dart';
import 'package:donatio_app/src/ThemePalette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/API.dart';
import '../models/User.dart';
import 'dart:convert';

// class LeaderboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//           child: Text("Leaderboard Screen Placeholder"),
//         ),
//         bottomNavigationBar: BottomNavbar());
//   }
// }

class LeaderboardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[AppHeader(), LeaderboardHeader(), LeaderboardList()],
      ),
    );
  }
}

class LeaderboardList extends StatefulWidget {
  @override
  createState() => LeaderboardListState();
}

class LeaderboardListState extends State {
  var users = new List<User>();
  var name = "Felix Kjelberg";

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        //print(response.body);
        //print(json.decode(response.body)["data"]["users"][0]["medals"]);
        Iterable list = json.decode(response.body)["data"]["users"];
        users = list.map((model) => User.fromJson(model)).toList();
        users.sort((a, b) => b.xp.compareTo(a.xp));
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  // this was causing issues
  // dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return LeaderboardEntryPill(
                  name: users[index].name,
                  rank: index + 1,
                  points: users[index].xp,
                  isUser: users[index].name == name ? true : false,
                );
              },
            )));
  }
}

class LeaderboardEntryPill extends StatelessWidget {
  int _rank;
  String _name;
  int _points;
  bool _isUser;

  LeaderboardEntryPill(
      {int rank, String name, int points, bool isUser = false}) {
    this._rank = rank;
    this._name = name;
    this._points = points;
    this._isUser = isUser;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(_isUser ? 0 : 10, 0, _isUser ? 0 : 10, 10),
        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
        height: 35,
        decoration: BoxDecoration(boxShadow: [
          new BoxShadow(
              color: ThemePalette.alphaColor(
                  ThemePalette.shadow, this._isUser ? 0.1 : 0.05),
              offset: new Offset(0.0, 1.0),
              spreadRadius: 2,
              blurRadius: 5)
        ], color: Colors.white, borderRadius: BorderRadius.circular(3)),
        child: Row(
          children: <Widget>[
            Flexible(
                flex: 1,
                child: Container(
                  child: Text(_rank.toString()),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: this._isUser ? ThemePalette.red : Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          bottomLeft: Radius.circular(3))),
                )),
            Flexible(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.fromLTRB(this._isUser ? 20 : 0, 0, 0, 0),
                  child: Text(_name,
                      style: FontPresets.weightTransform(
                          FontPresets.label, FontWeight.w600)),
                  alignment: Alignment.centerLeft,
                )),
            Flexible(
                flex: 2,
                child: Container(
                  child: Text("${this._points}"),
                  alignment: Alignment.centerRight,
                ))
          ],
        ));
  }
}

class LeaderboardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Row(
          children: <Widget>[
            Flexible(
                flex: 3,
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Leaderboard", style: FontPresets.title1))),
            Flexible(
                flex: 1,
                child: Container(
                  child: Icon(Icons.filter_list, size: 20),
                  alignment: Alignment.centerRight,
                ))
          ],
        ));
  }
}

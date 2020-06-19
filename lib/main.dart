import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import './screens/Dashboard.dart';

const baseUrl =
    'http://10.0.2.2:4000/graphql?query={users{firstName,lastName,email,_id,experience,medals{name,description,img_url}}}';

class API {
  static Future getUsers() {
    //var url = baseUrl + "{users{id,firstName,lastName,email}}";
    return http.get(baseUrl);
  }
}

class Medal {
  String name;
  String description;
  String imgUrl;

  Medal(String name, String description, String imgUrl) {
    this.name = name;
    this.description = description;
    this.imgUrl = imgUrl;
  }

  Medal.fromJson(Map json)
      : name = json['name'],
        description = json['description'],
        imgUrl = json['img_url'];
}

class User {
  String id;
  String name;
  String email;
  int xp;
  List<dynamic> medals;

  User(String id, String name, String email, int xp) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.xp = xp;
  }

  User.fromJson(Map json)
      : id = json['_id'],
        name = json['firstName'] + " " + json['lastName'],
        email = json['email'],
        xp = json['experience'].toInt(),
        medals = json['medals'].map((model) => Medal.fromJson(model)).toList();

  Map toJson() {
    return {'id': id, 'name': name, 'email': email, 'xp': xp};
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Http App',
        theme: ThemeData(
            scaffoldBackgroundColor: Color(0xff1A191A),
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                )),
        home: ScreenWrapper(DashboardScreen()));
  }
}

class ScreenWrapper extends StatelessWidget {
  Widget _screen_widget;
  ScreenWrapper(this._screen_widget);

  @override
  build(BuildContext context) {
    return Container(
        child: _screen_widget,
        color: Color(0xff1A191A),
        padding: EdgeInsets.all(20.0));
  }
}

class Leaderboard extends StatefulWidget {
  @override
  createState() => _LeaderboardState();
}

class _LeaderboardState extends State {
  var users = new List<User>();

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

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    String dropdownValue = 'All Time';
    return Scaffold(
        body: Column(children: <Widget>[
      SizedBox(height: 30),
      Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Container(
            height: 25,
            width: 25,
            child: SvgPicture.asset('assets/menu.svg', color: Colors.white),
          ),
          SizedBox(
            width: 20,
          ),
          Text("Leaderboard", style: GoogleFonts.workSans(fontSize: 20))
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Container(
          width: 375,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
                color: Colors.white, style: BorderStyle.solid, width: 2),
          ),
          child: Center(
              child: DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue,
            underline: SizedBox(),
            dropdownColor: Color(0xff1A191A),
            icon: Icon(Icons.keyboard_arrow_down),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>['All Time', 'Two', 'Free', 'Four']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ))),
      Container(
          height: 600,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 14),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(15),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Card(
                  color: index == 0
                      ? Colors.blue
                      : index == 1
                          ? Colors.amber
                          : index == 2
                              ? Colors.blueGrey
                              : index == 3 ? Colors.brown : Colors.deepPurple,
                  shadowColor: Colors.red,
                  child: ListTile(
                      dense: true,
                      leading: Text((index + 1).toString(),
                          style: GoogleFonts.workSans(fontSize: 20)),
                      title: Text(users[index].name,
                          style: GoogleFonts.workSans(fontSize: 18)),
                      trailing: Text(users[index].xp.toString(),
                          style: GoogleFonts.workSans(fontSize: 20)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserDetails(user: users[index]),
                          ),
                        );
                      }
                      //subtitle: Text("XP: " + users[index].xp.toString()),
                      ));
            },
          )),
      Container(
        height: 75,
        width: 75,
        child: SvgPicture.asset('assets/logo.svg'),
      ),
    ]));
  }
}

class UserDetails extends StatelessWidget {
  final User user;

  UserDetails({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      SizedBox(height: 50),
      Row(children: <Widget>[
        SizedBox(width: 10),
        Icon(Icons.arrow_back_ios, color: Colors.white),
      ]),
      Center(
        child: Text(
          user.name,
          style: GoogleFonts.workSans(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      )
    ]));
  }
}

// ListView.builder(
//     scrollDirection: Axis.vertical,
//     shrinkWrap: true,
//     itemCount: user.medals.length,
//     itemBuilder: (context, index) {
//       return ListTile(
//           title: Text(user.medals[index].name),
//           subtitle: Text(user.medals[index].description));
//     })

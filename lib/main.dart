import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import './screens/Dashboard.dart';
import 'src/ThemePalette.dart';

const baseUrl =
    'http://3.21.56.172:4000/graphql?query={users{firstName,lastName,email,_id,experience,total_donated,medals{name,description,img_url}}}';

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
  double donated;
  List<dynamic> medals;

  User(String id, String name, String email, int xp, double donated) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.xp = xp;
    this.donated = donated;
  }

  User.fromJson(Map json)
      : id = json['_id'],
        name = json['firstName'] + " " + json['lastName'],
        email = json['email'],
        xp = json['experience'].toInt(),
        donated =
            num.parse(json['total_donated'].toStringAsFixed(2)).toDouble(),
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
            scaffoldBackgroundColor: ThemePalette.primary,
            textTheme: TextTheme(
                headline1: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontFamily: "WorkSans",
                    fontWeight: FontWeight.normal),
                bodyText2: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.normal),
                headline3: TextStyle(
                    fontSize: 20,
                    color: ThemePalette.green,
                    fontFamily: "WorkSans",
                    fontWeight: FontWeight.normal))),
        home: DashboardScreen());
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
          height: MediaQuery.of(context).size.height - 205,
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
                              : index == 3 ? Colors.brown : Color(0xFF857AA2),
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
      SizedBox(height: 30),
      Row(children: <Widget>[
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          width: 20,
        ),
        Text("User Details", style: GoogleFonts.workSans(fontSize: 20)),
      ]),
      SizedBox(height: 20),
      Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Color(0xFF857AA2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: MediaQuery.of(context).size.height - 400,
          width: MediaQuery.of(context).size.width - 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(user.name, style: GoogleFonts.workSans(fontSize: 25)),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text("Lv. " + (user.xp ~/ 10).toString(),
                            style: GoogleFonts.workSans(
                                fontSize: 16, color: Colors.black)),
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text("Lifetime Donations",
                  style:
                      GoogleFonts.workSans(fontSize: 18, color: Colors.white)),
              SizedBox(height: 10),
              Text(NumberFormat.simpleCurrency().format(user.donated),
                  style: GoogleFonts.workSans(
                      fontSize: 35, color: Color(0xFF7BEE96))),
              Divider(
                color: Colors.white,
              ),
              Text("Medals",
                  style:
                      GoogleFonts.workSans(fontSize: 18, color: Colors.white)),
              Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: user.medals.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            leading: SizedBox(
                              width: 50,
                              height: 50,
                              child: SvgPicture.asset(
                                  'assets/first_donation.svg'), // no matter how big it is, it won't overflow
                            ),
                            title: Text(user.medals[index].name),
                            subtitle: Text(user.medals[index].description));
                      })),
            ],
          )),
      SizedBox(
        height: 30,
      ),
      Container(
        width: MediaQuery.of(context).size.width - 50,
        height: MediaQuery.of(context).size.width - 200,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Color(0xFF857AA2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      )
    ]));
  }
}

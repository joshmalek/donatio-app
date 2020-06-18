import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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
          scaffoldBackgroundColor: Colors.black,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              )),
      home: Leaderboard(),
    );
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
    return Scaffold(
        body: Column(children: <Widget>[
      SizedBox(height: 30),
      Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Icon(Icons.accessible_forward, color: Colors.white),
          SizedBox(
            width: 20,
          ),
          Text("Leaderboard", style: GoogleFonts.workSans(fontSize: 20))
        ],
      ),
      ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
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
                  leading: Text((index + 1).toString(),
                      style: GoogleFonts.workSans(fontSize: 20)),
                  title: Text(users[index].name, style: GoogleFonts.workSans()),
                  trailing: Text(users[index].xp.toString(),
                      style: GoogleFonts.workSans(fontSize: 20)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetails(user: users[index]),
                      ),
                    );
                  }
                  //subtitle: Text("XP: " + users[index].xp.toString()),
                  ));
        },
      )
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

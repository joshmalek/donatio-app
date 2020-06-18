import 'dart:convert';
import 'package:flutter/material.dart';
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
        primarySwatch: Colors.pink,
      ),
      home: MyListScreen(),
    );
  }
}

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State {
  var users = new List<User>();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        //print(response.body);
        //print(json.decode(response.body)["data"]["users"][0]["medals"]);
        Iterable list = json.decode(response.body)["data"]["users"];
        users = list.map((model) => User.fromJson(model)).toList();
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
        appBar: AppBar(
          title: Text("User List"),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(users[index].name),
                subtitle: Text(users[index].email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetails(user: users[index]),
                    ),
                  );
                }
                //subtitle: Text("XP: " + users[index].xp.toString()),
                );
          },
        ));
  }
}

class UserDetails extends StatelessWidget {
  final User user;

  UserDetails({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          SizedBox(height: 50),
          Row(children: <Widget>[
            SizedBox(width: 10),
            Icon(Icons.arrow_back_ios),
          ]),
          Center(
            child: Text(
              user.name,
              style: TextStyle(fontSize: 20),
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

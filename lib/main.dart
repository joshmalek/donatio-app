import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const baseUrl =
    'http://10.0.2.2:4000/graphql?query={users{firstName,lastName,email,_id,experience}}';

class API {
  static Future getUsers() {
    //var url = baseUrl + "{users{id,firstName,lastName,email}}";
    return http.get(baseUrl);
  }
}

class User {
  String id;
  String name;
  String email;
  int xp;

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
        xp = json['experience'].toInt();

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
        primarySwatch: Colors.blue,
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
        //print(json.decode(response.body)["data"]["users"]);
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
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(users[index].name),
              subtitle: Text("XP: " + users[index].xp.toString()),
            );
          },
        ));
  }
}

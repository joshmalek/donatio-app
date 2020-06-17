import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const baseUrl =
    'http://10.0.2.2:4000/graphql?query={users{firstName,email,_id}}';

class API {
  static Future getUsers() {
    //var url = baseUrl + "{users{id,firstName,lastName,email}}";
    return http.get(baseUrl);
  }
}

class User {
  int id;
  String name;
  String email;

  User(int id, String name, String email) {
    this.id = id;
    this.name = name;
    this.email = email;
  }

  User.fromJson(Map json)
      : id = json['data']['users']['id'],
        name = json['data']['users']['firstName'],
        email = json['data']['users']['email'];

  Map toJson() {
    return {'id': id, 'name': name, 'email': email};
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
        Iterable list = json.decode(response.body);
        print(list);
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
            return ListTile(title: Text(users[index].name));
          },
        ));
  }
}

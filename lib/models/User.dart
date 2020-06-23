import 'Medal.dart';

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

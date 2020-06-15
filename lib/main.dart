import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final wordPair = WordPair.random();
    return MaterialApp(
      title: "Test APP",
      home: Scaffold(
        appBar: AppBar(
          title: Text('SUiCID.io'),
        ),
        body: Center(
          child: Text(wordPair.asPascalCase),
        ),
      ),
    );

  }

}

class RandomWordsState extends State<RandomWords>{
  //add build method
}
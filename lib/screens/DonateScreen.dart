import 'package:donatio_app/components/Navbar.dart';
import 'package:donatio_app/components/ParallelButton.dart';
import 'package:donatio_app/screens/Dashboard.dart';
import 'package:donatio_app/src/Icomoon.dart';
import 'package:donatio_app/src/ThemePalette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class DonateScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//           child: Text("Donate Screen Placeholder"),
//         ),
//         bottomNavigationBar: BottomNavbar());
//   }
// }

class DonateBody extends StatelessWidget {
  @override
  Widget build(BuildContext conext) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        AppHeader(),
        DonateHeader(),
        DonateParagraph(
            index: 1,
            title: "Donate the Extension",
            paragraph:
                "Go to your Google Chrome Webstore and search for DonatIO Extension.\nInstall the extension onto your Google Chrome browser."),
        DonateParagraph(
            index: 2,
            title: "Go Online Shopping",
            paragraph:
                "As you shop for items online, you will be provided the option to donate a % of your subtotal to charity using the DonatIO extension."),
        DonateParagraph(
            index: 3,
            title: "Gamify your Donation",
            paragraph:
                "Level up and gain medals for donating to charities! Rank up the leaderboard and flex your stats!"),
        Container(
            child: ParallelButton("Understood", 300),
            margin: EdgeInsets.fromLTRB(0, 100, 0, 0))
      ],
    ));
  }
}

class DonateHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.centerLeft,
            child: Text("Donate", style: FontPresets.title1),
            margin: EdgeInsets.fromLTRB(50, 10, 50, 0)),
        Container(
            margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
            alignment: Alignment.centerLeft,
            child: Text("Want to donate to charity?"))
      ],
    ));
  }
}

class DonateParagraph extends StatelessWidget {
  int _index;
  String _title;
  String _paragraph;

  DonateParagraph({int index, String title, String paragraph}) {
    this._index = index;
    this._title = title;
    this._paragraph = paragraph;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(50, 20, 50, 0),
        child: Row(
          children: <Widget>[
            Flexible(
                flex: 1,
                child: Container(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: <Widget>[
                        Icon(Icomoon.hexagon, color: Colors.white, size: 70),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 5, 0),
                          alignment: Alignment.center,
                          child: Text(_index.toString(),
                              style: FontPresets.medium),
                        )
                      ],
                    ))),
            Flexible(
                flex: 3,
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(_title, style: FontPresets.title2),
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      alignment: Alignment.centerLeft,
                    ),
                    Text(_paragraph)
                  ],
                )))
          ],
        ));
  }
}

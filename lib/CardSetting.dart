import 'package:flutter/material.dart';

class CardSetting extends StatelessWidget {
  final Widget icon;
  final Widget title;

  CardSetting({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: new Card(
        color: Colors.grey[800],
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Row(
            children: <Widget>[this.icon, this.title],
          ),
        ),
      ),
    );
  }
}

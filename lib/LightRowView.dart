import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LightRowView extends StatelessWidget {

  String title;
  bool isOn;

  LightRowView(String title, bool isOn) {
    this.title = title;
    this.isOn = isOn;
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: new EdgeInsets.all(8.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(title),
            new CupertinoSwitch(value: isOn, onChanged: null)
          ],
        )
    );
  }
}

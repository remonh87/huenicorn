import 'package:flutter/material.dart';

import 'LightSwitch.dart';
// remove once we hook-up the tile to the color picker screen
import 'HuenicornSettings.dart';

class LightTile extends StatelessWidget{

  String _title;
  bool _isOn;

  LightTile(String title, bool isOn) {
    _title = title;
    _isOn = isOn;
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      enabled: true,
      leading: new Icon(Icons.lightbulb_outline, color: Colors.black, size: 30.0),
      title: new Text(_title, textScaleFactor: 1.5),
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new HuenicornSettings()),
        );
      },
      trailing: new LightSwitch(_isOn),
    );
  }
}
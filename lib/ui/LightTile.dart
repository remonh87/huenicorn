import 'package:flutter/material.dart';
import 'package:huenicorn/LightColorPicker.dart';

import 'LightSwitch.dart';
// remove once we hook-up the tile to the color picker screen

class LightTile extends StatelessWidget {

  final String _title;
  final bool _isOn;

  LightTile(this._title, this._isOn);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      enabled: true,
      leading:
      new ImageIcon(new AssetImage("assets/bulbs_black.png"), color: Colors.white, size: 30.0),

      title: new Text(_title,
          textScaleFactor: 1.2,
        style: new TextStyle( color: Colors.white),
      ),
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new LightColorPicker(1)),
        );
      },
      trailing: new LightSwitch(_isOn),
    );
  }
}

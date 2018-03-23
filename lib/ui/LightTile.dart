import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huenicorn/BridgeState.dart';
import 'package:huenicorn/LightColorPicker.dart';
import 'package:huenicorn/hue/light.dart';

class LightTile extends StatelessWidget {

  final BridgeState _bridgeState;
  final Light _light;

  LightTile(this._bridgeState, this._light);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      enabled: true,
      leading: new Icon(
        Icons.lightbulb_outline, color: Colors.black, size: 30.0
      ),
      title: new Text(_light.name, textScaleFactor: 1.5),
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new LightColorPicker(1)
          ),
        );
      },
      trailing: new CupertinoSwitch(
        value: _light.isOn,
        onChanged: (bool newValue) {
          _light.isOn = newValue;
          _bridgeState.setLight(_light);
        },
      )
    );
  }
}

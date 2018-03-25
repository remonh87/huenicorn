import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huenicorn/BridgeState.dart';
import 'package:huenicorn/LightColorPicker.dart';
import 'package:huenicorn/hue/light.dart';

class LightTile extends StatelessWidget {

  final BridgeState _bridgeState;
  final Light _light;
  final Color _color;

  LightTile(this._bridgeState, this._light, this._color);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        enabled: true,
        leading:
        new CircleAvatar(
            backgroundColor: _color,
            child: new ImageIcon(
                new AssetImage("assets/bulbs_black.png"), color: Colors.white,
                size: 30.0),
        ),
        title: new Text(_light.name,
          textScaleFactor: 1.2,
          style: new TextStyle(color: _color),
        ),

        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new LightColorPicker(_light, _bridgeState)
            ),
          );
        },
        trailing: new Switch(
          value: _light.isOn,
          activeColor: _color,
          onChanged: (bool newValue) {
            _light.isOn = newValue;
            _bridgeState.setLight(_light);
          },
        ),

    );
  }
}

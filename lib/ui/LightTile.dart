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
    final hsvColor = new HSVColor.fromAHSV(1.0, _light.hue, _light.saturation, 1.0);
    return new ListTile(
        enabled: true,
        leading:
        new CircleAvatar(
            backgroundColor: Colors.grey[850],
            child: new ImageIcon(
                new AssetImage("assets/bulbs_black.png"), color: hsvColor.toColor(),
                size: 30.0),
        ),
        title: new Text(_light.name,
          textScaleFactor: 1.2,
          style: new TextStyle(color: hsvColor.toColor()),
        ),

        onTap: () {
          showDialog(context: context, child: new LightColorPicker(_light, _bridgeState));
        },
        trailing: new Switch(
          value: _light.isOn,
          activeColor: hsvColor.toColor(),
          onChanged: (bool newValue) {
            _light.isOn = newValue;
            _bridgeState.setLight(_light);
          },
        ),

    );
  }
}

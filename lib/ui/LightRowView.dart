import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huenicorn/BridgeState.dart';
import 'package:huenicorn/hue/light.dart';

import 'LightTile.dart';
import 'BrightnessSlider.dart';

class LightRowView extends StatelessWidget {

  final BridgeState _bridgeState;
  final Light _light;

  LightRowView(this._bridgeState, this._light);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15.0, top: 1.0, bottom: 1.0),

      child: new Card(
        color: Colors.grey[800],
        child: new Column(
          children: <Widget>[
            new LightTile(_bridgeState, _light),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new BrightnessSlider(_bridgeState, _light)
                ),
              ],
            )
          ]
        )
      ),
    );
  }
}

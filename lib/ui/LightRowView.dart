import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huenicorn/hue/light.dart';

import 'LightTile.dart';
import 'BrightnessSlider.dart';

class LightRowView extends StatelessWidget {

  final Light _light;

  LightRowView(this._light);

  @override
  Widget build(BuildContext context) {
    final hsvColor = new HSVColor.fromAHSV(1.0, _light.hue, _light.saturation, 1.0);
    return new Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15.0, top: 1.0, bottom: 1.0),
      child: new Card(
          elevation: 20.0,
          color: hsvColor.toColor(),
          child: new Column(
              children: <Widget>[
                new LightTile(_light.name, _light.isOn),
                new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new BrightnessSlider(_light.brightness)
                    ),
                  ],
                )
              ]
          )
      ),
    );
  }
}

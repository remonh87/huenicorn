import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LightTile.dart';
import 'BrightnessSlider.dart';

class LightRowView extends StatelessWidget {

  final String _title;
  final bool _isOn;

  LightRowView(this._title, this._isOn);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(
          left: 5.0, right: 5.0, top: 1.0, bottom: 1.0),
      child: new Card(
          elevation: 10.0,
          child: new Column(
              children: <Widget>[
                new LightTile(_title, _isOn),
                new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new BrightnessSlider()
                    ),
                  ],
                )
              ]
          )
      ),
    );
  }
}

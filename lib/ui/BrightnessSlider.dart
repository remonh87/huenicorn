import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huenicorn/BridgeState.dart';
import 'package:huenicorn/hue/light.dart';

class BrightnessSlider extends StatefulWidget {

  final BridgeState _bridgeState;
  final Light _light;

  BrightnessSlider(this._bridgeState, this._light);

  @override
  _BrightnessSliderState createState() => new _BrightnessSliderState(_bridgeState, _light);
}

class _BrightnessSliderState extends State<BrightnessSlider> {

  final BridgeState _bridgeState;
  final Light _light;

  _BrightnessSliderState(this._bridgeState, this._light);

  @override
  Widget build(BuildContext context) {
    return new CupertinoSlider(
      value: _light.brightness,
      min: 0.0,
      max: 1.0,
      activeColor: Colors.grey,
      divisions: 255,
      onChanged: applyLater
    );
  }

  var lastRequest = 0;
  applyLater(double newValue) {
    _light.brightness = newValue;
    var sinceEpoch = new DateTime.now().millisecondsSinceEpoch;
    if(sinceEpoch - lastRequest > 200) {
      lastRequest = sinceEpoch;
      _bridgeState.setLight(_light);
    }
  }
}

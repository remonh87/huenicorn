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
      divisions: 64, // Use 255 to be accurate
      onChanged: (double newValue) {
        setState(() {
          _light.brightness = newValue;
          _bridgeState.setLight(_light);
        });
      }
    );
  }
}

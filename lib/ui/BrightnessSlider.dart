import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrightnessSlider extends StatefulWidget {

  final double _brightness;

  BrightnessSlider(this._brightness);

  @override
  _BrightnessSliderState createState() => new _BrightnessSliderState(_brightness);
}

class _BrightnessSliderState extends State<BrightnessSlider> {

  double _brightness = 1.0;

  _BrightnessSliderState(this._brightness);

  @override
  Widget build(BuildContext context) {
    return new CupertinoSlider(
      value: _brightness,
      min: 0.0,
      max: 100.0,
      activeColor: Colors.grey,
      divisions: 100,
      onChanged: (double newValue) {
        setState(() {
          _brightness = newValue;
        });
      }
    );
  }
}

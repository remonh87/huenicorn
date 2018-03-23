import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrightnessSlider extends StatefulWidget {
  @override
  _BrightnessSliderState createState() => new _BrightnessSliderState();
}

class _BrightnessSliderState extends State<BrightnessSlider> {

  double _brightnessLevel = 100.0;

  @override
  Widget build(BuildContext context) {
    return new CupertinoSlider(
      value: _brightnessLevel,
      min: 0.0,
      max: 100.0,
      activeColor: Colors.grey,
      divisions: 100,
      onChanged: (double newValue) {
        setState(() {
          _brightnessLevel = newValue;
        });
      }
    );
  }
}

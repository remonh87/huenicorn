import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LightSwitch extends StatefulWidget {

  bool _isOn;

  LightSwitch (bool isOn) {
    _isOn = isOn;
  }

  @override
  _LightSwitchState createState() => new _LightSwitchState(_isOn);
}

class _LightSwitchState extends State<LightSwitch> {

  bool _isOn = false;

  _LightSwitchState(bool isOn) {
    _isOn = isOn;
  }

  @override
  Widget build(BuildContext context) {
    return new CupertinoSwitch(
      value: _isOn,
      onChanged: (bool newValue) {
        setState(() {
          _isOn = newValue;
        });
      },
    );
  }
}
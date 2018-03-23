import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LightSwitch extends StatefulWidget {

  final bool _isOn;

  LightSwitch (this._isOn);

  @override
  _LightSwitchState createState() => new _LightSwitchState(_isOn);
}

class _LightSwitchState extends State<LightSwitch> {

  bool _isOn = false;

  _LightSwitchState(this._isOn);

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

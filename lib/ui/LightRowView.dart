import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LightSwitch extends StatefulWidget {
  @override
  _LightSwitchState createState() => new _LightSwitchState();
}

class _LightSwitchState extends State<LightSwitch> {

  bool _isOn = false;

  void _toggleLightSwitch() {
    setState(() {
      if (_isOn) {
        _isOn = false;
      }
      else {
        _isOn = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new CupertinoSwitch(value: _isOn, onChanged: _toggleLightSwitch);
  }
}

class LightRowView extends StatelessWidget {

  String title;
  bool isOn;

  LightRowView(String title, bool isOn) {
    this.title = title;
    this.isOn = isOn;
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(
          left: 5.0, right: 5.0, top: 1.0, bottom: 1.0),
      child: new Card(
          child: new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.lightbulb_outline, color: Colors.black,),
                        new Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: new Text(title),
                        ),
                      ],
                    ),
                    new CupertinoSwitch(value: isOn, onChanged: null)
                  ],
                ),
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[ new CupertinoSlider(onChanged: (double value) {}, value: 0.5, min: 0.0, max:1.0)
                  ],
                )
              ]
          )
      ),
    );
  }
}

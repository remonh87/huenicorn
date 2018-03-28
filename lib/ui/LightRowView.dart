import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huenicorn/BridgeState.dart';
import 'package:huenicorn/hue/light.dart';
import 'package:huenicorn/LightColorPicker.dart';

class LightRowView extends StatefulWidget {
  LightRowView({Key key, this.bridgeState, this.light})
      : super(key: key);

  final BridgeState bridgeState;
  final Light light;

  @override
  _LightRowViewState createState() => new _LightRowViewState();
}

class _LightRowViewState extends State <LightRowView> {
  static HSVColor _hsvColor;

  @override
  Widget build(BuildContext context) {
    _hsvColor = new HSVColor.fromAHSV(1.0, widget.light.hue, widget.light.saturation, 1.0);
    return new Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15.0, top: 1.0, bottom: 1.0),
      child: new Card(
        color: Colors.grey[800],
        child: new Column(
          children: <Widget>[
            new ListTile(
            enabled: true,
              leading: _createLightIcon(),
              title: _createLightTitle(),
              onTap: () {
                showDialog(
                    context: context,
                    child: new LightColorPicker(widget.light, widget.bridgeState));
              },
              trailing: _createLightSwitch(),
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: _createSlider()
                ),
              ],
            )
          ]
        )
      ),
    );
  }

  Widget _createLightIcon() {
    Widget _lightIcon;

    if (widget.light.isOn) {
      _lightIcon = new CircleAvatar(
        backgroundColor: Colors.grey[850],
        child: new ImageIcon(
            new AssetImage("assets/bulbs_black.png"), color: _hsvColor.toColor(),
            size: 30.0),
      );
    }
    else {
      _lightIcon = new CircleAvatar(
        backgroundColor: Colors.grey[850],
        child: new ImageIcon(
            new AssetImage("assets/bulbs_black.png"), color: Colors.grey[500],
            size: 30.0),
      );
    }

    return _lightIcon;
  }

  Widget _createLightTitle() {
    Widget _lightTitle;

    if (widget.light.isOn) {
      _lightTitle = new Text(widget.light.name,
        textScaleFactor: 1.2,
        style: new TextStyle(color: _hsvColor.toColor()),
      );
    }
    else {
      _lightTitle = new Text(widget.light.name,
        textScaleFactor: 1.1,
        style: new TextStyle(color: Colors.grey[500]),
      );
    }

    return _lightTitle;
  }

  Widget _createLightSwitch() {
    return new Switch(
      value: widget.light.isOn,
      activeColor: _hsvColor.toColor(),
      onChanged: (bool newValue) {
        widget.light.isOn = newValue;
        widget.bridgeState.setLight(widget.light);
      },
    );
  }

  Widget _createSlider() {
    Widget _slider;

    if (widget.light.isOn) {
      _slider = new Slider(
          value: widget.light.brightness,
          min: 0.0,
          max: 1.0,
          activeColor: _hsvColor.toColor(),
          onChanged: applyLater
      );
    }
    else {
      _slider = new Slider(
          value: widget.light.brightness,
          min: 0.0,
          max: 1.0,
          inactiveColor: Colors.grey[400],
          onChanged: null
      );
    }

    return _slider;
  }

  var lastRequest = 0;
  applyLater(double newValue) {
    widget.light.brightness = newValue;
    var sinceEpoch = new DateTime.now().millisecondsSinceEpoch;
    if(sinceEpoch - lastRequest > 200) {
      lastRequest = sinceEpoch;
      widget.bridgeState.setLight(widget.light);
    }
  }
}

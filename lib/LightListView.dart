import 'package:flutter/material.dart';
import 'package:huenicorn/LightRowView.dart';
import 'package:huenicorn/hue/light.dart';

class LightListView extends StatefulWidget {
  @override
  _LightListViewState createState() => new _LightListViewState();
}

class _LightListViewState extends State<LightListView> {
  var _lights = [
    new Light('light 1', true),
    new Light('light 2', false),
    new Light('light 3', false)
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: _lights.length,
      itemBuilder: (BuildContext context, int index) {
        final light = _lights[index];
        return new LightRowView(light.name, light.isOn);
      }
    );
  }
}
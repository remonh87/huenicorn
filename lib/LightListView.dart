import 'package:flutter/material.dart';
import 'package:huenicorn/LightRowView.dart';

class LightListView extends StatefulWidget {
  @override
  _LightListViewState createState() => new _LightListViewState();
}

abstract class Light {
  String get name;
  bool get isOn;
}

class LightImpl implements Light {
  String _name;
  bool _isOn = false;

  @override
  bool get isOn => _isOn;

  @override
  String get name => _name;

  LightImpl(this._name) {}
}


class _LightListViewState extends State<LightListView> {
  var lights = [ new LightImpl('light 1'), new LightImpl('light 2'), new LightImpl('light 3') ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: lights.length,
      itemBuilder: (BuildContext context, int index) {
        return new LightRowView(lights[index].name, false);
      }
    );
  }
}
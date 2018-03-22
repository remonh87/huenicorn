import 'package:flutter/material.dart';

class HuenicornSettings extends StatefulWidget {
  HuenicornSettings({Key key}) : super(key: key);

  @override
  HuenicornSettingsState createState() => new HuenicornSettingsState();
}

class HuenicornSettingsState extends State<HuenicornSettings>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: new Text('Settings'),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new TextField(
            controller: new TextEditingController(),
            decoration: new InputDecoration(
              hintText: 'Set IP address of your bridge: xxx.xxx.xxx.xxx',
            ),
          ),
          new RaisedButton(
            onPressed: () {
              // do nothing
            },
            child: new Text('Set'),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class HuenicornSettings extends StatefulWidget {
  HuenicornSettings({Key key}) : super(key: key);

  @override
  HuenicornSettingsState createState() => new HuenicornSettingsState();
}

class HuenicornSettingsState extends State<HuenicornSettings>{

  @override
  Widget build(BuildContext context) {
    final double myTextSize = 30.0;
    final double myIconSize = 40.0;
    final TextStyle myTextStyle =
    new TextStyle(color: Colors.grey, fontSize: myTextSize);
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
        body: new Container(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: new Center(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new CardSetting(
                    title: new Text(
                      "Connect",
                      style: myTextStyle,
                    ),
                    icon: new Icon(Icons.computer,
                        size: myIconSize, color: Colors.red)),

                new CardSetting(
                    title: new Text(
                      "App Theme",
                      style: myTextStyle,
                    ),
                    icon: new Icon(Icons.theaters,
                        size: myIconSize, color: Colors.green)),
              ],
            ),
          ),
        ),
      );
  }
}

class CardSetting extends StatelessWidget {
  final Widget icon;
  final Widget title;
  
  CardSetting({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: new Card(
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Column(
            children: <Widget>[this.title, this.icon],
          ),
        ),
      ),
    );
  }
}
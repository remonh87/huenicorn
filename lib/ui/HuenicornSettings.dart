import 'package:flutter/material.dart';
import 'package:huenicorn/CardSetting.dart';

class HuenicornSettings extends StatefulWidget {
  HuenicornSettings({Key key}) : super(key: key);

  @override
  HuenicornSettingsState createState() => new HuenicornSettingsState();
}

class HuenicornSettingsState extends State<HuenicornSettings> {

  @override
  Widget build(BuildContext context) {
    final double myTextSize = 30.0;
    final double myIconSize = 40.0;
    final TextStyle myTextStyle = new TextStyle(
        color: Colors.grey, fontSize: myTextSize);

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.grey[850],
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: new Text('Settings'),
      ),
      body: new Container(
        color: Colors.grey[900],
        padding: const EdgeInsets.only(bottom: 2.0),
        child: new Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new CardSetting(
                  icon: new Icon(Icons.signal_wifi_4_bar,
                      size: myIconSize, color: Colors.blue),
                  title: new Text(
                    "Connect",
                    style: myTextStyle,
                  )),

              new CardSetting(
                icon: new Icon(Icons.theaters,
                    size: myIconSize, color: Colors.green),
                  title: new Text(
                    "App Theme",
                    style: myTextStyle,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

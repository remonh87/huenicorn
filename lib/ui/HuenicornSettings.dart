import 'package:flutter/material.dart';
import 'package:huenicorn/CardSetting.dart';
import 'package:huenicorn/ui/IpAddress.dart';

class HuenicornSettings extends StatefulWidget {
  HuenicornSettings({Key key}) : super(key: key);

  @override
  HuenicornSettingsState createState() => new HuenicornSettingsState();
}

class HuenicornSettingsState extends State<HuenicornSettings> {

  @override
  Widget build(BuildContext context) {
    final double myIconSize = 30.0;
    final TextStyle myTextStyle = new TextStyle(
        color: Colors.white);

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
        padding: const EdgeInsets.only(top: 2.0, left: 10.0, right: 10.0),
        child: new Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new IpAddress()),
                  );
                }, child: new CardSetting(
                  icon: new ImageIcon(
                      new AssetImage("assets/devices_bridges.png"),
                      size: myIconSize, color: Colors.white),
                  title: new Text(
                    "Connect",
                    textScaleFactor: 1.2,
                    style: myTextStyle,
                  )),
              ),


              new CardSetting(
                  icon: new ImageIcon(
                      new AssetImage("assets/uicontrols_scenes.png"),
                      size: myIconSize, color: Colors.white),
                  title: new Text(
                    "App Theme",
                    textScaleFactor: 1.2,
                    style: myTextStyle,
                  )),
            ],
          ),
        )
        ,
      )
      ,
    );
  }
}

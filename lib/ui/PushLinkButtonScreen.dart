import 'package:flutter/material.dart';
import 'package:huenicorn/network/bridge_connect_activity.dart';
import 'package:huenicorn/ui/HuenicornAppBar.dart';

class PushLinkButtonScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new PushLinkButtonScreenState();
}

class PushLinkButtonScreenState extends State<PushLinkButtonScreen> {

  @override
  Widget build(BuildContext context) {
    new BridgeConnectActivity(() {
      Navigator.of(context).pushReplacementNamed('/HuenicornHome');
    });

    return new Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: createHuenicornAppBar('Connecting to Bridge', []),
      body: new Stack(fit: StackFit.expand, children: <Widget>[
        new Theme(
          data: new ThemeData(
              brightness: Brightness.dark,
              inputDecorationTheme: new InputDecorationTheme(
                hintStyle: new TextStyle(color: Colors.white, fontSize: 20.0),
                labelStyle:
                new TextStyle(color: Colors.grey[600], fontSize: 25.0),
              )),
          isMaterialAppTheme: true,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _textPressingBridgeButton(context),
              new Padding(
                padding: const EdgeInsets.only(top: 80.0),
              ),
              _bridgeImage(context),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _bridgeImage(BuildContext context) {
    return new Image(
      image: new AssetImage("assets/bridge_and_router.webp"),
      height: 200.0,
      fit: BoxFit.contain,
    );
  }

  Widget _textPressingBridgeButton(BuildContext context) {
    return
      new Padding(padding: const EdgeInsets.only(left:20.0, right: 5.0),
          child: new Text('Press pushlink button on the bridge',
              textAlign: TextAlign.left,
              softWrap: true,
              overflow: TextOverflow.fade,
              style: new TextStyle(
                  fontSize: 20.4,
                  color: Colors.white,
                  decoration: TextDecoration.none))
      );
  }

}

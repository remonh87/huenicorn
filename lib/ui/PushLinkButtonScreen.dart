import 'package:flutter/material.dart';
import 'package:huenicorn/Settings.dart';

class PushLinkButtonScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new PushLinkButtonScreenState();
}

class PushLinkButtonScreenState extends State<PushLinkButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: _appBar(context),
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Theme(
            data: new ThemeData(
              brightness: Brightness.dark,
              inputDecorationTheme: new InputDecorationTheme(
                hintStyle: new TextStyle(color: Colors.white, fontSize: 20.0),
                labelStyle: new TextStyle(color: Colors.grey[600], fontSize: 25.0),
              )
            ),
            isMaterialAppTheme: true,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _bridgeImage(context),
                new Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                ),
                _textPressingBridgeButton(context)
              ],
            ),
          ),
        ]
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.grey[850],
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back),
        onPressed: () {
          Settings.getInstance().setBridgeAddress("");
          Navigator.pop(context);
        }
      ),
      title: new Text('Connecting to Bridge'),
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
    return new Text(
      'Press button on the bridge',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: DefaultTextStyle.of(context).style.apply(
        fontSizeFactor: 0.5,
        color: Colors.white,
        decoration: TextDecoration.none
      )
    );
  }

}

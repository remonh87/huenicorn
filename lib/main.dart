import 'package:flutter/material.dart';
import 'package:huenicorn/BridgeStateProvider.dart';
import 'package:huenicorn/Settings.dart';
import 'package:huenicorn/ui/IpAddress.dart';
import 'package:huenicorn/ui/LightListView.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Huenicorn App',
      theme: new ThemeData.light(),
      home: getHome(context),
    );
  }

  getHome(BuildContext context) {
    if (Settings.getInstance().getBridgeAddress() == "") {
      return new IpAddress();
    } else {
      return new HuenicornHome();
    }
  }
}

class HuenicornHome extends StatefulWidget {
  HuenicornHome({Key key}) : super(key: key);

  @override
  _HuenicornHomeState createState() => new _HuenicornHomeState();
}

class _HuenicornHomeState extends State<HuenicornHome> {

  final _bridgeStateProvider = new BridgeStateProvider(Settings.getInstance());

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.grey[850],
        leading: new IconButton(
          icon: new ImageIcon(
            new AssetImage("assets/devices_bridges.png"),
              size: 30.0, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new IpAddress()),
            );
          },
        ),
        title: new Text('Home'),
      ),
      body: new Container(
        color: Colors.grey[900],
        child: new LightListView(_bridgeStateProvider.bridgeState)
      )
    );
  }
}


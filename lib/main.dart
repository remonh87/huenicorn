import 'package:flutter/material.dart';
import 'package:huenicorn/BridgeStateProvider.dart';
import 'package:huenicorn/Settings.dart';
import 'package:huenicorn/ui/BridgeLoginScreen.dart';
import 'package:huenicorn/ui/LightListView.dart';
import 'package:huenicorn/ui/loadingScreen.dart';
import 'package:huenicorn/ui/PushLinkButtonScreen.dart';
import 'package:huenicorn/ui/HuenicornAppBar.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Huenicorn App',
      theme: new ThemeData.light(),
      home: new LoadingScreen(),
      routes: <String, WidgetBuilder> {
        '/HuenicornHome': (BuildContext context) => new HuenicornHome(),
        '/BridgeLoginScreen': (BuildContext context) => new BridgeLoginScreen(),
        '/PushLinkButtonScreen': (BuildContext context) => new PushLinkButtonScreen(),
      },);
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
    List <Widget> appBarActions = _createAppBarActionList();

    return new Scaffold(
      appBar: createAppBar('Lights overview', appBarActions),
      body: new Container(
        color: Colors.grey[900],
        child: new LightListView(_bridgeStateProvider.bridgeState)
      ),
    );
  }

  List <Widget> _createAppBarActionList() {
    List <Widget> appBarActions= <Widget> [
      new IconButton( // action button
      icon: new ImageIcon(new AssetImage("assets/devices_bridges.png")),
      onPressed: () {
        Navigator.of(context).pushNamed('/BridgeLoginScreen');
      },
      )
    ];

    return appBarActions;
  }
}

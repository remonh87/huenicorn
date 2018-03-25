import 'dart:async';

import 'package:flutter/material.dart';
import 'package:huenicorn/Settings.dart';
import 'package:huenicorn/main.dart';
import 'package:huenicorn/ui/IpAddress.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _startLoadingSettings(context);
    return new Scaffold(
      backgroundColor: Colors.grey[900],
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
            children: <Widget>[_huenicornLogo(context)],
          ),
        ),
      ]),
    );
  }

  Widget _huenicornLogo(BuildContext context) {
    return new Text('huenicorn',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: DefaultTextStyle.of(context).style.apply(
            fontSizeFactor: 1.0,
            color: Colors.purpleAccent,
            decoration: TextDecoration.none));
  }

  _startLoadingSettings(BuildContext context) async {
    new Timer(const Duration(seconds: 2), () async {
      await Settings.loadSettings();
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => _getHome(context)));
    });
  }

  _getHome(BuildContext context) {
    return Settings.getInstance().isInitialized
        ? new HuenicornHome()
        : new IpAddress();
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:huenicorn/Settings.dart';
import 'package:huenicorn/network/bridge_discovery.dart';
import 'package:huenicorn/ui/PushLinkButtonScreen.dart';

class BridgeLoginScreen extends StatefulWidget {
  @override
  State createState() => new BridgeLoginScreenState();
}

class BridgeLoginScreenState extends State<BridgeLoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    FindBridgesOnNetwork bridgeFinder =
        new FindBridgesOnNetwork((String ipAdddress) {
      _controller.text = ipAdddress;
    });
    bridgeFinder.startSearch();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: _createAppBar(context),
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
              new Container(
                padding: const EdgeInsets.all(30.0),
                child: new Form(
                  autovalidate: true,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _createIpAddressTextFormField(context),
                      new Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                      ),
                      _createOkButton(context)
                    ],
                  ),
                ),
              ),
              _createBridgeImage(context)
            ],
          ),
        ),
      ]),
    );
  }

  AppBar _createAppBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.grey[850],
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back),
        onPressed: () {
          if (Settings.getInstance().isInitialized) {
            Navigator.pop(context);
          } else {
            _showEnterIpDialog();
          }
        },
      ),
      title: new Text('Connect to Bridge'),
    );
  }

  Widget _createIpAddressTextFormField(BuildContext context) {
    return new TextFormField(
      controller: _controller,
      decoration: new InputDecoration(
          labelText: "Please enter ip address", fillColor: Colors.white),
      keyboardType: TextInputType.number,
    );
  }

  Widget _createOkButton(BuildContext context) {
    return new MaterialButton(
      height: 50.0,
      minWidth: 150.0,
      color: Colors.green,
      splashColor: Colors.teal,
      textColor: Colors.white,
      child: new Icon(FontAwesomeIcons.check),
      onPressed: () {
        if (_controller.text.trim().isEmpty) {
          _showEnterIpDialog();
        } else {
          Settings.getInstance().setBridgeAddress(_controller.text);
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new PushLinkButtonScreen()));
        }
      },
    );
  }

  Widget _createBridgeImage(BuildContext context) {
    return new Image(
      image: new AssetImage("assets/bridge_and_router.webp"),
      height: 200.0,
      fit: BoxFit.contain,
    );
  }

  void _showEnterIpDialog() {
    showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text('Please type IP Address'),
        ));
  }
}

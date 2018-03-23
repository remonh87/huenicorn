import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:huenicorn/Settings.dart';
import 'package:huenicorn/main.dart';

class IpAddress extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}


class LoginPageState extends State<IpAddress>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.grey[850],
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            if (Settings.getInstance().getBridgeAddress() == "") {
              showEnterIpDialog();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: new Text('IP Address'),
      ),
      body: new Stack(fit: StackFit.expand, children: <Widget>[

        new Theme(
          data: new ThemeData(
              brightness: Brightness.light,
              inputDecorationTheme: new InputDecorationTheme(
                hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
                labelStyle:
                new TextStyle(color: Colors.black, fontSize: 25.0),
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
                      new TextFormField(
                          controller: _controller,
                          decoration: new InputDecoration(
                              labelText: "Please enter ip address",
                              fillColor: Colors.black),
                          keyboardType: TextInputType.number
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                      ),
                      new MaterialButton(
                        height: 50.0,
                        minWidth: 150.0,
                        color: Colors.green,
                        splashColor: Colors.teal,
                        textColor: Colors.white,
                        child: new Icon(FontAwesomeIcons.signInAlt),
                        onPressed: () {
                          if (_controller.text.trim() == "") {
                            showEnterIpDialog();
                          } else {
                            Settings.getInstance().setBridgeAddress(
                                _controller.text);
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                    new HuenicornHome()
                              )
                            );
                          }
                        },

                      )
                    ],

                  ),
                ),
              ),
              new Image(
                image: new AssetImage("assets/bridge_and_router.webp"),
                height: 200.0,
                fit: BoxFit.contain,
                //colorBlendMode: BlendMode.darken,
                //color: Colors.black87,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void showEnterIpDialog() {
    showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text('Please type IP Address'),
        ));
  }
}

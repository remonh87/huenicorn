import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ipAddress extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}


class LoginPageState extends State<ipAddress>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
                          showDialog(
                            context: context,
                            child: new AlertDialog(
                              title: new Text('What you typed'),
                              content: new Text(_controller.text),
                            ),
                          );
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
}
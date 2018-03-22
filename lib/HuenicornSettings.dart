import 'package:flutter/material.dart';

class HuenicornSettings extends StatefulWidget {
  HuenicornSettings({Key key}) : super(key: key);

  @override
  HuenicornSettingsState createState() => new HuenicornSettingsState();
}

class HuenicornSettingsState extends State<HuenicornSettings>{

  @override
  Widget build(BuildContext context) {
    // Declare some constants
    final double myTextSize = 30.0;
    final double myIconSize = 40.0;
    final TextStyle myTextStyle =
    new TextStyle(color: Colors.grey, fontSize: myTextSize);
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: new Text('Settings'),
      ),
        body: new Container(
          // Sets the padding in the main container
          padding: const EdgeInsets.only(bottom: 2.0),
          child: new Center(
            child: new Column(
              // Makes the cards stretch in horizontal axis
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Setup the card
                new MyCard(
                  // Setup the text
                    title: new Text(
                      "Connect",
                      style: myTextStyle,
                    ),
                    // Setup the icon
                    icon: new Icon(Icons.computer,
                        size: myIconSize, color: Colors.red)),

                new MyCard(
                    title: new Text(
                      "Lights",
                      style: myTextStyle,
                    ),
                    icon: new Icon(Icons.lightbulb_outline,
                        size: myIconSize, color: Colors.amber)),

                new MyCard(
                    title: new Text(
                      "Color",
                      style: myTextStyle,
                    ),
                    icon: new Icon(Icons.color_lens,
                        size: myIconSize, color: Colors.blue)),

                new MyCard(
                    title: new Text(
                      "Apply",
                      style: myTextStyle,
                    ),
                    icon: new Icon(Icons.done,
                        size: myIconSize, color: Colors.green)),
              ],
            ),
          ),
        ),
      );
  }
}

// Create a reusable stateless widget
class MyCard extends StatelessWidget {
  final Widget icon;
  final Widget title;

  // Constructor. {} here denote that they are optional values i.e you can use as: new MyCard()
  MyCard({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: new Card(
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Column(
            children: <Widget>[this.title, this.icon],

          ),
        ),
      ),
    );
  }
}
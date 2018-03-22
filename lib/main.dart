import 'package:flutter/material.dart';
import 'HuenicornSettings.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Huenicorn App',
      theme: new ThemeData.light(),
      home: new HuenicornHome(),
    );
  }
}

class HuenicornHome extends StatefulWidget {
  HuenicornHome({Key key}) : super(key: key);

  final String title;

  @override
  _HuenicornHomeState createState() => new _HuenicornHomeState();
}

class _HuenicornHomeState extends State<HuenicornHome> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new HuenicornSettings()),
            );
          },
        ),
        title: new Text('Home'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}


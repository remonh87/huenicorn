import 'package:flutter/material.dart';
import 'package:material_pickers/material_pickers.dart';

class LightColorPicker extends StatefulWidget {

  final int lightId;

  const LightColorPicker(this.lightId);

  @override
  State<StatefulWidget> createState() {
    return new LightPickerState();
  }
}

class LightPickerState extends State<LightColorPicker> {
  Color colorCode = new Color(121221);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("Color Picker"),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('$colorCode',
              style: Theme
                  .of(context)
                  .textTheme
                  .display1,),
            new ColorPicker(
              type: MaterialType.transparency,
              onColor: (color) {
                setState(() {
                  colorCode = color;
                  //call akash function

                });
              },
              currentColor: colorCode,
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}

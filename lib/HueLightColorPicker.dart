import 'package:flutter/material.dart';
import 'package:huenicorn/ui/HuenicornAppBar.dart';

class HueLightColorPicker extends StatefulWidget {

  final int lightId;

  const HueLightColorPicker(this.lightId);

  @override
  State<StatefulWidget> createState() {
    return new LightPickerState();
  }
}

class LightPickerState extends State<HueLightColorPicker> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new HuenicornAppBar('Color Picker'),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new GestureDetector(
          onTapDown: (TapDownDetails d) {
            print(d);
          },

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
//          mainAxisAlignment: MainAxisAlignment.center,
          child:
          new Image(
            image: new AssetImage("assets/color.png"),
          ),

        ),
      )
      ,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
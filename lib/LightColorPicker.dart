import 'package:color/color.dart' as NColor;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:huenicorn/BridgeState.dart';
import 'package:huenicorn/hue/light.dart';


class LightColorPicker extends StatefulWidget {

  final Light light;
  final BridgeState bridgeClient;

  const LightColorPicker(this.light, this.bridgeClient);

  @override
  State<StatefulWidget> createState() {
    return new LightPickerState(this.light, this.bridgeClient);
  }
}

class LightPickerState extends State<LightColorPicker> {


  final Light light;
  final BridgeState bridgeClient;

  LightPickerState(this.light, this.bridgeClient);


  @override
  Widget build(BuildContext context) {
    Color pickerColor = new Color(0xff443a49);
    Color currentColor = new Color(0xff443a49);
    ValueChanged<Color> onColorChanged;
    return new AlertDialog(
      title: const Text('Pick a color!'),
      content: new SingleChildScrollView(
        child: new ColorPicker(
          pickerColor: pickerColor,
          onColorChanged: changeColor,
          enableLabel: true,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Got it'),
          onPressed: () {
           updateLight();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  // bind some values with [ValueChanged<Color>] callback
  changeColor(Color color) {
    NColor.HslColor ncolor = new NColor.Color.rgb(
        color.red, color.green, color.blue)
        .toHslColor();
    light.hue = ncolor.h;
    light.brightness = 0.99;
  }

  updateLight(){
    bridgeClient.setLight(light);
  }

}

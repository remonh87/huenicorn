import 'dart:convert';

import 'package:huenicorn/hue/light.dart';

class LightSerializer {
  List<Light> createLights(String response) {
    var json = JSON.decode(response);
    return json.keys.map((id) {
      var light = new Light(json[id]['name']);
      light.isOn = json[id]['state']['on'];
      light.brightness = json[id]['state']['bri'];
      return light;
    }).toList();
  }
}

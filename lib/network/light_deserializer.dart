import 'dart:convert';

import 'package:huenicorn/hue/light.dart';

class LightDeserializer {
  List<Light> createLights(String response) {
    var json = JSON.decode(response);
    return json.keys.map((id) {
      var hue = json[id]['state']['hue'] ?? 0;
      var saturation = json[id]['state']['sat'] ?? 0;
      var brightness = json[id]['state']['bri'] ?? 255;
      return new Light(
        id,
        json[id]['name'],
        json[id]['state']['on'],
        hue / 65535.0 * 360.0,
        saturation / 255.0,
        brightness / 255.0
      );
    }).toList();
  }
}

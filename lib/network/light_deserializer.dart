import 'dart:convert';

import 'package:huenicorn/hue/light.dart';

class LightDeserializer {
  List<Light> createLights(String response) {
    var json = JSON.decode(response);
    return json.keys.map((id) {
      return new Light(
        id,
        json[id]['name'],
        json[id]['state']['on'],
        json[id]['state']['bri'] / 255.0,
        json[id]['state']['hue'] / 65535
      );
    }).toList();
  }
}

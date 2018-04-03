import 'dart:convert';

import 'package:huenicorn/hue/light.dart';

class LightDeserializer {
  List createLights(String response) {
    var _json = json.decode(response);
    return _json.keys.map((id) {
      var hue = _json[id]['state']['hue'] ?? 0;
      var saturation = _json[id]['state']['sat'] ?? 0;
      var brightness = _json[id]['state']['bri'] ?? 255;
      return new Light(
        id,
        _json[id]['name'],
        _json[id]['state']['on'],
        hue / 65535.0 * 360.0,
        saturation / 255.0,
        brightness / 255.0
      );
    }).toList();
  }
}

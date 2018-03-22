import 'dart:convert';

import 'package:huenicorn/light.dart';

class LightSerializer {
  List<Light> createLights(String response) {
    var json = JSON.decode(response);
    return json.keys.map((id) => new Light(json[id]['name'])).toList();
  }
}

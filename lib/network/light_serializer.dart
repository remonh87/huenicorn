import 'dart:convert';

import 'package:huenicorn/network/light.dart';

class LightSerializer {
  List<Light> createLights(String response) {
    var json = JSON.decode(response);
    return json.keys.map((id) => new Light(json[id]['name'], json[id]['state']['on'])).toList();
  }
}

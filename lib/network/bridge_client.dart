import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:huenicorn/hue/light.dart';


class BridgeClient {
  String bridgeAddress;
  String token;

  BridgeClient(this.bridgeAddress, [this.token = '0']);

  Future<String> retrieveLights() async {
    var url = 'http://' + bridgeAddress + '/api/' + token + '/lights';
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    return await response.transform(utf8.decoder).join();
  }

  setLight(Light light) async {
    var url = 'http://' +
        bridgeAddress +
        '/api/' +
        token +
        '/lights/' +
        light.id +
        '/state';
    var body = {
      'on': light.isOn,
      'hue': (light.hue / 360 * 65535).round(),
      'sat': (light.saturation * 255).round(),
      'bri': (light.brightness * 255).round(),
    };
    await http.put(url, body: json.encode(body));
  }
}

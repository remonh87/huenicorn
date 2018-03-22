import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:huenicorn/network/light.dart';
import 'package:huenicorn/network/light_serializer.dart';

class Bridge {
  String bridgeAddress;
  String token;

  Bridge(this.bridgeAddress, [this.token = '0']);

  Future<List<Light>> getLights() async {
    var url = 'http://' + bridgeAddress + '/api/' + token + '/lights';
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var json = await response.transform(UTF8.decoder).join();
    return (new LightSerializer()).createLights(json);
  }
}

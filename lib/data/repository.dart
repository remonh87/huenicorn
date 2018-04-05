import 'dart:async';
import 'package:huenicorn/Settings.dart';
import 'package:huenicorn/network/light_deserializer.dart';
import 'package:huenicorn/network/bridge_client.dart';


class Repository {

  BridgeClient _bridgeClient =  new BridgeClient(Settings.getInstance().bridgeAddress);

  static final Repository _repo = new Repository._internal();

  Repository._internal();

  static Repository get() {
    new BridgeClient(Settings.getInstance().bridgeAddress);
    return _repo;
  }

  Future<List> getLights() async {

    var json = await _bridgeClient.retrieveLights();
    return (new LightDeserializer()).createLights(json);

  }


}

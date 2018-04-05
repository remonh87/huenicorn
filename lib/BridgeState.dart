import 'package:flutter/foundation.dart';
import 'package:huenicorn/hue/light.dart';
import 'package:huenicorn/network/bridge_client.dart';
import 'package:huenicorn/data//repository.dart';

class BridgeState extends Object with ChangeNotifier {
   Repository _repository;

  final BridgeClient _bridgeClient;
  List _lights;

  List get lights => _lights;

  BridgeState(this._bridgeClient){
    _repository = Repository.get();
  }

  update() {
    _repository.getLights()
      .then((lights) {
        _lights = lights;
        notifyListeners();
      });
  }

  setLight(Light light) {
    _bridgeClient.setLight(light)
      .then((_) {
        update();
      });
  }
}

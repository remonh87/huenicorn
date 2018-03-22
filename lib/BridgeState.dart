import 'package:flutter/foundation.dart';
import 'package:huenicorn/hue/light.dart';
import 'package:huenicorn/network/bridge_client.dart';

class BridgeState extends Object with ChangeNotifier {

  final BridgeClient _bridgeClient;
  List<Light> _lights;

  List<Light> get lights => _lights;

  BridgeState(this._bridgeClient);

  update() {
    _bridgeClient.getLights()
      .then((lights) {
        _lights = lights;
        notifyListeners();
      });
  }
}
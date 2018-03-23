import 'package:huenicorn/BridgeState.dart';
import 'package:huenicorn/Settings.dart';
import 'package:huenicorn/network/bridge_client.dart';

class BridgeStateProvider {

  BridgeState _bridgeState;

  BridgeState get bridgeState => _bridgeState;

  BridgeStateProvider(Settings settings) {
    final bridgeClient = new BridgeClient(settings.bridgeAddress, settings.bridgeToken);
    _bridgeState = new BridgeState(bridgeClient);
  }
}
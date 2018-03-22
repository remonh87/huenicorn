import 'package:flutter_test/flutter_test.dart';
import 'package:huenicorn/network/bridge_client.dart';

void main() {
  test('HSE connection is successful', () async {
    var bridge = new BridgeClient('localhost');
    var lights = await bridge.getLights();
    expect(lights.length, 10);
  });
}

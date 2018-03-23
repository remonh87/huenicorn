import 'package:flutter_test/flutter_test.dart';
import 'package:huenicorn/network/bridge_client.dart';

void main() {
  test('Getting lights', () async {
    var bridge = new BridgeClient('localhost');
    var lights = await bridge.getLights();
    expect(lights.length, 10);
  });

  test('Settings lights', () async {
    var bridge = new BridgeClient('localhost');
    var lights = await bridge.getLights();
    lights[0].brightness = 7;
    lights[0].hue = 32;
    await bridge.setLight(lights[0]);

    lights = await bridge.getLights();
    expect(lights[0].brightness, 7);
    expect(lights[0].hue, 32);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:huenicorn/data/repository.dart';
import 'package:huenicorn/network/bridge_client.dart';

void main() {
  test('Getting lights', () async {
    var repository = Repository.get();
    var lights = await repository.getLights();
    expect(lights.length, 10);
  });

  test('Settings lights', () async {
    var bridge = new BridgeClient('localhost');
    var repository = Repository.get();
    var lights = await repository.getLights();
    lights[0].brightness = 7.0;
    lights[0].hue = 32.0;
    await bridge.setLight(lights[0]);
  });
}

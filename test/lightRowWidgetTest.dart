import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:huenicorn/BridgeState.dart';
import 'package:huenicorn/hue/light.dart';
import 'package:huenicorn/network/bridge_client.dart';
import 'package:huenicorn/ui/LightRowView.dart';
import 'package:mockito/mockito.dart';

class MockBridgeClient extends Mock implements BridgeClient {}


class MockBridgeState extends Mock implements BridgeState {
  MockBridgeClient mockBridgeClient;

  MockBridgeState(this.mockBridgeClient);
}

void main() {
  var bridgeClient = new MockBridgeClient();
  var bridgeState = new MockBridgeState(bridgeClient);
  Light light;
  LightRowView lightRowView;


  Widget testLightRow() {
    return new MaterialApp(
      home: lightRowView,
    );
  }

  setUp(() async {
    light = new Light("1", "Test hue1", true, 33665.0, 143.0, 0.2);
    lightRowView = new LightRowView(bridgeState: bridgeState, light: light);
  });


  testWidgets('Hue light switch test', (WidgetTester tester) async {
    await tester.pumpWidget(
      testLightRow(),
    );
    expect(light.isOn, true);
    await tester.tap(find.byKey(lightRowView.lightSwitchKey));
    expect(light.isOn, false);
  });

  testWidgets('Hue brightness slider', (WidgetTester tester) async {
    await tester.pumpWidget(
      testLightRow(),
    );

    final Offset topLeft = tester.getTopLeft(
        find.byKey(lightRowView.brightnessSliderKey));
    final Offset bottomRight = tester.getBottomRight(
        find.byKey(lightRowView.brightnessSliderKey));

    final Offset target = topLeft + (bottomRight - topLeft) / 2.0;
    await tester.tapAt(target);

    expect(light.brightness, equals(0.5));
  });

  testWidgets('Hue brightness cannot be changed when light is turned off', (
      WidgetTester tester) async {
    light.isOn = false;
    await tester.pumpWidget(
      testLightRow(),
    );

    expect(light.isOn, false);

    final Offset topLeft = tester.getTopLeft(
        find.byKey(lightRowView.brightnessSliderKey));
    final Offset bottomRight = tester.getBottomRight(
        find.byKey(lightRowView.brightnessSliderKey));

    final Offset target = topLeft + (bottomRight - topLeft) / 2.0;
    await tester.tapAt(target);

    expect(light.brightness, equals(0.2));
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:huenicorn/network/light_serializer.dart';

String lightOne = '''"1": {
        "state": {
            "on": true,
            "bri": 254,
            "hue": 33665,
            "sat": 143,
            "effect": "none",
            "xy": [
                0.3455,
                0.3558
            ],
            "ct": 198,
            "alert": "none",
            "colormode": "hs",
            "mode": "homeautomation",
            "reachable": true,
            "debug-reachable_counter": 3,
            "debug-scenecapacity": 50
        },
        "swupdate": {
            "state": "noupdates",
            "lastinstall": null
        },
        "type": "Extended color light",
        "name": "Hue color lamp 1",
        "modelid": "LCT001",
        "manufacturername": "Philips",
        "capabilities": {
            "certified": true,
            "streaming": {
                "renderer": true,
                "proxy": true
            }
        },
        "uniqueid": "11:22:33:44:00:07:00:00-0b",
        "swversion": "5.2.0.9",
        "debug-mappedid": 1,
        "debug-upgradestate": "0",
        "debug-philipsupgradestate": "0",
        "debug-currentfileversion": "1",
        "debug-downloadfileversion": "-1"
    }''';

String lightTwo = '''"2": {
        "state": {
            "on": false,
            "bri": 127,
            "hue": 1,
            "sat": 143,
            "effect": "none",
            "xy": [
                0.3455,
                0.3558
            ],
            "ct": 198,
            "alert": "none",
            "colormode": "hs",
            "mode": "homeautomation",
            "reachable": true,
            "debug-reachable_counter": 3,
            "debug-scenecapacity": 50
        },
        "swupdate": {
            "state": "noupdates",
            "lastinstall": null
        },
        "type": "Extended color light",
        "name": "Hue color lamp 2",
        "modelid": "LCT001",
        "manufacturername": "Philips",
        "capabilities": {
            "certified": true,
            "streaming": {
                "renderer": true,
                "proxy": true
            }
        },
        "uniqueid": "11:22:33:44:00:07:00:01-0b",
        "swversion": "5.2.0.9",
        "debug-mappedid": 2,
        "debug-upgradestate": "0",
        "debug-philipsupgradestate": "0",
        "debug-currentfileversion": "1",
        "debug-downloadfileversion": "-1"
    }''';

String singleLightResponse = '{' + lightOne + '}';
String dualLightResponse = '{' + lightOne + ', ' + lightTwo + '}';

void main() {
  test('Empty response produces empty list of lights', () {
    var s = new LightSerializer();
    expect(s.createLights("{}").length, 0);
  });

  test('Single light configuration produces list with single light', () {
    var s = new LightSerializer();
    expect(s.createLights(singleLightResponse).length, 1);
  });

  test('Light name is filled in', () {
    var s = new LightSerializer();
    expect(s.createLights(singleLightResponse)[0].name, 'Hue color lamp 1');
  });

  test('Light name of the second light is filled in', () {
    var s = new LightSerializer();
    expect(s.createLights(dualLightResponse)[1].name, 'Hue color lamp 2');
  });

  test('Lights are switched on and off', () {
    var lights = (new LightSerializer()).createLights(dualLightResponse);
    expect(lights[0].isOn, true);
    expect(lights[1].isOn, false);
  });

  test('Lights have correct brightness', () {
    var lights = (new LightSerializer()).createLights(dualLightResponse);
    expect(lights[0].brightness, 254);
    expect(lights[1].brightness, 127);
  });

  test('Lights have correct color', () {
    var lights = (new LightSerializer()).createLights(dualLightResponse);
    expect(lights[0].hue, 33665);
    expect(lights[1].hue, 1);
  });  
}

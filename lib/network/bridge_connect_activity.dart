import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:huenicorn/Settings.dart';

class BridgeConnectActivity {
  Function _connected;
  Timer _timer;

  BridgeConnectActivity(this._connected) {
    _startTimer();
  }

  void stop() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void _startTimer() {
    _timer = new Timer(const Duration(seconds: 3), _action);
  }

  void _action() {
    var bridgeAddress = Settings.getInstance().bridgeAddress;
    var url = 'http://' + bridgeAddress + '/api/';
    var httpClient = new HttpClient();
    httpClient.postUrl(Uri.parse(url)).then((request) {
      request.write(json.encode({"devicetype": "huenicorn"}));
      request.close().then((response) {
        response.transform(utf8.decoder).join().then((responseData) {
          var r = json.decode(responseData);
          bool connected = r[0].containsKey("success");
          if (connected) {
            Settings.getInstance().setWhiteList(r[0]["success"]["username"]);
            Function.apply(_connected, []);
          } else {
            _startTimer();
          }
        });
      });
    });
  }
}

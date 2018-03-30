import 'package:flutter/material.dart';
import 'package:huenicorn/BridgeState.dart';
import 'package:huenicorn/ui/LightRowView.dart';

class LightListView extends StatefulWidget {

  final BridgeState _bridgeState;

  LightListView(this._bridgeState);

  @override
  _LightListViewState createState() => new _LightListViewState(_bridgeState);
}

class _LightListViewState extends State<LightListView> {

  final BridgeState _bridgeState;

  List _lights = [];

  _LightListViewState(this._bridgeState) {
    _bridgeState.addListener(_applyBridgeState);
    _bridgeState.update(); // This call is here only for testing purposes.
  }

  @override
  void dispose() {
    _bridgeState.removeListener(_applyBridgeState);
    super.dispose();
  }

  _applyBridgeState() {
    setState(() {
      _lights = _bridgeState.lights;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: _lights.length,
        itemBuilder: (BuildContext context, int index) {
          final _light = _lights[index];
          return new Padding(padding: const EdgeInsets.only(
              top: 5.0),
              child: new LightRowView(
                  bridgeState: _bridgeState,
                  light: _light
              )
          );
        }
    );
  }

}

import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static Settings _settings;

  static loadSettings() async {
    var settings = Settings.getInstance();
    var prefs = await SharedPreferences.getInstance();
    settings._bridgeAddress = prefs.getString('bridgeAddress') ?? '';
    settings._whitelist = prefs.getString('whitelist') ?? '';
    print("Loaded ${settings._bridgeAddress} => ${settings._whitelist}");
  }

  static Settings getInstance() {
    if (_settings == null) {
      _settings = new Settings();
    }
    return _settings;
  }

  String _bridgeAddress;
  String _whitelist;

  String get bridgeAddress => _bridgeAddress;
  String get whitelist => _whitelist;
  bool get isInitialized => _bridgeAddress.isNotEmpty && _whitelist.isNotEmpty;

  setWhiteList(String whitelist) {
    this._whitelist = whitelist;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('whitelist', _whitelist);
    });
  }

  setBridgeAddress(String bridgeAddress) {
    this._bridgeAddress = bridgeAddress;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('bridgeAddress', _bridgeAddress);
    });
  }
}

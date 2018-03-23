class Settings {
  static Settings _settings;


  static Settings getInstance() {
    if (_settings == null) {
      print("Creating new Settings Object");
      _settings = new Settings();
    }
    return _settings;
  }

  String whitelist = "";
  String bridgeAddress = "";


  getWhiteList() {
    return whitelist;
  }

  setWhiteList(String whitelist) {
    this.whitelist = whitelist;
  }

  getBridgeAddress() {
    return whitelist;
  }

  setBridgeAddress(String bridgeAddress) {
    this.bridgeAddress = bridgeAddress;
  }

}

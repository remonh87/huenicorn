class Settings {
  static Settings _settings;


  static Settings getInstance() {
    if (_settings == null) {
      print("Creating new Settings Object");
      _settings = new Settings();
    }
    return _settings;
  }

  String whitelist = "GGpMTyBqayQSIhWu4Uq9H0Shng0WMRexBrZd1hvN";
  String bridgeAddress = "192.168.1.132";


  getWhiteList() {
    return whitelist;
  }

  setWhiteList(String whitelist) {
    this.whitelist = whitelist;
  }

  getBridgeAddress() {
    return bridgeAddress;
  }

  setBridgeAddress(String bridgeAddress) {
    this.bridgeAddress = bridgeAddress;
  }

}

class Light {
  String name;
  bool isOn;
  int brightness = 0;
  int hue = 0;

  String id;

  Light(this.name, [this.isOn = false]);
}

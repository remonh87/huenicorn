import 'package:http/http.dart' as http;
import 'package:color/color.dart';

class SetLights {

  setColor(String lightId, int r, int g, int b, String ip, String user)  {

    Color color = new Color.rgb(r, g, b);
    HslColor hslColor = color.toHslColor();
    int newColor = hslColor.h.toInt();


    var url = 'http://'+ip+'/api/'+user+'/lights/'+lightId+'/state';
    http.put(url, body: "{\"hue\":$newColor}")
        .then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    });
  }
}
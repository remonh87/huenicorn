import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:huenicorn/hue/light.dart';
import 'package:huenicorn/network/light_deserializer.dart';

class BridgeClient {
  String bridgeAddress;
  String token;

  BridgeClient(this.bridgeAddress, [this.token = '0']);

  Future<List<Light>> getLights() async {
    var url = 'http://' + bridgeAddress + '/api/' + token + '/lights';
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var json = await response.transform(UTF8.decoder).join();
    return (new LightDeserializer()).createLights(json);
  }

  setLight(Light light) async {
    var url = 'http://' + bridgeAddress + '/api/' + token + '/lights/' + light.id + '/state';
    var body = {
      'on': light.isOn,
      'hue': (light.hue / 360 * 65535).round(),
      'sat': (light.saturation * 255).round(),
      'bri': (light.brightness * 255).round(),
    };
    await http.put(url, body: JSON.encode(body));
  }
}

abstract class BridgeDiscoveryReceiver {
  void bridgeDiscovered (String ipAdddress, String port);
}


class FindBridgeByUpnp {
  // After start expect callbacks
  // After stop there might still be some (delayed) asynchronous callbacks
  final InternetAddress upnpIpAddress = new InternetAddress("239.255.255.250");
  final int upnpPort = 1900;
  RawDatagramSocket upnpSocket;

  List<String> bridgesFoundAtIpAddress = new List<String>();
  BridgeDiscoveryReceiver foundBridge;

  FindBridgeByUpnp (this.foundBridge);

  void _handleUpnpMessage (String upnpReply) {
    // Process UPnP responses, there will be multiple and they keep on coming.
    // Filter on Hue bridges
    // example message, hue bridge v1
    //     CACHE-CONTROL: max-age=100
    //     EXT:
    //     LOCATION: http://192.168.0.18:80/description.xml
    //     SERVER: FreeRTOS/6.0.5, UPnP/1.0, IpBridge/0.1
    //     hue-bridgeid: 001788FFFE10377A
    //     ST: uuid:2f402f80-da50-11e1-9b23-00178810377a
    //     USN: uuid:2f402f80-da50-11e1-9b23-00178810377a
    // example message, hue bridge v2
    //     EXT:
    //     CACHE-CONTROL: max-age=100
    //     LOCATION: http://192.168.0.39:80/description.xml
    //     SERVER: Linux/3.14.0 UPnP/1.0 IpBridge/1.11.0
    //     hue-bridgeid: 001788FFFE20069F
    //     ST: upnp:rootdevice
    //     USN: uuid:2f402f80-da50-11e1-9b23-00178820069f::upnp:rootdevice
    //
    // SERVER line should have a 4th part IpBridge/*
    // LOCATION line provides IP address
    // hue-bridgeid line provides EUI64

    bool foundIpBridge = false; // confirm from SERVER
    String foundIpAddress; // extract from LOCATION
    String foundIpPort; // extract from LOCATION
    // String foundBridgeId; // extract from hue-bridgeid - works, but not yet used
    var upnpLines = new Map<String, String>();

    try {
      upnpReply.split('\n').forEach((String s2) {
        upnpLines[s2.split(':')[0]] = s2;
      });
      // split SERVER by spaces, 4th part should be "IpBridge/..."
      List<String> words = upnpLines["SERVER"].split(' ');
      foundIpBridge = (words.length > 3) && words[3].startsWith("IpBridge");
      // split LOCATION by slashes, 3rd part should be IP address
      List<String> parts = upnpLines["LOCATION"].split('/');
      int index = parts[2].indexOf(':'); // port in :80 is optional
      if ((index == -1) || (index >= parts[2].length)) {
        foundIpPort = "80"; // default CLIP port
        foundIpAddress = parts[2];
      } else {
        foundIpPort = parts[2].substring(index + 1);
        foundIpAddress = parts[2].substring(0, index);
      }
      // split hue-bridgeid by colon, 2nd part should be bridge ID
      // foundBridgeId = upnpLines["hue-bridgeid"].split(':')[1].trim();
    } catch (e) {
      // decode or parse error in bad or unexpected UPnP reply
      // e.g. no LOCATION, other SERVER structure, no hue-bridgeid
      // which might come from an UPnP internet radio or gateway
      return;
    }

    // bridges are announced repeatedly, filter duplicates
    if (foundIpBridge && (foundIpAddress != null)) {
      if (!bridgesFoundAtIpAddress.contains(foundIpAddress)) {
        bridgesFoundAtIpAddress.add (foundIpAddress);
        print ("Discovered bridge at $foundIpAddress : $foundIpPort");
        foundBridge.bridgeDiscovered(foundIpAddress, foundIpPort);
      }
    }
  }

  void _sendMSearchMessage () {
    final String mSearchString =
        "M-SEARCH * HTTP/1.1\r\n" +
            "HOST: 239.255.255.250:1900\r\n" +
            "MAN: \"ssdp:discover\"\r\n" +
            "MX: 3\r\n" +
            "ST: upnp:rootdevice\r\n";
    List<int> mSearchBytes = (new AsciiEncoder()).convert(mSearchString);

    RawDatagramSocket.bind(upnpIpAddress, upnpPort)
        .then((RawDatagramSocket socket) {
        socket.broadcastEnabled = true;
        socket.multicastHops = 1; // set TimeToLive
        socket.multicastLoopback = false; // don't receive my own message
        int count = socket.send(mSearchBytes, upnpIpAddress, upnpPort);
        print ("Searching for bridge $count bytes send");
    });
  }

  void startSearch ()  {
    // Bind UDP socket to UPnP multicast group, after 1 second
    // send UPnP search message and process responses.
    RawDatagramSocket.bind(InternetAddress.ANY_IP_V4, upnpPort)
        .then((RawDatagramSocket socket) {
      upnpSocket = socket;
      // iOS throws an exception on join multi-cast, don't know why
      // but without a join we won't receive any UPnP message :-(
      socket.joinMulticast(upnpIpAddress);
      socket.listen((RawSocketEvent ev){
        if(ev == RawSocketEvent.READ) {
          String reply = (new AsciiDecoder()).convert(socket.receive().data);
          _handleUpnpMessage (reply);
        }
      });
      new Timer(new Duration(seconds: 1), _sendMSearchMessage);
    });
  }

  void stopSearch () { // not tested yet
    // stop only once
    if (upnpSocket != null) {
      // upnpSocket.leaveMulticast(upnpIpAddress);
      upnpSocket.close();
      upnpSocket = null;
    }
  }
}
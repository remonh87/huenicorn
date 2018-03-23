import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
}

class FindBridgeByUpnp {
  // After start expect callbacks
  // After stop the might still be some delayed callbacks
  // Weird: discovery seems slow
  final InternetAddress upnpIpAddress = new InternetAddress("239.255.255.250");
  final int upnpPort = 1900;

  RawDatagramSocket rawSocket;
  StreamSubscription socketListener;

  List<String> bridgesFoundAtIpAddress = new List<String>();
  Function foundBridgeCallBack;

  FindBridgeByUpnp (this.foundBridgeCallBack);

  void _handleRawSocketEvent (RawSocketEvent ev) {
    // if answer contains a SERVER line with IpBridge
    //    SERVER: Linux/3.14.0 UPnP/1.0 IpBridge/1.11.0
    // then we found a Hue bridge.
    // The bridge ip-address can be read from the upnp XML file address
    //    LOCATION: http://192.168.0.39:80/description.xml
    bool foundIpBridge = false;
    String foundIpAddress;
    String foundPort = "80";

    if(ev == RawSocketEvent.READ){
      String upnpReply = (new AsciiDecoder()).convert(rawSocket.receive().data);
      for (var upnpLine in upnpReply.split('\n')) {
        if (upnpLine.startsWith("SERVER:")) {
          List<String> upnpWords = upnpLine.split(' ');
          if ((upnpWords.length > 3) && (upnpWords[3].startsWith("IpBridge"))) {
            foundIpBridge = true;
          }
        } else if (upnpLine.startsWith("LOCATION:")) {
          List<String> upnpParts = upnpLine.split('/');
          if (upnpParts.length > 2) {
            foundIpAddress = upnpParts[2];
            int index = foundIpAddress.indexOf (':'); // :80 is optional
            if (index != -1) {
              if (index < foundIpAddress.length-1) {
                foundPort = foundIpAddress.substring(index + 1);
              }
              foundIpAddress = foundIpAddress.substring (0, index);
            }
          }
        }
        // bridges are announced repeatedly, filter duplicates
        if (foundIpBridge && (foundIpAddress != null)) {
          if (!bridgesFoundAtIpAddress.contains(foundIpAddress)) {
            bridgesFoundAtIpAddress.add (foundIpAddress);
            print ("Discovered bridge at $foundIpAddress : $foundPort");
            foundBridgeCallBack(foundIpAddress, foundPort);
          }
        }
      }
    }
  }

  void sendMSearchMessage () {
    final String mSearchString =
        "M-SEARCH * HTTP/1.1\r\n" +
            "HOST: 239.255.255.250:1900\r\n" +
            "MAN: \"ssdp:discover\"\r\n" +
            "MX: 3\r\n" +
            "ST: upnp:rootdevice\r\n";
    List<int> mSearchBytes = (new AsciiEncoder()).convert(mSearchString);
    int count = rawSocket.send(mSearchBytes, upnpIpAddress, upnpPort);
    print ("Searching for bridge $count bytes send");
  }

  void startSearch () async {
    // only tested with real bridge
    rawSocket = await RawDatagramSocket.bind(upnpIpAddress, upnpPort);
    socketListener = rawSocket.listen(_handleRawSocketEvent);
    rawSocket.multicastHops = 64; // set TimeToLive
    rawSocket.multicastLoopback = false; // don't receive my own message
    rawSocket.joinMulticast(upnpIpAddress);

    new Timer(new Duration(seconds: 2), sendMSearchMessage);
  }

  void stopSearch () {
    // not tested yet
    socketListener.cancel();
    rawSocket.leaveMulticast(upnpIpAddress);
    rawSocket.close();
  }
}
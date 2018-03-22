import 'dart:collection';
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';


_getLights() async {
  var url = 'http://130.142.133.229:32787/api/0/lights';
  var httpClient = new HttpClient();

  String result = "";
  try {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var json = await response.transform(UTF8.decoder).join();
      print("This is json: ${json.toString()}");
      String data = JSON.decode(json).toString();
      result = data;
    } else {
      result =
      'Error getting IP address:\nHttp status ${response.statusCode}';
    }
  } catch (exception) {
    result = 'Failed getting IP address ${exception.toString()}';
  }
}


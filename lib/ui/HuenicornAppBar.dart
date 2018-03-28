import 'package:flutter/material.dart';

AppBar createAppBar(String title, List <Widget> appBarActions) {
  return new AppBar(
      title: new Text(title),
      backgroundColor: Colors.grey[850],
      actions: appBarActions
  );
}

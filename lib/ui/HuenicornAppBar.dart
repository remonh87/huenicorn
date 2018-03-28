import 'package:flutter/material.dart';

class HuenicornAppBar extends AppBar {

  HuenicornAppBar(BuildContext context, String title, List <Widget> appBarActions) : super(
    title: new Text(title),
    backgroundColor: Colors.grey[850],
    actions: appBarActions
  );
}

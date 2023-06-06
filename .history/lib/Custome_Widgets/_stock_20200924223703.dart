import 'dart:ui';

import 'package:flutter/material.dart';

class ZContainer extends StatefulWidget {
  ZContainer(String symbol, String exchange) {
  }

  @override
  _ZContainerState createState() => _ZContainerState();
}

class _ZContainerState extends State<ZContainer> {
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: MediaQuery.of(context).size.height*0.0,
      child: Text("asasdasd"),
    );
  }
}

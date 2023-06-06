import 'dart:ui';

import 'package:flutter/material.dart';

class ZContainer extends StatefulWidget {
  ZContainer(String ) {
    _ZContainerState().index = index;
  }

  @override
  _ZContainerState createState() => _ZContainerState();
}

class _ZContainerState extends State<ZContainer> {
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
    );
  }
}

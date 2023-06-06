import 'dart:ui';

import 'package:flutter/material.dart';

class ZContainer extends StatefulWidget {
  @override
  _ZContainerState createState() => _ZContainerState();
}

class _ZContainerState extends State<ZContainer> {
  
  Color _themeColor = Colors.grey[500];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: _themeColor, borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.apps),
                    Column(
                      children: <Widget>[
                        Text("Apple",style: TextStyle(color: Colors.black),),
                        Text("AAPL")
                      ],
                    )
                  ],
                )
              ],
            )));
  }
}

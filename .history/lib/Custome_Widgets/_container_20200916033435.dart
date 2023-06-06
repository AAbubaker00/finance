import 'dart:ui';

import 'package:flutter/Material.dart';

class zContainer extends StatefulWidget {
  @override
  _zContainerState createState() => _zContainerState();
}

class _zContainerState extends State<zContainer> {
  
  Color _themeColor = Colors.grey[500];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DecoratedBox(
          col
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

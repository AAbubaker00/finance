import 'dart:ui';

import 'package:flutter/material.dart';

class ZContainer extends StatefulWidget {
  int index 

  @override
  _ZContainerState createState() => _ZContainerState();
}

class _ZContainerState extends State<ZContainer> {
  Color _themeColor = Colors.grey[500];

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.all(10),
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 5,
                        spreadRadius: 2,
                        color: Colors.grey[200])
                  ]),
              child: InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.apps),
                            VerticalDivider(),
                            Column(
                              children: [
                                Text("Apple"),
                                Text("AAPL, inc (NASDAQ)")
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Index $index',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    ],
                  ))),
        );
  }
}

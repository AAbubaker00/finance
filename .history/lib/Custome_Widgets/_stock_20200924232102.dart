import 'dart:ui';

import 'package:flutter/material.dart';

class ZContainer extends StatefulWidget {
  ZContainer(String symbol, String exchange) {}

  @override
  _ZContainerState createState() => _ZContainerState();
}

class _ZContainerState extends State<ZContainer> {
  int index;

  TextStyle symbolStyle = TextStyle(color: Colors.white);
  TextStyle nameStyle = TextStyle(color: Colors.grey[300]);
  TextStyle exchnageStyle = TextStyle(color: Colors.grey[300]);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: MediaQuery.of(context).size.height * 0.13,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "APPL",
                            style: symbolStyle,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Apple .inc Corp",
                            style: nameStyle,
                          ),
                          Text(
                            "NASDAQ",
                            style: exchnageStyle,
                          )
                        ],
                      ),
                      Align(
                        al
                          child: VerticalDivider(
                        color: Colors.green[200],
                        thickness: 5,
                      ))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

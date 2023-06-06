import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart' as Folding;

class ZContainer extends StatefulWidget {
  ZContainer(String symbol, String exchange) {}

  @override
  _ZContainerState createState() => _ZContainerState();
}

class _ZContainerState extends State<ZContainer> {
  final _foldingCellKey = GlobalKey<Folding.SimpleFoldingCellState>();

  TextStyle symbolStyle = TextStyle(color: Colors.white);
  TextStyle nameStyle = TextStyle(color: Colors.grey[300]);
  TextStyle exchnageStyle = TextStyle(color: Colors.grey[300]);
  TextStyle stanStyle = TextStyle(color: Colors.grey[300]);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.1,
      padding: EdgeInsets.only(left: 20, ri),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  child: Align(alignment: Alignment.center, child:Text("AAPL")),
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Apple plc"
                    ),
                    Text("20 shares"),
                  ],
                )
              ],
            ),
            Column(
              children: [
                Text(
                      "£567"
                    ),
                    Text(" +£0.05 (5.3%)"),
                  
              ],
              
            )
          ],
        ),
      )
    );
  }
}

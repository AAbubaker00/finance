import 'dart:ui';
import 'package:flutter/material.dart';

class MiniStockWindow extends StatefulWidget {
  MiniStockWindow(String symbol, String exchange) {}

  @override
  _MiniStockWindowState createState() => _MiniStockWindowState();
}

class _MiniStockWindowState extends State<MiniStockWindow> {

  TextStyle symbolStyle = TextStyle(color: Colors.white);
  TextStyle nameStyle = TextStyle(color: Colors.grey[300]);
  TextStyle exchnageStyle = TextStyle(color: Colors.grey[300]);
  TextStyle stanStyle = TextStyle(color: Colors.grey[300]);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
          child: Container(
          height: MediaQuery.of(context).size.height * 0.09,
          padding: EdgeInsets.only(left: 5, right: 5, top: 5),
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300]))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.15,
                      margin: EdgeInsets.all(5),
                      child:DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200]
                        ),
                        child: Align(alignment: Alignment.center, child: Text("AAPL")),
                      )
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Apple plc"),
                        Text("20 shares"),
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("£567"),
                    Text(" +£0.05 (5.3%)"),
                  ],
                )
              ],
            ),
          )),
    );
  }
}


class SearchStockWindow extends S
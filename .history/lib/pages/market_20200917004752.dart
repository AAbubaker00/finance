import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:finance/custome_Widgets/_quote.dart';

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  List<String> _popularStock = [
    "Apple",
    "Tesla",
    "Netflix",
    "Facebook",
    "Twitter",
    "Alibaba",
    "Snapchat",
    "Slack",
    "Amazon",
    "Microsoft"
  ];

  int _numOfTabs = 2;

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 300.0,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(8),
      children: List.generate(20, (index) {
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
                    mainAxisAlignment: Mai,
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
      }).toList(),
    );
    // return Stack(children: <Widget>[
    //   Container(
    //       color: Colors.black,
    //       height: window.physicalSize.height + 50,
    //       width: window.physicalSize.width,
    //       child:
    //   // new DefaultTabController(
    //   //   length: _numOfTabs,
    //   //   child: new Scaffold(
    //   //     appBar: new PreferredSize(
    //   //       preferredSize: Size.fromHeight(kToolbarHeight),
    //   //       child: Container(
    //   //         child: Column(
    //   //           children: <Widget>[
    //   //             new TabBar(tabs: [new Text("LSE",style: TextStyle(color: Colors.red),), new Text('AMEX')])
    //   //           ],
    //   //         )
    //   //       ),
    //   //     ),
    //   //     body: new TabBarView(children: <Widget>[
    //   //       new Text("1"),
    //   //       new Text("2")
    //   //     ])
    //   //   ),
    //   // )
    // ]);
  }
}

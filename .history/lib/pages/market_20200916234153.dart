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
    return Stack(children: <Widget>[
      Container(
        padding: EdgeI,
          height: window.physicalSize.height + 50,
          child: GridView.count(
            crossAxisCount: 2,
            children: _popularStock.map((e) {
              return Text("aaa");
            }).toList(),
          ))
      // new DefaultTabController(
      //   length: _numOfTabs,
      //   child: new Scaffold(
      //     appBar: new PreferredSize(
      //       preferredSize: Size.fromHeight(kToolbarHeight),
      //       child: Container(
      //         child: Column(
      //           children: <Widget>[
      //             new TabBar(tabs: [new Text("LSE",style: TextStyle(color: Colors.red),), new Text('AMEX')])
      //           ],
      //         )
      //       ),
      //     ),
      //     body: new TabBarView(children: <Widget>[
      //       new Text("1"),
      //       new Text("2")
      //     ])
      //   ),
      // )
    ]);
  }
}

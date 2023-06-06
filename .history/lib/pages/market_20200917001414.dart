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
          child: DecoratedBox(
              decoration: BoxDecoration(
                color: ,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,3),
                    blurRadius: 5,
                    spreadRadius: 7,
                    color: Colors.grey[100]
                    )]),
              child: InkWell(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.apps,
                    size: 48.0,
                    color: Colors.blue,
                  ),
                  Divider(),
                  Text(
                    'Index $index',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
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

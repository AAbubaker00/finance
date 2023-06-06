import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(child: DefaultTabController(
          length: 4,
          child: SacffoTabBar(
            tabs: <Widget>[
              Tab(
                  child: Text('lol')
                ),
            ],
          )
        ),)
      ],
    );
  }
}

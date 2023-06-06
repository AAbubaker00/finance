import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top:0,
            left: 0,
            right: 0,
            child: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text('lol')
                ),
                Tab(
                  child: Text('lol')
                ),
                Tab(
                  child: Text('lol')
                ),
              ],
            )
          )
        ],
      )
    );
  }
}

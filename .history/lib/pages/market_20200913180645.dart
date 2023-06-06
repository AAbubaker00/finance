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
        Positioned(
          top: -10,
          left:0,
          right: 0,
          child: DefaultTabController(
          length: 4,
          child: Scaffold( appBar:AppBar(bottom: TabBar(
            tabs: <Widget>[
              Tab(
                  child: Text('lol')
                ),Tab(
                  child: Text('lol')
                ),Tab(
                  child: Text('lol')
                ),Tab(
                  child: Text('lol')
                ),
            ],
          ))
        )),)
      ],
    );
  }
}

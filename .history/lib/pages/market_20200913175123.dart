import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(child: Scaffold(
      appBar: AppBar(
        bottom: TabBar(tabs: <Widget>[
          Tab(child: Text('lol')),
        ]),
      ),)
    );
  }
}

import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {

int _numOfTabs = 3;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new DefaultTabController(
          length: _numOfTabs, 
          child: new Scaffold(
            appBar: new PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Container(
                child: Column(
                  children: <Widget>[],
                )
              ), 
          )
          ),
        )
      ]
    );
  }
}

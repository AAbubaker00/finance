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
        new DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: new PreferredSize(            
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: new Container(
                  child: SafeArea(
                    child: Column(
                      children: <Widget>[
                        new TabBar(
                          tabs: [
                            new Tab(
                              child: Text('Global', style: TextStyle(color: Colors.black),)
                            ),
                            new Tab(
                              child: Text('Europe', style: TextStyle(color: Colors.black))
                            ),
                            new Tab(
                              child: Text('US', style: TextStyle(color: Colors.black))
                            ),
                            new Tab(
                              child: Text('Aisha', style: TextStyle(color: Colors.black))
                            )
                          ],
                        )
                      ],
                    )
                  )
                )
             ),
             body: new Tab
          )
        ),
        Positioned(
          top:20,
          right: 0,
          left:0,
          child: Container(

          ),
        )
      ]
    );
  }
}

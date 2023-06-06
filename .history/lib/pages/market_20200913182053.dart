import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
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
                            child: Text('Global', style: Te,)
                          ),
                          new Tab(
                            child: Text('Europe')
                          ),
                          new Tab(
                            child: Text('US')
                          ),
                          new Tab(
                            child: Text('Aisha')
                          )
                        ],
                      )
                    ],
                  )
                )
              )
           ),
        )
      );
  }
}

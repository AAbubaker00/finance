import 'package:finance/sections/charts.dart';
import 'package:flutter/material.dart';

class Stock extends StatefulWidget {
  Stock({String name, String exchange, String symbol}) {}

  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  String name, exchange, symbol;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Column(
              children: [
                ne
                new TabBar(
                  tabs: [
                    new Text("Summary"),
                    new Text("Finacials"),
                    new Text('Dividends')
                  ]
                )
              ],
            ),
          ),
          ),
          body: TabBarView(
            children: <Widget>[
              
            ],

          ),
        ),
      )
    );
  }
}

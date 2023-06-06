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
        length: 2,
        child: Scaffold(
          appBar: AppBar(
                title: Text("dasdas"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.star_border),
                    onPressed: () {},
                  )
                ],
                bottom: TabBar(
                  tabs: [new Text("Lunches"), new Text("Cart")],
                ),
              )
              ),
              body: new TabBarView(
            children: <Widget>[
              new Column(
                children: <Widget>[new Text("Lunches Page")],
              ),
              new Column(
                children: <Widget>[new Text("Cart Page")],
              )
            ],
          ),
        
      ),
    );
  }
}

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
      child: Scaffold(
        appBar: new PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBar(
              title: Text("dasdas"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.star_border),
                  onPressed: (){},

                )
              ],
            )),
            body: ListView.builder(
              itemBuilder: 4
              )
      ),
    );
  }
}

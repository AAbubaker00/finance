import 'package:flutter/material.dart';

class Stock extends StatefulWidget {

  Stock({String name, String market, String symbol}){

  }

  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  String name, market, symbol
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child:AppBar(
            title: Text("dasdas"),
          )
        ),
      ),
    );
  }
}

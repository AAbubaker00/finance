import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchContainer extends StatefulWidget {
  SearchContainer(String symbol, String exchange, String name) {
    _SearchContainerState()
      ..exchange = exchange
      ..name = name
      ..symbol = symbol;
  }

  @override
  _SearchContainerState createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  String name, exchange, symbol;

  @override
  Widget build(BuildContext context) {
    print)
    return InkWell(
        child: Container(
            child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[Text(symbol), Text(name)],
        )
      ],
    )));
  }
}

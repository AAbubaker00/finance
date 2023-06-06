import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchContainer extends StatefulWidget {
  @override
  _SearchContainerState createState() => _SearchContainerState();
}


class _SearchContainerState extends State<SearchContainer>{
  String name, market, symbol;
  
  SearchContainer(this.symbol,this.market, this.name);

  @override
  Widget build(BuildContext context) {
    return InkWell(child: Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(symbol),
              Text(name)
            ],
          )
        ],
      )
    ));
  }
}

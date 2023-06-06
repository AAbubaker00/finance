import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchContainer extends StatelessWidget {
  String name, market, symbol;
  
  SearchContainer(this.symbol,this.market, this.name);

  @override
  Widget build(BuildContext context) {
    return InkWell(child: Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(sy)
            ],
          )
        ],
      )
    ));
  }
}

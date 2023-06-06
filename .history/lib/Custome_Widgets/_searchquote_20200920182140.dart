import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchContainer extends StatefulWidget {
  
  SearchContainer(String symbol,String , this.name);
  @override
  _SearchContainerState createState() => _SearchContainerState();
}


class _SearchContainerState extends State<SearchContainer>{

  String name, market, symbol;
  

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

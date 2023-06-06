import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchContainer extends StatefulWidget {
  @SemanticsHintOverrides

}
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

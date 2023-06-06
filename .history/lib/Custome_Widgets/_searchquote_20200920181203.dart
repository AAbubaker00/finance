import 'package:flutter/cupertino.dart';

class SearchContainer extends StatelessWidget {
  String name, market, symbol;
  SearchContainer({this.symbol,this.market, this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(chioContainer(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[

            ],
          )
        ],
      )
    );
  }
}

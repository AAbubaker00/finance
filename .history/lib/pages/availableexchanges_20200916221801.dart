import 'package:flutter/material.dart';

class AvailableExchange extends StatelessWidget {
  TextStyle _textStyle = new TextStyle(fontSize: 20, color: Colors.white);

  

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Text('Exchanges',style: _textStyle),
            ),
            Align(alignment: Alignment.topLeft, child: Text("Available", style: _textStyle,)),
            Align(alignment: Alignment.topLeft, child: Container(child: GridView.extent(maxCrossAxisExtent: 2,children: <Widget>[

            ],))),
          ],
        )
      );
  }
}

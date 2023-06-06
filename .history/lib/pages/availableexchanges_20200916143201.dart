import 'package:flutter/material.dart';

class AvailableExchange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text('Exchanges'),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text("Sele")
          )
        ],
      )
    );
  }
}
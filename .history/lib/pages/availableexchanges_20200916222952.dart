import 'package:flutter/material.dart';

class AvailableExchange extends StatelessWidget {
  TextStyle _textStyle = new TextStyle(fontSize: 20, color: Colors.white);

  List<String> _aExchnages = ["LSE", "AMEX", "NYSE", "NASDAQ"];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Text('Exchanges', style: _textStyle),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Available",
                  style: _textStyle,
                )),
                Container(
                    child: GridView.count(
                  crossAxisCount: 2,
                  children: _aExchnages.map((e) {
                    return FlatButton(
                      child: Text(e),
                      onPressed: (){
                      },
                    );
                  }).toList(),
                )),
          ],
        ));
  }
}

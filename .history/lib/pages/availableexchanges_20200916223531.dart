import 'package:flutter/material.dart';

class AvailableExchange extends StatelessWidget {
  TextStyle _textStyle = new TextStyle(fontSize: 20, color: Colors.white);

  List<String> _aExchnages = ["LSE", "AMEX", "NYSE", "NASDAQ"];

  FlatButton _fbtn(String title) {
    return FlatButton(onPressed: () {}, child: Text(title),color: Colors.yellow,w);
  }

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
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                  color: Colors.deepPurple,
                  height: 700,
                  width: 700,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: _aExchnages.map((e) {
                      return _fbtn(e);
                    }).toList(),
                  )),
            ),
          ],
        ));
  }
}

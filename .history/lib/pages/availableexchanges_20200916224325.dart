import 'package:flutter/material.dart';

class AvailableExchange extends StatelessWidget {
  TextStyle _textStyle = new TextStyle(fontSize: 20, color: Colors.white);

  List<String> _aExchnages = ["LSE", "AMEX", "NYSE", "NASDAQ"];

  FlatButton _fbtn(String title) {
    return FlatButton(onPressed: () {}, child: Text(title),color: Colors.yellow,);
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
            Sta(
              child: Container(
                  color: Colors.deepPurple,
                  height: 300,
                  width: 1200,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3.0,
                    children: _aExchnages.map((e) {
                      return _fbtn(e);
                    }).toList(),
                  )),
            ),
          ],
        ));
  }
}

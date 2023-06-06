import 'package:flutter/material.dart';

class AvailableExchange extends StatelessWidget {
  TextStyle _textStyle = new TextStyle(fontSize: 20, color: Colors.white);

  List<String> _aExchnages = ["LSE", "AMEX", "NYSE", "NASDAQ"];

  FlatButton{
    
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
                    children: _aExchnages.map((e) {
                      return FlatButton(
                        child: Text(e),
                        onPressed: (){
                        },
                      );
                    }).toList(),
                  )),
                ),
          ],
        ));
  }
}

import 'package:flutter/Material.dart';

class zContainer extends StatefulWidget {
  String name, symbol;

  zContainer({this.name, this.symbol});

  @override
  _zContainerState createState() => _zContainerState(name, symbol);
}

class _zContainerState extends State<zContainer> {
  String name, symbol;

  Text _nTxt;
  Text _sTxt;

  Icon _logo;

  var _cost;
  var _dailyChange;

  Color _themeColor = Colors.grey[500];

  _zContainerState({this.name, this.symbol}) {
    
    _nTxt = new Text(name);
    _sTxt = new Text(symbol);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: _themeColor, borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _logo,
                    Column(
                      children: <Widget>[_nTxt, _sTxt],
                    )
                  ],
                )
              ],
            )));
  }
}

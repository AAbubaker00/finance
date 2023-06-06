import 'package:flutter/Material.dart';

class zContainer extends StatefulWidget {

  zContainer(String name, String symbol){
    _zContainerState().
  }
  @override
  _zContainerState createState() => _zContainerState();
}

class _zContainerState extends State<zContainer> {
  Text _nTxt;
  Text _sTxt;

  Icon _logo;

  var _cost;
  var _dailyChange;

  Color _themeColor = Colors.grey[500];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _themeColor, 
          borderRadius: BorderRadius.circular(5)
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _logo,
                Column(
                  children: <Widget>[
                    T
                  ],
                )
              ],
            )
          ],
        )
      )
    );
  }
}

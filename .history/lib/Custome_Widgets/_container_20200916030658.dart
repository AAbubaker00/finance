import 'package:flutter/cupertino.dart';

class zContainer extends StatefulWidget {
  @override
  _zContainerState createState() => _zContainerState();
}

class _zContainerState extends State<zContainer> {
  String _name;
  String _symbol;

  Icon _logo;

  var _cost;
  var _dailyChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
        color
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5)
        ),
      )

    );
  }
}

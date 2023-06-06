import 'package:Strice/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class Portfolios extends StatefulWidget {
  Portfolios({Key key}) : super(key: key);

  @override
  _PortfoliosState createState() => _PortfoliosState();
}

class _PortfoliosState extends State<Portfolios> {
  var themeMode = true;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: UserThemes(themeMode),
      child: SafeArea(child: Scaffold()),
    );
  }
}

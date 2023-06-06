import 'package:flutter/material.dart';
import 'package:finance/shared/themes.dart';

class NewPortfolio extends StatefulWidget {
  @override
  _NewPortfolioState createState() => _NewPortfolioState();
}

class _NewPortfolioState extends State<NewPortfolio> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: DarkTheme().backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: DarkTheme().backgroundColour,
          
        ),
      ),
    );
  }
}

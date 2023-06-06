import 'package:flutter/material.dart';
import 'package:calendar_strip/calendar_strip.dart' as cs;

class Dividend extends StatefulWidget {
  @override
  _DividendState createState() => _DividendState();
}

class _DividendState extends State<Dividend> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              
            )
          ],
        )
      ),
    );
  }
}

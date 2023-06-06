import 'package:flutter/material.dart';

class Dividend extends StatefulWidget {
  @override
  _DividendState createState() => _DividendState();
}

class _DividendState extends State<Dividend> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.w,
                  borderRadius: BorderRadius.circular(10)
                ),
              )
            )
          ],
        ),
      )
    );
  }
}

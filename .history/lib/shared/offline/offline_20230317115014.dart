import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class Offline extends StatelessWidget {
  const Offline();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Column(
        mainAxisSize: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/noConnection.png',
            width: 100,
            height: 100,
            color: chartTextColour,
          ),
        ],
      ),
    ));
  }
}

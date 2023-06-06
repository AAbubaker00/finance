import 'package:flutter/material.dart';

class Offline extends StatelessWidget {
  const Offline();

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
      child: Column(
        children: [
           Image.asset(
                        'assets/icons/menu.png',
                        width: iconSize,
                        height: iconSize,
                        color: iconColour,
                      ),
        ],
      ),
    ));
  }
}
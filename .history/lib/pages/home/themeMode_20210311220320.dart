import 'package:finance/shared/themes.dart';
import 'package:flutter/material.dart';


class ColourMode extends StatefulWidget {
  @override
  _ColourModeState createState() => _ColourModeState();
}

class _ColourModeState extends State<ColourMode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: DarkTheme().backgroundColour,
      child: SafeArea(),
      
    );
  }
}
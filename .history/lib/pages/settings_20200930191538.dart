import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  List options = ["About us", "Documentaion", "Log Out"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: options.map((o)),
        ),
      ),
    );
  }
}

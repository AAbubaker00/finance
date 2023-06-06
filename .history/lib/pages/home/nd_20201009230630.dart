import 'package:flutter/material.dart';

class Nd extends StatefulWidget {
  @override
  _NdState createState() => _NdState();
}

class _NdState extends State<Nd> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
              child: Scaffold(
              body: Stack(
            children: [],
          ),
        ),
      ),
    );
  }
}
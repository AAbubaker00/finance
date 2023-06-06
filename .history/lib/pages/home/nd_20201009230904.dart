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
            children: [
              Positioned(
                top: 10,
                right: 100,
                left: ,
                child: Container(
                  color: Colors.red,
                  child: Column(
                    children: [
                      Text("Apple")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
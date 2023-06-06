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
                right: 200,
                left: 10,
                child: Container(
                  color: Colors.red,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Apple"),
                          Column(
                            children: [
                              Text("")
                            ],
                          )
                        ],
                      )
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                child: Row(
                  children: [
                    CircleAvatar(),
                    Column(
                      children: [
                        Text("Abdull Abubaker"),


                      ],
                    )

                  ],
                ),
              ), 
            ),
            Positioned(
              top: 50,
              right: 10,
              left: 10,
              child: Container(
                child: Stack(
                  children: [
                    ListView(
                      
                    )
                  ],
                )
              ),
            )
          ],
        )
      ),
    );
  }
}

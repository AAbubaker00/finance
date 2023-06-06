import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List portfolios = [
    ""
  ];

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
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(radius: 20,),
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
            top: 100,
            right: 10,
            left: 10,
            child: Container(
              padding: EdgeInsets.all(10),
                child: Stack(
              children: [
                Text("Portfolios", style: TextStyle(fontSize: 20)),
                Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.purp,
                      borderRadius: BorderRadius.circular(50)

                    ),
                  ),
                )
              ],
            )),
          )
        ],
      )),
    );
  }
}

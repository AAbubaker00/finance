import 'package:finance/custome_Widgets/_navigationbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List portfolios = [""];

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
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Abdull Abubaker"),
                          Row(
                            children: [
                              Text("Net Worth: £56,782,334"),
                              SizedBox(width: 20,),                              
                              Text("Margin: £56,782,334"),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  IconButton(icon: Icon(Icons.notifications), onPressed: null)
                ],
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: 20,
            left: 20,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.red, width: 5)),
                        child: Center(
                            child: Text(
                          "+46%",
                          style: TextStyle(fontSize: 35),
                        )),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Stock Portfolio"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [Text("Vlaue"), Text("£7272")],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [Text("Gain/Loss"), Text("+12.2%")],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(bottom: 10, right: 60, left: 60, child: ZNavigationBar())
        ],
      )),
    );
  }
}

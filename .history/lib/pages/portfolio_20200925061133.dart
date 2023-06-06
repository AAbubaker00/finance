import 'package:finance/custome_Widgets/_stock.dart';
import 'package:flutter/material.dart';
import 'package:finance/custome_Widgets/_cusome_expansion_tile.dart' as custome;
import 'dart:ui';

class Portfolio extends StatefulWidget {
  static Portfolio(){
    double width = window.physicalSize.width;
    double height = window.physicalSize.height;

    if ((width / height) > 1.76) {
      //  16/9
       _PortfolioState()._fromTop = 240;
    } else if ((width / height) < 1.77 && (width / height) >= 1.6) {
      // 16/10
      _PortfolioState()._fromTop = 300;
    }
  }
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  List stocks = [
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple"
  ];

  static double _fromTop = 0;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.27,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                toolbarHeight: 40,
                backgroundColor: Colors.transparent,
                title: Text("asdasd"),
              ),
            ),
            Positioned(
              bottom: 15,
              top: _fromTop,
              right: 10,
              left: 10,
              child: Container(
                  child: DecoratedBox(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: stocks.map((s) {
                    return ZContainer("symbol", "exchange");
                  }).toList(),
                ),
              )),
            ),
            Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        height: MediaQuery.of(context).copyWith().size.height *
                            0.15,
                        width:
                            MediaQuery.of(context).copyWith().size.width * 0.45,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.attach_money),
                              Text("Total Invested"),
                              Text("£2,282")
                            ],
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          height:
                              MediaQuery.of(context).copyWith().size.height *
                                  0.15,
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.45,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.attach_money),
                                Text("Total Invested"),
                                Text("£2,282")
                              ],
                            ),
                          ))
                    ],
                  ),
                  custome.ExpansionTile(
                    backgroundColor: Colors.transparent,
                    headerBackgroundColor: Colors.transparent,
                    iconColor: Colors.white,
                    title: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "View Portfolio Stasistics",
                          style: TextStyle(color: Colors.white),
                        )),
                    children: [
                      Container(
                        color: Colors.pink,
                        height: MediaQuery.of(context).size.height * 0.8,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

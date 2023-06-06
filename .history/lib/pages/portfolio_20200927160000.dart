import 'package:finance/custome_Widgets/_stock.dart';
import 'package:finance/sections/charts.dart';
import 'package:flutter/material.dart';
import 'package:finance/custome_Widgets/_cusome_expansion_tile.dart' as custome;
import 'package:flip_card/flip_card.dart' as Flip;
import 'dart:ui';
import 'dart:math' as math;

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  List stocks = [
    "apple",
    "apple",
    "apple",
  ];

  GlobalKey<Flip.FlipCardState> flipCardKey = GlobalKey<Flip.FlipCardState>();
  double _fromTop;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    double aspectRatio =
        (window.physicalSize.height / window.physicalSize.width);

    if (aspectRatio >= 1.7) {
      _fromTop = 240;
    } else if (aspectRatio <= 1.6) {
      _fromTop = 630;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
              bottom: 0,
              top: _fromTop,
              right: 5,
              left: 5,
              child: Container(
                  child: DecoratedBox(
                    decoration:
                        BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)
                        ),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: stocks.map((s) {
                        return ZContainer("symbol", "exchange");
                      }).toList(),
                    ),
                  )),
            ),
            Positioned(
              top: 35,
              left: 5,
              right: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).copyWith().size.height * 0.2,
                width: MediaQuery.of(context).copyWith().size.width * 0.9,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Summary  ")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: [
                              Text("5626"),
                              Text("Total Shares")
                            ],
                          ),
                          Column(
                            children: [
                              Text("5626"),
                              Text("Total Invested")
                            ],
                          ),
                          Column(
                            children: [
                              Text("5626"),
                              Text("Total Stocks")
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text("£51,626,262"),
                              Text("Total Investment Capital")
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

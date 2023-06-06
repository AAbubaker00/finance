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
      _fromTop = 470;
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
                left: 0,
                right: 0,
                top: _fromTop - 30,
                child: Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Top Gains"),
                        FlatButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {},
                            child: Transform.rotate(
                                angle: 270 * math.pi / 180,
                                child: Icon(Icons.arrow_drop_down_circle)))
                      ],
                    ))),
            Positioned(
                left: 10,
                right: 10,
                top: _fromTop - 230,
                child: Container(
                  width: 100,
                  height: ,
                  child: Charts()
                )),
            Positioned(
              bottom: 0,
              top: _fromTop,
              right: 0,
              left: 0,
              child: Container(
                height: 500,
                width: 500,
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

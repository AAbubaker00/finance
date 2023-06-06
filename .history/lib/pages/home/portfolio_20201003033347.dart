import 'package:finance/custome_Widgets/_navigationbar.dart';
import 'package:finance/custome_Widgets/_stockwindow.dart';
import 'package:finance/sections/charts.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart' as Flip;
import 'dart:ui';

class ViewPortfolio extends StatefulWidget {
  @override
  _ViewPortfolioState createState() => _ViewPortfolioState();
}

class _ViewPortfolioState extends State<ViewPortfolio> {
  List stocks = [
    "apple",
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

    print(aspectRatio);
    print(window.physicalSize.height);
    print(window.physicalSize.width);

    if (aspectRatio >= 1.7) {
      _fromTop = 220;
      print("1");
    } else if (aspectRatio <= 1.6) {
      _fromTop = 630;
      print("2");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Stack(
          children: [
            //!Black Container Section
            
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),

            //!AppBar

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                toolbarHeight: 40,
                backgroundColor: Colors.black,
                title: Text("asdasd"),
              ),
            ),

            //! Summary Section

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
                      color: Color,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Text("Summary  ")],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: [Text("5626"), Text("Total Shares")],
                          ),
                          Column(
                            children: [Text("5626"), Text("Total Invested")],
                          ),
                          Column(
                            children: [Text("5626"), Text("Total Gain")],
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

            //!User Stocks Section

            Positioned(
              bottom: 290,
              top: _fromTop,
              right: 15,
              left: 15,
              child: InkWell(
                onTap: () {
                  print("user stocks");
                },
                child: Stack(
                  children: [
                    Text("Your Stocks "),
                    Container(
                        color: Colors.red,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)),
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: stocks.map((s) {
                              return MiniStockWindow("symbol", "exchange");
                            }).toList(),
                          ),
                        )),
                  ],
                ),
              ),
            ),

            //!Graphs Section
            Positioned(
                top: _fromTop + 320,
                bottom: 10,
                right: 14,
                left: 14,
                child: Stack(children: [
                  Container(
                      child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Flip.FlipCard(
                      key: flipCardKey,
                      front: SectorCharts(),
                      back: StockCharts(),
                    ),
                  )),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () =>
                            flipCardKey?.currentState?.toggleCard(),
                        icon: Icon(Icons.arrow_right),
                      ))
                ])),
            Positioned(bottom: 10, right: 60, left: 60, child: ZNavigationBar())
          ],
        ),
      ),
    );
  }
}
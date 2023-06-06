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
      child: DefaultTabController(
        length: 3,
              child: Scaffold(
          backgroundColor: Color(0xff121212),
          body: Stack(
            children: [
            
              //!AppBar

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
            centerTitle: true,
            leading: Icon(Icons.person_outline),
            title: Text('HOME SCREEN',style: TextStyle(fontSize: 16.0),),
            bottom: PreferredSize(
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Text(‘Kumar'),
                      ),
                      Tab(
                        child: Text(‘Lokesh'),
                      ),
                      Tab(
                        child: Text(‘Rathod'),
                      ),
                      Tab(
                        child: Text(‘Raj'),
                      ),
                      Tab(
                        child: Text(’Madan'),
                      ),
                      Tab(
                        child: Text(‘Manju'),
                      )
                    ]),
                preferredSize: Size.fromHeight(30.0)),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.add_alert),
              ),
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: Center(
                  child: Text('Tab 1'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 2'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 3'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 4'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 5'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 6'),
                ),
              ),
            ],
          )
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
                        color: Colors.white,
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
                      Container(
                          child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Color(0xff222222),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black)),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: stocks.map((s) {
                            return Container(
                                height: MediaQuery.of(context).size.height * 0.09,
                                padding:
                                    EdgeInsets.only(left: 5, right: 5, top: 5),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: Color(0xff222222),
                                  ))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              margin: EdgeInsets.all(5),
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Colors.grey[200]),
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text("AAPL")),
                                              )),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Apple plc"),
                                              Text("20 shares"),
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text("£567"),
                                          Text(" +£0.05 (5.3%)"),
                                        ],
                                      )
                                    ],
                                  ),
                                ));
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
            ],
          ),
        ),
      ),
    );
  }
}

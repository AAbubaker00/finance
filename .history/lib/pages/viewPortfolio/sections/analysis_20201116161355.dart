import 'package:flutter/material.dart';

class Analysis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Container(
      color: Colors.black,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: DefaultTabController(
              length: 2,
              child: SizedBox(
                height: 330,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: Text(
                            "Stock Allocations",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Sector Allocations",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: TabBarView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Container(
                          child: Column(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: 270,
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.8),
                                child: SizedBox(
                                  child: stocksChart(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 1000),
                          child: SizedBox(
                            height: 250,
                            child: sectorChart(),
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(''),
                    Text('()'),
                    Text('daily change'),
                  ],
                ),
                Column(
                  children: [
                    Text(''),
                    Text('()'),
                    Text('Yearly Change'),
                  ],
                ),
                Column(
                  children: [
                    Text(''),
                    Text('()'),
                    Text('Total Change'),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Text('Net Assets Return'),
                        Text(portfolioValue.toString())
                      ], //value of whole account
                    ),
                    Column(
                      children: [
                        Text('Number Of holdings'),
                        Text(stocks.length.toString())
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('Base Currency'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('P/E Ratio'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                  ],
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Text('Inital Assets Value'),
                        Text((investedValue.toStringAsFixed(2))),
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('Shares Outstanding'),
                        Text(totalShares.toString())
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('Launch Date'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('P/B Ratio'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                  ],
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Text('Largest Sector Holding'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('Largest Asset Holding'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('Total Dividends Paid'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  
  }
}

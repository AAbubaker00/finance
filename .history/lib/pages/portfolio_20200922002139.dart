import 'package:flutter/material.dart';

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
    ),
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: <Widget>[
         Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    height: 150,
                    color: cntr_1_clr,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  _portfolio_Value,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                                Text(
                                  'Portfolio Value',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text('Invested',
                                    style: TextStyle(color: Colors.grey[400])),
                                Text(_invested,
                                    style: TextStyle(color: Colors.grey[400]))
                              ],
                            ),
                            SizedBox(width: 50),
                            Column(
                              children: <Widget>[
                                Text('Return',
                                    style: TextStyle(color: Colors.grey[400])),
                                Text(_return,
                                    style: TextStyle(color: Colors.grey[400]))
                              ],
                            ),
                            SizedBox(width: 50),
                            Column(
                              children: <Widget>[
                                Text('Rate',
                                    style: TextStyle(color: Colors.grey[400])),
                                Text(_return,
                                    style: TextStyle(color: Colors.grey[400]))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    right: 0.0,
                    left: 0.0,
                    bottom: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 80),
                            height: 70,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Upcoming Dividends',
                                          style: TextStyle(
                                              color: Colors.grey[400])),
                                      Text(_return,
                                          style: TextStyle(
                                              color: Colors.grey[400]))
                                    ],
                                  ),
                                  SizedBox(width: 25),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Next Divideneds',
                                          style: TextStyle(
                                              color: Colors.grey[400])),
                                      Text(_return,
                                          style: TextStyle(
                                              color: Colors.grey[400]))
                                    ],
                                  )
                                ],
                              ),
                            ))
                      ],
                    )),
                Positioned(
                  top: 150,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: <Widget>[
                      Profit(),
                    ],
                  ),
                ),
                Positioned(
                    top: 350,
                    right: 50,
                    left: 50,
                    child: Align(
                        alignment: Alignment.center,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: DecoratedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text('Total Stocks'),
                                        Text('1'),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text('Total Shares'),
                                        Text('1'),
                                      ],
                                    ),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.arrow_forward))
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red,
                                ))))),
        ],
      ),
    ),
    ));
  }
}

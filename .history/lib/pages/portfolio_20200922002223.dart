import 'package:flutter/material.dart';

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  St


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
        ],
      ),
    ),
    ));
  }
}

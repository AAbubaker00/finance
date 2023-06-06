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
        backgroundColor: Colors.grey,
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: AppBar(
                    title: Text("asdasd"),
                  ),
                )),
            Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          height: 100,
                          width: 100,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Icon(Icons.attach_money),
                                Text("Total Invested"),
                                Text("£2,282")
                              ],
                            ),
                          )),
                      Container(
                          height: 100,
                          width: 100,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Icon(Icons.attach_money),
                                Text("Total Invested"),
                                Text("£2,282")
                              ],
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 170,
              right: 10,
              left: 10,
              child: Container(
                  child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.red),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment:Alignment.centerLeft,
                      child: Text("Aquired Shares: 213123"),
                    ),
                    Text("Total Stocks: 12"),
                  ],
                ),
              )),
            )
          ],
        ),
      ),
    );
  }

  _allocations() {
    return Container(
      height: 500,
      color: Colors.red,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            right: 10,
            left: 10,
            child: Column(
              children: <Widget>[Text('£###'), Text('Portfolio Vlaue')],
            ),
          ),
          Positioned(
            top: 90,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('£###'),
                    Text('(-12%)'),
                    Text('Monthly Gain')
                  ],
                ),
                Container(
                  color: Colors.black,
                  width: 0.5,
                  height: 40,
                ),
                Column(
                  children: <Widget>[
                    Text('£###'),
                    Text('(+12%)'),
                    Text('Yearly Gain')
                  ],
                ),
                Container(
                  color: Colors.black,
                  width: 0.5,
                  height: 40,
                ),
                Column(
                  children: <Widget>[
                    Text('£###'),
                    Text('(-12%)'),
                    Text('Toatal Gain')
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 170,
            right: 10,
            left: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: <Widget>[
                    Text('£###'),
                    Text('(+12%)'),
                    Text('Yearly Gain')
                  ],
                ),
                Container(
                  color: Colors.black,
                  width: 50,
                ),
                Column(
                  children: <Widget>[
                    Text('£###'),
                    Text('(-12%)'),
                    Text('Toatal Gain')
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[Text("£asdadasd"), Text("Portfolio Value")],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[Text("£asdadasd"), Text("Total Gain"), Text("Daily Gain")],
//               ),
//               Column(
//                 children: <Widget>[Text("£asdadasd"), Text("52 Week Gain"), Text("Daily Gain")],
//               ),
//               Column(
//                 children: <Widget>[Text("£asdadasd"), Text("Daily Gain"), Text("Daily Gain")],
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Column(
//                 children: <Widget>[Text("£asdadasd"), Text("Acquired Stock")],
//               ),
//               Column(
//                 children: <Widget>[Text("£asdadasd"), Text("Acquired Shares")],
//               ),
//             ],
//           )

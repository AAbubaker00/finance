import 'package:flutter/material.dart';
import 'dart:ui';

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        backgroundColor: Colors.grey[300],
        app
        body: Stack(
          children: [
            
            Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                            padding: EdgeInsets.all(10),
                            height: MediaQuery.of(context).copyWith().size.height*0.15,
                            width: MediaQuery.of(context).copyWith().size.width*0.45,
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
                          ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                            height: MediaQuery.of(context).copyWith().size.height*0.15,
                            width: MediaQuery.of(context).copyWith().size.width*0.45,
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
              top: 200,
              right: 20,
              left: 20,
              child: Container(
              
                  child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.red),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
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

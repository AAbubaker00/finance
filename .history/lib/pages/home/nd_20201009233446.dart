import 'package:flutter/material.dart';

class Nd extends StatefulWidget {
  @override
  _NdState createState() => _NdState();
}

class _NdState extends State<Nd> {
   List months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List upcoming = [
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
  ];

  TextStyle nameStyle = TextStyle(color: Colors.white);
  TextStyle subtitleStyle = TextStyle(color: Colors.grey[600]);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        app
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 10,
                right: 220,
                left: 10,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("AAPL"),
                          Column(
                            children: [Text("£3223"), Text("+356.4%")],
                          )
                        ],
                      ),Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("AAPL"),
                          Column(
                            children: [Text("£3223"), Text("+356.4%")],
                          )
                        ],
                      ),Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("AAPL"),
                          Column(
                            children: [Text("£3223"), Text("+356.4%")],
                          )
                        ],
                      ),Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("AAPL"),
                          Column(
                            children: [Text("£3223"), Text("+356.4%")],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),Positioned(
                 top: 10,
                left: 200,
                right: 10,
                child: Container(
                  color: Colors.green,
                  height: MediaQuery.of(context).size.height*0.1,
                  child: Column(
                    children: [
                      Text("20"),
                      Text("Total Stocks")
                    ],
                  ),
                ),
              ),
              Positioned(
                 top: 100,
                left: 200,
                right: 10,
                child: Container(
                  color: Colors.yellow,
                  height: MediaQuery.of(context).size.height*0.1,
                  child: Column(
                    children: [
                      Text("20"),
                      Text("Total Shares")
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 200,
                right: 10,
                left: 200,
                child: Container(
                  color: Colors.blue,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: upcoming.map((d) {
                      return Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          padding: EdgeInsets.all(5),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[900]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Apple, inc corp",
                                        style: nameStyle,
                                      ),
                                      Text(
                                        "AAPl",
                                        style: nameStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "£636",
                                        style: nameStyle,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ));
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Dividend extends StatefulWidget {
  @override
  _DividendState createState() => _DividendState();
}

class _DividendState extends State<Dividend> {
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
  ];

  TextStyle nameStyle = TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.18,
                // padding: EdgeInsets.only(top: 10),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15)),
                    child: GridView.count(
                      padding: EdgeInsets.all(5),
                      crossAxisCount: 6,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                      children: months.map((m) {
                        return InkWell(
                          child: Container(
                            // margin: EdgeInsets.all(3),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                children: [
                                  Center(child: Text(m)),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Icon(
                                      Icons.brightness_1,
                                      color: Colors.red,
                                      size: 10,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ))),
          ),
          Positioned(
            top: 170,
            right: 10,
            left: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upcoming Dividends",
                  style: nameStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: upcoming.map((d) {
                      return Container(
                        height: MediaQuery.of(context).size.height*0.1,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(10),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[900]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                )
                              ],
                            ),
                          ));
                    }).toList(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class MonthDividend {
  final String comapny;
  final double amount;
  final String date;

  MonthDividend(
      {@required this.comapny, @required this.amount, @required this.date});
}

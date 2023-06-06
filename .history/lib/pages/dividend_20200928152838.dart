import 'package:flutter/material.dart';

class Dividend extends StatefulWidget {
  @override
  _DividendState createState() => _DividendState();
}

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

class _DividendState extends State<Dividend> {
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
                height: MediaQuery.of(context).size.height * 0.2,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                        child: GridView.count(
                      crossAxisCount: 6,
                      children: months.map((m) {
                        return Container(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Stack(
                              children: [
                                Center(child: Text(m)),
                                Align(alignment: Alignment.bottomRight,child: Icon(Icons.ball),)
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ))),
              ))
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

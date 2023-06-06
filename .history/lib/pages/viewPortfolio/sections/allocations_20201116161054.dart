import 'package:flutter/material.dart';

class Allocations extends StatelessWidget{
  Allocations(this.stocks)

  List stocks;
  @override
  Widget build(BuildContext context) {
    return return Container(
      padding: EdgeInsets.only(right: 10, top: 10),
        color: fas,
        child: GridView.count(
          physics: BouncingScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.5,
          children: stocks.map((stock) {
            return InkWell(
              child: Container(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    // color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: (double.parse(stock['change'].toString()) > 0
                          ? Colors.grey[300]
                          : Colors.deepOrange[700]),
                      width: 0.2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${stock['symbol']}",
                                  style: TextStyle(
                                      color: Color(0xFFF5F6F8),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " ${stock['marketData']['quote']['longName']}",
                                  style: TextStyle(color: Colors.grey[600]),
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ],
                            ),
                            Text(
                                '${double.parse(stock['buyPrice'].toString())} @ ${stock['shares']}',
                                style: TextStyle(
                                  color: Colors.white38,
                                )),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('VALUE',
                                        style: TextStyle(
                                          color: Colors.white38,
                                        )),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${(double.parse(stock['marketData']['quote']['regularMarketPrice'].toString()) * double.parse(stock['shares'].toString())).toStringAsFixed(2)}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25),
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                        ),
                                        Text(
                                          "${stock['marketData']['quote']['currency'].toString()}",
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    Text(
                                        '${double.parse(stock['marketData']['quote']['regularMarketPrice'].toString())}',
                                        style: TextStyle(
                                          color: Colors.white38,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('RETURN',
                                    style: TextStyle(
                                      color: Colors.white38,
                                    )),
                                Text(
                                  '${stock['change']}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: ((double.parse(stock['marketData']
                                                                  ['quote'][
                                                              'regularMarketPrice']
                                                          .toString()) -
                                                      double.parse(
                                                          stock['buyPrice']
                                                              .toString())) /
                                                  double.parse(stock['buyPrice']
                                                      .toString()) *
                                                  100) >
                                              0
                                          ? Colors.green
                                          : Colors.red),
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                                Text(
                                  '${stock['percDiff']}%',
                                  style: TextStyle(
                                      color: ((double.parse(stock['marketData']
                                                                  ['quote'][
                                                              'regularMarketPrice']
                                                          .toString()) -
                                                      double.parse(
                                                          stock['buyPrice']
                                                              .toString())) /
                                                  double.parse(stock['buyPrice']
                                                      .toString()) *
                                                  100) >
                                              0
                                          ? Colors.green[300]
                                          : Colors.red[300]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ));
  }
}
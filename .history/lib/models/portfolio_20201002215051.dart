import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Portfolios extends StatefulWidget {
  @override
  _PortfoliosState createState() => _PortfoliosState();
}

class _PortfoliosState extends State<Portfolios> {
  int portfolioCount = 0;
  List<Map<dynamic, dynamic>> stocks = [];
  List<Map<String, dynamic>> portdata = [];

  @override
  Widget build(BuildContext context) {
    final userStocks = Provider.of<QuerySnapshot>(context);

    getPortfolios(userStocks);
    print(portfolioCount);

    return ListView.builder(
      itemCount: portfolioCount,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.red, width: 5)),
                    child: Center(
                        child: Text(
                      "+46%",
                      style: TextStyle(fontSize: 35),
                    )),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Stock Portfolio"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [Text("Vlaue"), Text("£7272")],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [Text("Gain/Loss"), Text("+12.2%")],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  getPortfolios(QuerySnapshot querySnapshot) {
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>();

    for (var doc in querySnapshot.docs) {
      data.add(doc.data());
    }

    for (Map stock in data[0]['portfolio']) {
      if (portdata.isEmpty) {
        stocks.add(stock);
        portdata
            .add({'portfolioName': stock['portfolioName'], 'stocks': stocks});
      } else {
        Map dS = portdata.firstWhere(
            (s) => stock['portfolioName'] == s['portfolioName'],
            orElse: () => null);

        if (dS == null) {
          stocks.add(stock);
          portdata.add({
            'portfolioName': stock['portfolioName'],
            'stocks': stockFilter(stocks, stock['portfolioName'])
          });

          portfolioCount++;
        } else {
          stocks.add(stock);

          for (Map<String, dynamic> p in portdata) {
            if (p['portfolioName'] == stock['portfolioName']) {
              portdata.remove(p);
              portdata.add({
                'portfolioName': stock['portfolioName'],
                'stocks': stockFilter(stocks, stock['portfolioName'])
              });
            }
          }
        }
      }
    }

    // return portdata;
  }

  List<Map<dynamic, dynamic>> stockFilter(
      List<Map<dynamic, dynamic>> stocks, String portfolioName) {
    List<Map<dynamic, dynamic>> filteredStocks = [];

    for (var s in stocks) {
      if (s['portfolioName'] == portfolioName) {
        filteredStocks.add(s);
      }
    }

    return filteredStocks;
  }
}

class Portfolio {
  final name;
  final List<Map<Stock, dynamic>> stock;

  Portfolio({this.stock, this.name});
}

class Stock {
  final String symbol;
  final String shares;
  final String avgPrice;
  final String portfolioName;

  Stock({this.symbol, this.shares, this.avgPrice, this.portfolioName});
}

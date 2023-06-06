import 'dart:core';
import 'dart:ui';

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

  int colorIndex = -1;

  List<Color> portfolioColors = [
    Color(0xff3A1200),
    Color(0xff000A22),
    Color(0xff1F0014),
    Color(0xff000F00),
    Colors.purple[800]
  ];

  @override
  Widget build(BuildContext context) {
    final userStocks = Provider.of<QuerySnapshot>(context);

    getPortfolios(userStocks);
    print(portfolioCount);


    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        scrollDirection: Axis.vertical,
        childAspectRatio: 2,
        padding: EdgeInsets.all(10),
        children: portdata.map((p) {
          color
          return Container(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(blurRadius: 10, color: Colors.black45)
                    ],
                    color: Color(0xff222222),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: portfolioColors[colorIndex])),
                child: Column(
                  children: [
                    Text(p['portfolioName'],
                        style: TextStyle(fontSize: 20, color: Colors.white54))
                  ],
                )),
          );
        }).toList(),
      ),
    );
  }

  getPortfolios(QuerySnapshot querySnapshot) {
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>();

    for (var doc in querySnapshot.docs) {
      data.add(doc.data());
    }

    for (Map stock in data[0]['portfolio']) {
      if (portdata.isEmpty) {
        portfolioCount++;
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

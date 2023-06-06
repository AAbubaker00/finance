import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/models/offline_data/storeddata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Portfolios extends StatefulWidget {
  @override
  _PortfoliosState createState() => _PortfoliosState();
}

class _PortfoliosState extends State<Portfolios> {
  int portfolioCount;
  String portfolioName;
  List<Map<String, Map>> stocks;
  List<Map<String, dynamic>> portdata = [
    {
      "portfolioName": "ddividends",
      "stocks": [
        {"symbol": "AAPL", "avgPrice": 1212, "portfolioNam:": "Dividends"}
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final userStocks = Provider.of<QuerySnapshot>(context);

    getPortfolios(userStocks);

    return ListView();
  }

  getPortfolios(QuerySnapshot querySnapshot) {
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>();

    for (var doc in querySnapshot.docs) {
      data.add(doc.data());
      print(doc.data());
    }

    int i = 0;
    for (Map stock in data[0]['portfolio']) {
      if (portdata.isEmpty) {
        portdata[i]['portfolioName'] = stock['portfolioName'];
        portdata[i]['stock'][i] = stock;
        i++;

        continue;
      } else {
        Map<String, dynamic> s = portdata.firstWhere(
            (element) => element['portfolioName'] == stock['portfolioName'],
            orElse: () => null);

        if (s == null) {
          print("2");
        }
      }
    }
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

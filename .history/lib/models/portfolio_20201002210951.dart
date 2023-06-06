import 'dart:core';
import 'dart:ffi';

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
  List<Map<dynamic, dynamic>> stocks = [];
  List<Map<String, dynamic>> portdata = [];

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
    }

    int i = 0;
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
          portdata
              .add({'portfolioName': stock['portfolioName'], 'stocks': stocks});
        } else {
          stocks.add(stock);
          List<Map<dynamic, dynamic>> filteredStocks =
              stockFilter(stocks, stock['portfolioName']);
          // print(filteredStocks);

          for (Map<String, dynamic> p in portdata) {
            if (p['portfolioName'] == stock['portfolioName']) {
              portdata.remove(p);
              portdata.add({
                'portfolioName': stock['portfolioName'],
                'stocks': filteredStocks
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
        print(s);
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

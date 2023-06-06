import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<Portfolio> portfolios;

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

    for (Map stock in data[0]['portfolio']) {
      if(portfolios.contains(stock['portfolioName:'])){
        print(yes)
      }
    }
  }
}

class Portfolio {
  final String name;
  final Map<Stock, dynamic> stock;

  Portfolio({this.stock, this.name});
}

class Stock {
  final String symbol;
  final String shares;
  final String avgPrice;
  final String portfolioName;

  Stock({this.symbol, this.shares, this.avgPrice, this.portfolioName});
}

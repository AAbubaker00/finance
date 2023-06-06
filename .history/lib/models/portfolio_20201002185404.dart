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

  @override
  Widget build(BuildContext context) {
    final userStocks = Provider.of<QuerySnapshot>(context);

    getPortfolios(userStocks);

    return ListView();
  }

  getPortfolios(QuerySnapshot querySnapshot) {
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>();

    for (var doc in querySnapshot.docs) {
      final portfolio = data.firstWhere((s) => s['']);
    }
  }
}

// class Portfolio {
//   final Map<Stock, dynamic> stock;

//   Portfolio({this.stock});
// }

class Stock {
  final String symbol;
  final String shares;
  final String avgPrice;
  final String portfolioName;

  Stock({this.symbol, this.shares, this.avgPrice, this.portfolioName});
}

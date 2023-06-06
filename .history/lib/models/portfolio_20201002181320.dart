import 'dart:core';

import 'package:flutter/material.dart';

class Portfolios extends StatefulWidget {
}
  List<Portfolios> portfolios;

  Portfolios(Map<String, dynamic> stocks) {}
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

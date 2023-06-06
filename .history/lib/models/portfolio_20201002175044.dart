import 'dart:core';
clas
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

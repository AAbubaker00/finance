import 'dart:core';

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
  
  Stock({this.symbol, this.shares, this.avgPrice});

  Map stockDataToMap() {
    var stockToMap = new Map();

    stockToMap['symbol'] = symbol;
    stockToMap['shares'] = shares;
    stockToMap['avgPrice'] = avgPrice;

    return stockToMap;
  }
}

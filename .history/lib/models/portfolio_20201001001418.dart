import 'dart:core';

class Portfolio {
  final name;
  final List<Stock> stock;

  Portfolio({this.stock, this.name});
}

class Stock {
  final String symbol;
  final String shares;
  final String avgPrice;

  Stock({this.symbol, this.shares, this.avgPrice});


  Map stockDataToMap() {
    stockToMap['symbol'] = symbol;
    stockToMap['shares'] = shares;
    stockToMap['avgPrice'] = avgPrice;

    return stockToMap;
  }
}

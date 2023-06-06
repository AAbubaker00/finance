import 'dart:core';

class Portfolio {
  final name;
  final List<Map<Stock, > stock;

  Portfolio({this.stock, this.name});

  Map portfolioDataToMap() {
    Map portfolioToMap = new Map();

    portfolioToMap['name'] = name;
    portfolioToMap['stocks'] = stock;
  }

}

class Stock {
  final String symbol;
  final String shares;
  final String avgPrice;

  Stock({this.symbol, this.shares, this.avgPrice});

  Map stockDataToMap() {
    var stockToMap = new Map();

    stockToMap['symbol'] = symbol;
    stockToMap['shares'] = shares;
    stockToMap['avgPrice'] = avgPrice;

    return stockToMap;
  }
}

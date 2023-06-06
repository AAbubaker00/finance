class Portfolio {
  final name;
  final List<Stock> stock;

  Portfolio({this.stock, t});
}

class Stock {
  final String symbol;
  final String shares;
  final String avgPrice;

  Stock({this.symbol, this.shares, this.avgPrice});
}

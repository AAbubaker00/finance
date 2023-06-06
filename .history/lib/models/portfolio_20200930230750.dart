class Portfolio {
  final String name;
  final List<Stocks> stock;

  Portfolio({this.name, t})

  
}

class Stocks {
  final String symbol;
  final String shares;
  final String avgPrice;

  Stocks({this.symbol, this.shares, this.avgPrice});
}

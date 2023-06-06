class Portfolio {
  final String name;
  final List<Stocks> stock;

  

  
}

class Stocks {
  final String symbol;
  final String shares;
  final String avgPrice;

  Stocks({this.symbol, this.shares, this.avgPrice});
}

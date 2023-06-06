class Portfolio {
  final String name;
  final List<Stock> stock;

  Portfolio({this.name, this.stock});

  
}

class Stock {
  final String symbol;
  final String shares;
  final String avgPrice;

  Stock({this.symbol, this.shares, this.avgPrice});
}


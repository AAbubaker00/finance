class Commodity {
  String name;
  String symbol;

  Commodity();

  Commodity.fromMap(Map commodity)
      : name = commodity['name'],
        symbol = commodity['symbol'];

  Map commodityToMap(Commodity commodity) => {
    'name': commodity
  };
}

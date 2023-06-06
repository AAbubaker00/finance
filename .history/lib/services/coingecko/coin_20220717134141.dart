class Coin {
  String id;
  String name;
  String symbol;
  String market_cap_rank;
  String thumb;

  Coin();

  Coin.fromMap(Map coin)
      : id = coin['id'],
        name = coin['name'],
        symbol = coin['symbol'],
        market_cap_rank = coin['market_cap_rank'],
        thumb = coin['thumb'];

  Map cointoMap(Coin coin) => {
    'id': coin.id,
    'name': coin.name,
    'symbol': coin.symbol,
    'market_cap_rank'
  };
}

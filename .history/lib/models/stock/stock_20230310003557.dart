import 'package:Valuid/extensions/stringExt.dart';

class Stock {
  String name;
  String currency;
  String symbol;
  String exchange;
  String fullExchangeName;
  String dividendDate;

  double regularMarketPrice;
  double regularMarketChange;
  double trailingAnnualDividendRate;
  double trailingAnnualDividendYield;

  Stock();

  Stock.fromMap(Map data)
      : name = data.containsKey('longName')
            ? data['longName'].toString().removeStr()
            : data['shortName'].toString().removeStr(), 
            currency = data['currency'],
            symbol = data['symbol'], 
            exchange = data['exchange'],
            fullExchangeName = data['fullExchangeName'],
            dividendDate = data.containsKey(dividendDate) 
            

}

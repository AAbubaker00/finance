import 'package:Valuid/extensions/stringExt.dart';

class Stock {
  String name;
  String currency;
  String symbol;
  String exchange;
  String fullExchangeName;

  double regularMarketPrice;
  double regularMarketChange;

  bool containsDividendDate;
  bool containsTrailingAnnualDividendRate;
  bool trailingAnnualDividendYield;

  Stock();

  Stock.fromMap(Map data)
      : name = data.containsKey('longName')
            ? data['longName'].toString().removeStr()
            : data['shortName'].toString().removeStr(), 
            currency = data['currency'],
            symbol = data['symbol'], 
            exchange = data['exchange'],
            fullExchangeName = data['fullExchangeName'],
            dividendDate = data.containsKey('dividendDate') && data['dividendDate'] != ''? data['dividendDate'] : null, 

            regularMarketPrice = data['regularMarketPrice'], 
            regularMarketChange = data['regularMarketChange'],
            trailingAnnualDividendRate = data[]
            

}

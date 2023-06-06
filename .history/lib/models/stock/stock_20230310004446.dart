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
  bool containsTrailingAnnualDividendYield;

  Stock();

  Stock.fromMap(Map data)
      : name = data.containsKey('longName')
            ? data['longName'].toString().removeStr()
            : data['shortName'].toString().removeStr(), 
            currency = data['currency'],
            symbol = data['symbol'], 
            exchange = data['exchange'],
            fullExchangeName = data['fullExchangeName'],

            regularMarketPrice = data['regularMarketPrice'], 
            regularMarketChange = data['regularMarketChange'],

            containsDividendDate = data.containsKey('dividendDate') && data['dividendDate'] != ''? true : false, 
            containsTrailingAnnualDividendRate = data.containsKey('trailingAnnualDividendRate') && data['trailingAnnualDividendRate'] != ''? true : false:
            containsTra
            

}

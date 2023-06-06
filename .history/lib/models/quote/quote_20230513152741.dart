import 'package:valuid/extensions/stringExt.dart';

class QuoteObject {
  String name = '';
  String exchange = '';
  String symbol = '';
  String currency = '';
  String fullExchangeName = '';

  num regularMarketPrice = 0.0;
  num regularMarketChange = 0.0;
  num regularMarketChangePercent = 0.0;

  num purchasePrice;
  num quantity = 0.0;
  num invested = 0.0;

  num change = 0.0;
  num changePercent = 0.0;
  num value = 0.0;

  bool containsTrailingAnnualDividendRate;
  bool containsTrailingAnnualDividendYield;

  //* company assets

  QuoteObject();

  QuoteObject.fromMap(Map data)
      : name = data.containsKey('longName')
            ? data['longName'].toString().removeStr()
            : data['shortName'].toString().removeStr(),
        currency = data['currency'].toString().capitalizeAll(),
        symbol = data['symbol'],
        exchange = data['exchange'],
        fullExchangeName = data['fullExchangeName'],
        regularMarketPrice = data['regularMarketPrice'] / (data['exchange'] == 'LSE' ? 100 : 1),
        regularMarketChange = data['regularMarketChange'],
        regularMarketChangePercent = data['regularMarketChangePercent'],
        containsTrailingAnnualDividendRate = data.containsKey('trailingAnnualDividendYield') &&
            data['trailingAnnualDividendYield'] != null &&
            data['trailingAnnualDividendYield'] != 0,
        containsTrailingAnnualDividendYield = data.containsKey('trailingAnnualDividendRate') &&
            data['trailingAnnualDividendRate'] != null &&
            data['trailingAnnualDividendRate'] != 0;

  Map quoteToMap(QuoteObject holding) => {
        'symbol': holding.symbol,
        'quantity': holding.quantity,
        'exchange': holding.exchange,
        'purchasePrice': holding.purchasePrice,
      };

  QuoteObject.docFromMap(Map data)
      : symbol = data['symbol'],
        exchange = data['exchange'],
        quantity = data['quantity'],
        purchasePrice = data['purchasePrice'];

  QuoteObject.docWatchlistFromMap(Map data)
      : symbol = data['symbol'],
        exchange = data['exchange'],
        quantity = data['quantity'];

  QuoteObject combineTo(QuoteObject a, QuoteObject b) {
    b.quantity = a.quantity;
    b.purchasePrice = a.purchasePrice;

    return b;
  }

  List<QuoteObject> combineToList(List<QuoteObject> a, List<QuoteObject> b) => List.generate(
      b.length,
      (index) =>
          combineTo(a.firstWhere((aExc) => aExc.symbol == b[index].symbol, orElse: () => null), b[index]));

  List listQuoteToMap(List<QuoteObject> holdings) =>
      List.generate(holdings.length, (index) => quoteToMap(holdings[index]));

  List<QuoteObject> listMapToQuote(List holdings) =>
      List.generate(holdings.length, (index) => QuoteObject.docFromMap(holdings[index]));
}

import 'package:valuid/extensions/stringExt.dart';
import 'package:valuid/services/forex/forex_conversion.dart';

class QuoteObject {
  String name = '';
  String exchange = '';
  String symbol = '';
  String currency = '';

  String industry = '';
  String subIndustry = '';
  String sector = '';

  num regularMarketPrice = 0.0;
  num regularMarketChange = 0.0;
  num regularMarketChangePercent = 0.0;

  num purchasePrice;
  num quantity = 0.0;
  num invested = 0.0;

  num change = 0.0;
  num changePercent = 0.0;
  num value = 0.0;

  bool dividendSupport;

  //* company assets

  QuoteObject();

  QuoteObject.fromMap(var document, {String n, String s, String e})
      : name = n,
        currency = e == null? '' :(e == 'LSE'
            ? 'GBX'
            : ForexConversion().currencySymbols.firstWhere(
                (currency) =>
                    currency['symbol'] ==
                    document.getElementsByClassName('price')[0].children.first.text.replaceRange(
                        1, document.getElementsByClassName('price')[0].children.first.text.length, ''),
                orElse: () => null)['short']),
        symbol = s,
        exchange = e,
        sector = document.getElementsByClassName('m-0 p-0')[1].children[3].children[1].text,
        industry = document.getElementsByClassName('m-0 p-0')[1].children[1].children[1].text, 
        subIndustry = document.getElementsByClassName('m-0 p-0')[1].children[2].children[1].text,
        regularMarketPrice = double.parse(document
            .getElementsByClassName('price')[0]
            .children
            .first
            .text.replaceRange(0,1, '')
            .replaceAll(
                new RegExp(
                  r'[A-Z]',
                ),
                '')),
        regularMarketChange = double.parse(document
          .getElementsByClassName('price')[0]
          .children[1]
          .text
          .replaceRange(0, 1, '')
          .split(' ')
          .first
          .replaceRange(
              document
                  .getElementsByClassName('price')[0]
                  .children[1]
                  .text
                  .replaceRange(0, 1, '')
                  .split(' ')
                  .first
                  .indexOf('('),
              document
                  .getElementsByClassName('price')[0]
                  .children[1]
                  .text
                  .replaceRange(0, 1, '')
                  .split(' ')
                  .first
                  .length,
              '').trim()),
        regularMarketChangePercent = double.parse(document
            .getElementsByClassName('price')[0]
            .children[1]
            .text
            .replaceRange(0, 1, '')
            .split(' ')
            .first
            .replaceRange(
                0,
                document
                    .getElementsByClassName('price')[0]
                    .children[1]
                    .text
                    .replaceRange(0, 1, '')
                    .split(' ')
                    .first
                    .indexOf('('),
                '')
            .replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll('%', '')),
        dividendSupport =
            document.getElementsByClassName('price-data-col col-31')[1].children[1].children[1].text == 'N/A';

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
    print(a.quantity)
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

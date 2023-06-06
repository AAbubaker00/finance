import 'dart:convert';

import 'package:finance/models/yahooQuote.dart';
import 'package:http/http.dart' as http;
import 'package:finance/models/quoteYahoo.dart';
import 'package:finance/models/stocks.dart';

class Services {
  static const String url =
      'https://query1.finance.yahoo.com/v7/finance/quote?symbols=aapl';

  List<YahooQuote> _quote = List<YahooQuote>();

  Future<List<QuoteYahoo>> getQuote() async {
    try {
      final response = await http.get(url);
      var quote = List<QuoteYahoo>();

      if (response.statusCode == 200) {
        var quotesJSON = json.decode(response.body);
        for (var quoteJson in quotesJSON) {
          _quote.add(YahooQuote.fromJson(quoteJson));
        }
      }

      return _q
    } catch (e) {
      print("nothing2");
      return null;
    }
  }

  static Stocks parseStockQuote(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<QuoteYahoo> quotes =
        parsed.map<QuoteYahoo>((json) => QuoteYahoo.fromJson(json)).toList();
    Stocks s = Stocks();
    s.StockName = quotes;
    return s;
  }
}

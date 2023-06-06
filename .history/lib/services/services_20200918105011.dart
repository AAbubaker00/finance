import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:finance/models/quoteYahoo.dart';
import 'package:finance/models/stocks.dart';

class Services {
  static const String url =
      'https://query1.finance.yahoo.com/v7/finance/quote?symbols=aapl';

  static Future<Stocks> getQuote() async {
    try {
      final response = await http.get(url);

      if (1 == response.statusCode) {
        return parseStockQuote(response.body);
      } else {
        print(response.body);
        return Stocks();
      }
    } catch (e) {
      print("nothing2");
      return Stocks();
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

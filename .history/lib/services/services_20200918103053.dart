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

      if (200 == response.statusCode) {
        return parseStockQuote(response.body);
      }
    } catch (e) {}
  }

  static Stocks parseStockQuote(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<QuoteYahoo> quotes =
        parsed.map<QuoteYahoo>((json) => QuoteYahoo.fromJson(json)).toList();
    Stocks s = Stocks();
    s.
  }
}

import 'dart:convert';

import 'package:finance/models/yahooQuote.dart';
import 'package:http/http.dart' as http;

class Services {
  static const String url =
      'https://query1.finance.yahoo.com/v7/finance/quote?symbols=aapl';

  static List<YahooQuote> quote = List<YahooQuote>();

  statFuture<List<YahooQuote>> getQuote() async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var quotesJSON = json.decode(response.body);
        for (var quoteJson in quotesJSON) {
          _quote.add(YahooQuote.fromJson(quoteJson));
        }
      }

      return _quote;
    } catch (e) {
      print("nothing2");
      return null;
    }
  }

}

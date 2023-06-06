import 'dart:convert';
import 'package:finance/models/yahoo/yahoo_result.dart';
import 'package:http/http.dart' as http;

class Services {
  static const String url =
      'https://query1.finance.yahoo.com/v7/finance/quote?symbols=aapl';

  static List<YahooQuoteResult> quote = List<YahooQuoteResult>();

  static Future<List<YahooQuoteResult>> getYahooQuote() async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var responseJson = await json.decode(response.body);
        responseJson = responseJson["quoteResponse"]["result"];

        for (var q in responseJson) {
          quote.add(YahooQuoteResult.fromJson(q));
        }

        print()
        return quote;
      }

      return List<YahooQuoteResult>();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

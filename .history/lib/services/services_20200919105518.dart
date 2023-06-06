import 'dart:convert';

import 'package:finance/models/yahoo/yahoo_result.dart';
import 'package:http/http.dart' as http;

class Services {
  static const String url =
      'https://query1.finance.yahoo.com/v7/finance/quote?symbols=aapl';

  static List<YahooQuoteResult> QuoteResult = List<YahooQuoteResult>();

  static Future<List<YahooQuoteResult>> getYahooQuoteResult() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return parseQuoteResult(response.body);
        // var responseJSON = json.decode(response.body);

        // print("nothing1");
        // var quotesJSON = json.decode(response.body);
        // for (var quoteJson in quotesJSON) {
        //   quote.add(YahooQuote.fromJson(quoteJson));
        //   print(quote[0].displayName);
        // }
      }
    } catch (e) {
      //print("nothing2");
      return null;
    }
  }

  static YahooQuoteResult parseQuoteResult(String response)
}

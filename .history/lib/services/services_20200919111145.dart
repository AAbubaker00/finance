import 'dart:convert';

import 'package:finance/models/yahoo/yahoo_quote.dart';
import 'package:finance/models/yahoo/yahoo_result.dart';
import 'package:http/http.dart' as http;

class Services {
  static const String url =
      'https://query1.finance.yahoo.com/v7/finance/quote?symbols=aapl';

  static List<YahooQuote> yQuote = List<YahooQuote>();

  static Future<List<YahooQuoteResult>> getYahooQuote() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var reponseJSON = json.decode(response.body);

        for (var quote in reponseJSON) {
          yQuote.add(YahooQuote.fromJson(quote));
          print(yQuote[0].);
        }
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
}

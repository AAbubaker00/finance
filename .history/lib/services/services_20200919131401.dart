import 'dart:convert';

import 'package:finance/models/yahoo/yahoo_quote.dart';
import 'package:finance/models/yahoo/yahoo_response.dart';
import 'package:finance/models/yahoo/yahoo_result.dart';
import 'package:http/http.dart' as http;

class Services {
  static const String url =
      'https://query1.finance.yahoo.com/v7/finance/quote?symbols=aapl';

  var quote = List<YahooQuoteResult>();

  static Future<List<YahooQuoteResult>> getYahooQuote() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var reponseJSON = await json.decode(response.body);
        reponseJSON = respon
        for

        //print(reponseJSON);

        //yQuote.add(reponseJSON);
        //print(yQuote[0].yahooQuoteResponse.result[0]);
        print("1");
        // var responseJSON = json.decode(response.body);

        // print("nothing1");
        // var quotesJSON = json.decode(response.body);
        // for (var quoteJson in quotesJSON) {
        //   quote.add(YahooQuote.fromJson(quoteJson));
        //   print(quote[0].displayName);
        // }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

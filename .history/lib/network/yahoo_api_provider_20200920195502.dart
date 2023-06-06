import 'dart:convert';
import 'package:finance/models/yahoo/yahoo_result.dart';
import 'package:http/http.dart' as http;

class YahooApiService {
  static String _sEndPoint =
      'https://query1.finance.yahoo.com/v7/finance/quote?symbols=';
  static String _sQuote;

  static List<YahooQuoteResult> quote = List<YahooQuoteResult>();

  static Future<List<YahooQuoteResult>> getYahooQuote({String symbol, String exchange}) async {
    
    switch(exchange){
      if 
    }
    _sEndPoint = _sEndPoint + "$_sQuote";

    try {
      final response = await http.get(_sEndPoint);

      if (response.statusCode == 200) {
        var responseJson = await json.decode(response.body);
        responseJson = responseJson["quoteResponse"]["result"];

        for (var q in responseJson) {
          quote.add(YahooQuoteResult.fromJson(q));
        }

        return quote;
      }

      return List<YahooQuoteResult>();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

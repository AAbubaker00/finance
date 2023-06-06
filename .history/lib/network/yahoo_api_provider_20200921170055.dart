import 'dart:convert';
import 'package:finance/models/yahoo/yahoo_quote_result.dart';
import 'package:http/http.dart' as http;

class YahooApiService {
  static String _sEndPoint =
      'https://query1.finance.yahoo.com/v7/finance/quote?symbols=';
  static String _sQuote;

  static List<YahooQuoteResult> quote = List<YahooQuoteResult>();

  static Future<List<YahooQuoteResult>> getYahooQuote(
      {String symbol, String exchange}) async {
    switch (exchange) {
      case "LSE":
        {
          symbol = symbol + ".L";
          _sQuote = symbol;
        }
        break;
    }

    _sEndPoint = _sEndPoint + "$_sQuote";

    try {
      http.Response response = await http.get(_sEndPoint);

      print(_sEndPoint);

      if (response.statusCode == 200) {
        var responseJson = await json.decode(response.body);
        responseJson = responseJson["quoteResponse"]["result"];

        for (var q in responseJson) {
          quote.add(YahooQuoteResult.fromJson(q));
          //print(quote[0].shortName);
        }

        return quote;
      }

      print("done");
      return List<YahooQuoteResult>();
    } catch (e) {
      print("aa");
      return null;
    }
  }


  stat
}

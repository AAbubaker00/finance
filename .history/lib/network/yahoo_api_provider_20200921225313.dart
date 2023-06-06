import 'dart:convert';
import 'package:finance/models/yahoo/yahoo_quote_result.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart' as csv;

class YahooApiService {
  static String _sQuoteEndPoint =
      'https://query1.finance.yahoo.com/v7/finance/quote?symbols=';

  static String _sDividendEndPoint =
      "https://query1.finance.yahoo.com/v7/finance/download/";

  static String _sDateEndPoint =
      "?period1=1505952000&period2=4125168000&interval=1d&events=div";

  static String _sAssetsEndPoint =
      "https://query1.finance.yahoo.com/v10/finance/quoteSummary/";

  static String _sFixedAssetsEndPoint = "?modules=assetProfile";

  static String _sQuote;

  static List<YahooQuoteResult> quote = List<YahooQuoteResult>();

  static Future<List<YahooQuoteResult>> getYahooQuote(
      {String symbol, String exchange}) async {
    exchangeCheck(symbol, exchange);

    _sQuoteEndPoint = _sQuoteEndPoint + "$_sQuote";

    try {
      http.Response response = await http.get(_sQuoteEndPoint);

      if (response.statusCode == 200) {
        var responseJson = await json.decode(response.body);
        responseJson = responseJson["quoteResponse"]["result"];

        for (var q in responseJson) {
          quote.add(YahooQuoteResult.fromJson(q));
          //print(quote[0].shortName);
        }

        return quote;
      }
      return List<YahooQuoteResult>();
    } catch (e) {
      return List<YahooQuoteResult>();
    }
  }

  static void getYahooCompanyAssets(String symbol, String exchange) async {
    exchangeCheck(symbol, exchange);

    _sAssetsEndPoint = _sAssetsEndPoint + _sQuote + _sFixedAssetsEndPoint;

    try {
      http.Response response = await http.get(_sAssetsEndPoint);

      if(response.statusCode == 200){
        var responseJson = j
        response = response["quoteResponse"]["result"][]; 
      }


    } on Exception catch (e) {
          // TODO
    }
  }

  void getYahooDividends(String symbol, String exchange) async {
    _sDividendEndPoint = _sDividendEndPoint + _sQuote + _sDateEndPoint;

    try {
      http.Response response = await http.get(_sDividendEndPoint);

      if (response.statusCode == 200) {
        List<List<dynamic>> dividendData =
            csv.CsvToListConverter().convert(response.body);
      } else {}
    } catch (e) {}
  }

  static void exchangeCheck(String symbol, String exchange) {
    switch (exchange) {
      case "LSE":
        {
          symbol = symbol + ".L";
          _sQuote = symbol;
        }
        break;
    }
  }
}

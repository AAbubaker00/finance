import 'package:finance/models/yahoo/yahoo_result.dart';

class YahooQuoteResponse {
  ListYahooQuoteResult result;
  String error;

  YahooQuoteResponse({this.result, this.error});

  YahooQuoteResponse.fromJson(Map<String, dynamic> parsedJSON)
      : error = parsedJSON['error'],
        result = parsedJSON['property'];
}

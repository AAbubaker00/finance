import 'package:finance/models/yahoo/yahresult.dart';

class YahooQuoteResponse {
  YahooQuoteResult result;
  String error;

  YahooQuoteResponse({this.result, this.error});

  YahooQuoteResponse.fromJson(Map<String, dynamic> parsedJSON)
      : error = parsedJSON['error'],
        result = parsedJSON['property'];
}

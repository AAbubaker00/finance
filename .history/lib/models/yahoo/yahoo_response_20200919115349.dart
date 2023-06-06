import 'package:finance/models/yahoo/yahoo_quote.dart';
import 'package:finance/models/yahoo/yahoo_result.dart';

class YahooQuoteResponse {
  List<YahooQuoteResult> result;
  String error;

  YahooQuoteResponse({this.result, this.error});

  factory YahooQuoteResponse.fromJson(Map<String, dynamic> parsedJSON) {
    var list = parsedJSON['result'] as List;

    List<YahooQuoteResult> resultList = list.map();

    return YahooQuoteResponse(result: resultList, error: parsedJSON['error']);
  }
}

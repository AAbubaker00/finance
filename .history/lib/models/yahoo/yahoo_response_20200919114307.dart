import 'package:finance/models/yahoo/yahoo_result.dart';

class YahooQuoteResponse {
  List<YahooQuoteResult> result;
  String error;

  YahooQuoteResponse({this.result, this.error});

  YahooQuoteResponse.fromJson(Map<String, dynamic> parsedJSON) {
    var list = parsedJSON['result'] as List;

    List<Yah
  }
}

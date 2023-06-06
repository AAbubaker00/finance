import 'package:finance/models/yahoo/yahoo_response.dart';

class YahooQuote {
  YahooQuoteResponse yahooQuoteResponse;

  YahooQuote({this.yahooQuoteResponse});

  factory YahooQuote.fromJson(Map<String, dynamic> parsedJSON)
      return YahooQuote(yahooQuoteResponseparsedJSON['quoteResponse'];
}

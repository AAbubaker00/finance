import 'package:finance/models/yahoo/yahoo_response.dart';

class YahooQuote {
  YahooQuoteResponse yahooQuoteResponse;

  YahooQuote({this.yahooQuoteResponse});

  YahooQuote.fromJson(Map<String, dynamic> parsedJSON)
      : yahooQuoteResponse = parsedJSON['quoteResponse'];
}

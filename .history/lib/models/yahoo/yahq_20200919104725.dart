import 'package:finance/models/yahoo/yahresponse.dart';

class YahooQuote {
  YahooQuoteResponse yahooQuoteResponse;

  YahooQuote({this.yahooQuoteResponse});

  YahooQuote.fromJson(Map<String, dynamic> parsedJSON)
      : yahooQuoteResponse = parsedJSON['quoteResponse'];
}

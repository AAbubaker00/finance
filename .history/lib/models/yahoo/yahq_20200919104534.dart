// ignore: camel_case_types

class YahooQuote {
  YahooQuoteResponse yahooQuoteResponse;

  YahooQuote({this.yahooQuoteResponse});

  YahooQuote.fromJson(Map<String, dynamic> parsedJSON)
      : yahooQuoteResponse = parsedJSON['quoteResponse'];
}


// ignore: camel_case_types
class YahooQuote {
  YahooQuoteResponse yahooQuoteResponse;

  YahooQuote({this.yahooQuoteResponse});

  YahooQuote.fromJson(Map<String, dynamic> parsedJSON)
      : yahooQuoteResponse = parsedJSON['quoteResponse'];
}

class YahooQuoteResponse {
  YahooQuoteResult result;
  String error;

  YahooQuoteResponse({this.result, this.error});

  YahooQuoteResponse.fromJson(Map<String, dynamic> parsedJSON)
      : error = parsedJSON['error'],
        result = parsedJSON['property'];
}

// ignore: camel_case_types
class YahooQuoteResult {
  String currency;
  String displayName;
  String exchange;
  String exchangeTimezoneName;
  String exchangeTimezoneShortName;
  String fiftyTwoWeekRange;
  String financialCurrency;
  String fullExchangeName;
  String language;
  String longName;
  String market;
  String marketState;
  String messageBoardId;
  String quoteSourceName;
  String quoteType;
  String region;
  String regularMarketDayRange;
  String shortName;
  String symbol;

  bool esgPopulated;
  bool tradeable;
  bool triggerable;

  num ask;
  num askSize;
  num averageDailyVolume10Day;
  num averageDailyVolume3Month;
  num bid;
  num bidSize;
  num bookValue;
  num dividendDate;
  num earningsTimestamp;
  num earningsTimestampEnd;
  num earningsTimestampStart;
  num epsCurrentYear;
  num epsForward;
  num epsTrailingTwelveMonths;
  num exchangeDataDelayedBy;
  num fiftyDayAverage;
  num fiftyDayAverageChange;
  num fiftyDayAverageChangePercent;
  num fiftyTwoWeekHigh;
  num fiftyTwoWeekHighChange;
  num fiftyTwoWeekHighChangePercent;
  num fiftyTwoWeekLow;
  num fiftyTwoWeekLowChange;
  num fiftyTwoWeekLowChangePercent;
  num firstTradeDateMilliseconds;
  num forwardPE;
  num gmtOffSetMilliseconds;
  num marketCap;
  num priceEpsCurrentYear;
  num priceHint;
  num priceToBook;
  num regularMarketChange;
  num regularMarketChangePercent;
  num regularMarketDayHigh;
  num regularMarketDayLow;
  num regularMarketOpen;
  num regularMarketPreviousClose;
  num regularMarketPrice;
  num regularMarketTime;
  num regularMarketVolume;
  num sharesOutstanding;
  num sourceInterval;
  num trailingAnnualDividendRate;
  num trailingAnnualDividendYield;
  num trailingPE;
  num twoHundredDayAverage;
  num twoHundredDayAverageChange;
  num twoHundredDayAverageChangePercent;

  YahooQuoteResult({
    this.twoHundredDayAverageChangePercent,
    this.fiftyTwoWeekHighChangePercent,
    this.fiftyTwoWeekLowChangePercent,
    this.fiftyDayAverageChangePercent,
    this.trailingAnnualDividendYield,
    this.regularMarketChangePercent,
    this.regularMarketPreviousClose,
    this.trailingAnnualDividendRate,
    this.twoHundredDayAverageChange,
    this.firstTradeDateMilliseconds,
    this.exchangeTimezoneShortName,
    this.averageDailyVolume3Month,
    this.averageDailyVolume10Day,
    this.epsTrailingTwelveMonths,
    this.fiftyTwoWeekHighChange,
    this.earningsTimestampStart,
    this.regularMarketDayRange,
    this.fiftyTwoWeekLowChange,
    this.fiftyDayAverageChange,
    this.exchangeDataDelayedBy,
    this.gmtOffSetMilliseconds,
    this.regularMarketDayHigh,
    this.earningsTimestampEnd,
    this.twoHundredDayAverage,
    this.exchangeTimezoneName,
    this.regularMarketChange,
    this.regularMarketDayLow,
    this.regularMarketVolume,
    this.priceEpsCurrentYear,
    this.regularMarketPrice,
    this.regularMarketTime,
    this.financialCurrency,
    this.regularMarketOpen,
    this.fiftyTwoWeekRange,
    this.earningsTimestamp,
    this.sharesOutstanding,
    this.fullExchangeName,
    this.fiftyTwoWeekHigh,
    this.quoteSourceName,
    this.fiftyTwoWeekLow,
    this.fiftyDayAverage,
    this.epsCurrentYear,
    this.sourceInterval,
    this.messageBoardId,
    this.dividendDate,
    this.esgPopulated,
    this.triggerable,
    this.priceToBook,
    this.marketState,
    this.displayName,
    this.trailingPE,
    this.epsForward,
    this.quoteType,
    this.bookValue,
    this.marketCap,
    this.forwardPE,
    this.shortName,
    this.tradeable,
    this.priceHint,
    this.language,
    this.currency,
    this.exchange,
    this.longName,
    this.bidSize,
    this.askSize,
    this.region,
    this.market,
    this.symbol,
    this.bid,
    this.ask,
  });

  YahooQuoteResult.fromJson(Map<String, dynamic> quoteJsonData)
      : language = quoteJsonData['language'],
        region = quoteJsonData['region'],
        quoteType = quoteJsonData['quoteType'],
        quoteSourceName = quoteJsonData['quoteSourceName'],
        triggerable = quoteJsonData['triggerable'],
        currency = quoteJsonData['currency'],
        regularMarketChange = quoteJsonData['regularMarketChange'],
        regularMarketChangePercent =
            quoteJsonData['regularMarketChangePercent'],
        regularMarketTime = quoteJsonData['regularMarketTime'],
        regularMarketPrice = quoteJsonData['regularMarketPrice'],
        regularMarketDayHigh = quoteJsonData['regularMarketDayHigh'],
        regularMarketDayRange = quoteJsonData['regularMarketDayRange'],
        regularMarketDayLow = quoteJsonData['regularMarketDayLow'],
        regularMarketVolume = quoteJsonData['regularMarketVolume'],
        regularMarketPreviousClose =
            quoteJsonData['regularMarketPreviousClose'],
        bid = quoteJsonData['bid'],
        ask = quoteJsonData['ask'],
        bidSize = quoteJsonData['bidSize'],
        askSize = quoteJsonData['askSize'],
        fullExchangeName = quoteJsonData['fullExchangeName'],
        financialCurrency = quoteJsonData['financialCurrency'],
        regularMarketOpen = quoteJsonData['regularMarketOpen'],
        averageDailyVolume3Month = quoteJsonData['averageDailyVolume3Month'],
        averageDailyVolume10Day = quoteJsonData['averageDailyVolume10Day'],
        fiftyTwoWeekLowChange = quoteJsonData['fiftyTwoWeekLowChange'],
        fiftyTwoWeekLowChangePercent =
            quoteJsonData['fiftyTwoWeekLowChangePercent'],
        fiftyTwoWeekRange = quoteJsonData['fiftyTwoWeekRange'],
        fiftyTwoWeekHighChange = quoteJsonData['fiftyTwoWeekHighChange'],
        fiftyTwoWeekHighChangePercent =
            quoteJsonData['fiftyTwoWeekHighChangePercent'],
        fiftyTwoWeekLow = quoteJsonData['fiftyTwoWeekLow'],
        fiftyTwoWeekHigh = quoteJsonData['fiftyTwoWeekHigh'],
        dividendDate = quoteJsonData['dividendDate'],
        earningsTimestamp = quoteJsonData['earningsTimestamp'],
        earningsTimestampStart = quoteJsonData['earningsTimestampStart'],
        earningsTimestampEnd = quoteJsonData['earningsTimestampEnd'],
        trailingAnnualDividendRate =
            quoteJsonData['trailingAnnualDividendRate'],
        trailingPE = quoteJsonData['trailingPE'],
        trailingAnnualDividendYield =
            quoteJsonData['trailingAnnualDividendYield'],
        epsTrailingTwelveMonths = quoteJsonData['epsTrailingTwelveMonths'],
        epsForward = quoteJsonData['epsForward'],
        epsCurrentYear = quoteJsonData['epsCurrentYear'],
        priceEpsCurrentYear = quoteJsonData['priceEpsCurrentYear'],
        sharesOutstanding = quoteJsonData['sharesOutstanding'],
        bookValue = quoteJsonData['bookValue'],
        fiftyDayAverage = quoteJsonData['fiftyDayAverage'],
        fiftyDayAverageChange = quoteJsonData['fiftyDayAverageChange'],
        fiftyDayAverageChangePercent =
            quoteJsonData['fiftyDayAverageChangePercent'],
        twoHundredDayAverage = quoteJsonData['twoHundredDayAverage'],
        twoHundredDayAverageChange =
            quoteJsonData['twoHundredDayAverageChange'],
        twoHundredDayAverageChangePercent =
            quoteJsonData['twoHundredDayAverageChangePercent'],
        marketCap = quoteJsonData['marketCap'],
        forwardPE = quoteJsonData['forwardPE'],
        priceToBook = quoteJsonData['priceToBook'],
        sourceInterval = quoteJsonData['sourceInterval'],
        exchangeDataDelayedBy = quoteJsonData['exchangeDataDelayedBy'],
        marketState = quoteJsonData['marketState'],
        gmtOffSetMilliseconds = quoteJsonData['gmtOffSetMilliseconds'],
        esgPopulated = quoteJsonData['esgPopulated'],
        exchange = quoteJsonData['exchange'],
        shortName = quoteJsonData['shortName'],
        longName = quoteJsonData['longName'],
        messageBoardId = quoteJsonData['messageBoardId'],
        exchangeTimezoneName = quoteJsonData['exchangeTimezoneName'],
        market = quoteJsonData['market'],
        tradeable = quoteJsonData['tradeable'],
        exchangeTimezoneShortName = quoteJsonData['exchangeTimezoneShortName'],
        firstTradeDateMilliseconds =
            quoteJsonData['firstTradeDateMilliseconds'],
        priceHint = quoteJsonData['priceHint'],
        displayName = quoteJsonData['displayName'],
        symbol = quoteJsonData['symbol'];
}

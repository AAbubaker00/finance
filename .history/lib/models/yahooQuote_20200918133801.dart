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
        twoHundredDayAverageChangePercent =
        twoHundredDayAverageChange =
        twoHundredDayAverage = quoteJsonData['twoHundredDayAverage'],
        triggerable = quoteJsonData['triggerable'],
        trailingPE = quoteJsonData['trailingPE'],
        trailingAnnualDividendYield =
        trailingAnnualDividendRate =
        tradeable = quoteJsonData['tradeable'],
        symbol = quoteJsonData['symbol'];
        sourceInterval = quoteJsonData['sourceInterval'],
        shortName = quoteJsonData['shortName'],
        sharesOutstanding = quoteJsonData['sharesOutstanding'],
        regularMarketVolume = quoteJsonData['regularMarketVolume'],
        regularMarketTime = quoteJsonData['regularMarketTime'],
        regularMarketPrice = quoteJsonData['regularMarketPrice'],
        regularMarketPreviousClose =
        regularMarketOpen = quoteJsonData['regularMarketOpen'],
        regularMarketDayRange = quoteJsonData['regularMarketDayRange'],
        regularMarketDayLow = quoteJsonData['regularMarketDayLow'],
        regularMarketDayHigh = quoteJsonData['regularMarketDayHigh'],
        regularMarketChangePercent =
        regularMarketChange = quoteJsonData['regularMarketChange'],
        region = quoteJsonData['region'],
        quoteType = quoteJsonData['quoteType'],
        quoteSourceName = quoteJsonData['quoteSourceName'],
        priceToBook = quoteJsonData['priceToBook'],
        priceHint = quoteJsonData['priceHint'],
        priceEpsCurrentYear = quoteJsonData['priceEpsCurrentYear'],
        messageBoardId = quoteJsonData['messageBoardId'],
        marketState = quoteJsonData['marketState'],
        marketCap = quoteJsonData['marketCap'],
        market = quoteJsonData['market'],
        longName = quoteJsonData['longName'],
        gmtOffSetMilliseconds = quoteJsonData['gmtOffSetMilliseconds'],
        fullExchangeName = quoteJsonData['fullExchangeName'],
        forwardPE = quoteJsonData['forwardPE'],
        firstTradeDateMilliseconds =
        financialCurrency = quoteJsonData['financialCurrency'],
        fiftyTwoWeekRange = quoteJsonData['fiftyTwoWeekRange'],
        fiftyTwoWeekLowChangePercent =
        fiftyTwoWeekLowChange = quoteJsonData['fiftyTwoWeekLowChange'],
        fiftyTwoWeekLow = quoteJsonData['fiftyTwoWeekLow'],
        fiftyTwoWeekHighChangePercent =
        fiftyTwoWeekHighChange = quoteJsonData['fiftyTwoWeekHighChange'],
        fiftyTwoWeekHigh = quoteJsonData['fiftyTwoWeekHigh'],
        fiftyDayAverageChangePercent =
        fiftyDayAverageChange = quoteJsonData['fiftyDayAverageChange'],
        fiftyDayAverage = quoteJsonData['fiftyDayAverage'],
        exchangeTimezoneShortName = quoteJsonData['exchangeTimezoneShortName'],
        exchangeTimezoneName = quoteJsonData['exchangeTimezoneName'],
        exchangeDataDelayedBy = quoteJsonData['exchangeDataDelayedBy'],
        exchange = quoteJsonData['exchange'],
        esgPopulated = quoteJsonData['esgPopulated'],
        epsTrailingTwelveMonths = quoteJsonData['epsTrailingTwelveMonths'],
        epsForward = quoteJsonData['epsForward'],
        epsCurrentYear = quoteJsonData['epsCurrentYear'],
        earningsTimestampStart = quoteJsonData['earningsTimestampStart'],
        earningsTimestampEnd = quoteJsonData['earningsTimestampEnd'],
        earningsTimestamp = quoteJsonData['earningsTimestamp'],
        dividendDate = quoteJsonData['dividendDate'],
        displayName = quoteJsonData['displayName'],
        currency = quoteJsonData['currency'],
        bookValue = quoteJsonData['bookValue'],
        bidSize = quoteJsonData['bidSize'],
        bid = quoteJsonData['bid'],
        averageDailyVolume3Month = quoteJsonData['averageDailyVolume3Month'],
        averageDailyVolume10Day = quoteJsonData['averageDailyVolume10Day'],
        askSize = quoteJsonData['askSize'],
        ask = quoteJsonData['ask'],
            quoteJsonData['twoHundredDayAverageChangePercent'],
            quoteJsonData['twoHundredDayAverageChange'],
            quoteJsonData['trailingAnnualDividendYield'],
            quoteJsonData['trailingAnnualDividendRate'],
            quoteJsonData['regularMarketPreviousClose'],
            quoteJsonData['regularMarketChangePercent'],
            quoteJsonData['firstTradeDateMilliseconds'],
            quoteJsonData['fiftyTwoWeekLowChangePercent'],
            quoteJsonData['fiftyTwoWeekHighChangePercent'],
            quoteJsonData['fiftyDayAverageChangePercent'],
}

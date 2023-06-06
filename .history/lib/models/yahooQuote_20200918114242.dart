class YahooQuote{
      String language;
    String region;
    String quoteType;
    String quoteSourceName;
    bool triggerable;
    String currency;
    num regularMarketChange;
    num regularMarketChangePercent;
    num regularMarketTime;
    num regularMarketPrice;
    num regularMarketDayHigh;
    String regularMarketDayRange;
    num regularMarketDayLow;
    num regularMarketVolume;
    num regularMarketPreviousClose;
    num bid;
    num ask;
    num bidSize;
    num askSize;
    String fullExchangeName;
    String financialCurrency;
    num regularMarketOpen;
    num averageDailyVolume3Month;
    num averageDailyVolume10Day;
    num fiftyTwoWeekLowChange;
    num fiftyTwoWeekLowChangePercent;
    String fiftyTwoWeekRange;
    num fiftyTwoWeekHighChange;
    num fiftyTwoWeekHighChangePercent;
    num fiftyTwoWeekLow;
    num fiftyTwoWeekHigh;
    num dividendDate;
    num earningsTimestamp;
    num earningsTimestampStart;
    num earningsTimestampEnd;
    num trailingAnnualDividendRate;
    num trailingPE;
    num trailingAnnualDividendYield;
    num epsTrailingTwelveMonths;
    num epsForward;
    num epsCurrentYear;
    num priceEpsCurrentYear;
    num sharesOutstanding;
    num bookValue;
    num fiftyDayAverage;
    num fiftyDayAverageChange;
    num fiftyDayAverageChangePercent;
    num twoHundredDayAverage;
    num twoHundredDayAverageChange;
    num twoHundredDayAverageChangePercent;
    num marketCap;
    num forwardPE;
    num priceToBook;
    num sourceInterval;
    num exchangeDataDelayedBy;
    String marketState;
    num gmtOffSetMilliseconds;
    bool esgPopulated;
    String exchange;
    String shortName;
    String longName;
    String messageBoardId;
    String exchangeTimezoneName;
    String market;
    bool tradeable;
    String exchangeTimezoneShortName;
    num firstTradeDateMilliseconds;
    num priceHint;
    String displayName;
    String symbol;     
  


    YahooQuote(){language;
      this.region;
      this.quoteType;
      this.quoteSourceName;
      this.triggerable;
      this.currency;
      this.regularMarketChange;
      this.regularMarketChangePercent;
      this.regularMarketTime;
      this.regularMarketPrice;
      this.regularMarketDayHigh;
      this.regularMarketDayRange;
      this.regularMarketDayLow;
      this.regularMarketVolume;
      this.regularMarketPreviousClose;
      this.bid;
      this.ask;
      this.bidSize;
      this.askSize;
      this.fullExchangeName;
      this.financialCurrency;
      this.regularMarketOpen;
      this.averageDailyVolume3Month;
      this.averageDailyVolume10Day;
      this.fiftyTwoWeekLowChange;
      this.fiftyTwoWeekLowChangePercent;
      this.fiftyTwoWeekRange;
      this.fiftyTwoWeekHighChange;
      this.fiftyTwoWeekHighChangePercent;
      this.fiftyTwoWeekLow;
      this.fiftyTwoWeekHigh;
      this.dividendDate;
      this.earningsTimestamp;
      this.earningsTimestampStart;
      this.earningsTimestampEnd;
      this.trailingAnnualDividendRate;
      this.trailingPE;
      this.trailingAnnualDividendYield;
      this.epsTrailingTwelveMonths;
      this.epsForward;
      this.epsCurrentYear;
      this.priceEpsCurrentYear;
      this.sharesOutstanding;
      this.bookValue;
      this.fiftyDayAverage;
      this.fiftyDayAverageChange;
      this.fiftyDayAverageChangePercent;
      this.twoHundredDayAverage;
      this.twoHundredDayAverageChange;
      this.twoHundredDayAverageChangePercent;
      this.marketCap;
      this.forwardPE;
      this.priceToBook;
      this.sourceInterval;
      this.exchangeDataDelayedBy;
      this.marketState;
      this.gmtOffSetMilliseconds;
      this.esgPopulated;
      this.exchange;
      this.shortName;
      this.longName;
      this.messageBoardId;
      this.exchangeTimezoneName;
      this.market;
      this.tradeable;
      this.exchangeTimezoneShortName;
      this.firstTradeDateMilliseconds;
      this.priceHint;
      this.displayName;
      this.symbol;
    }

    YahooQuote.fromJson(Map quoteJsonData)
    :language = json['language'] ,
    region = json['region'] ,
    quoteType = json['quoteType'] ,
    quoteSourceName = json['quoteSourceName'] ,
    triggerable = json['triggerable'] ,
    currency = json['currency'] ,
    regularMarketChange = json['regularMarketChange'] ,
    regularMarketChangePercent = json['regularMarketChangePercent'] ,
    regularMarketTime = json['regularMarketTime'] ,
    regularMarketPrice = json['regularMarketPrice'] ,
    regularMarketDayHigh = json['regularMarketDayHigh'] ,
    regularMarketDayRange = json['regularMarketDayRange'] ,
    regularMarketDayLow = json['regularMarketDayLow'] ,
    regularMarketVolume = json['regularMarketVolume'] ,
    regularMarketPreviousClose = json['regularMarketPreviousClose'] ,
    bid = json['bid'] ,
    ask = json['ask'] ,
    bidSize = json['bidSize'] ,
    askSize = json['askSize'] ,
    fullExchangeName = json['fullExchangeName'] ,
    financialCurrency = json['financialCurrency'] ,
    regularMarketOpen = json['regularMarketOpen'] ,
    averageDailyVolume3Month = json['averageDailyVolume3Month'] ,
    averageDailyVolume10Day = json['averageDailyVolume10Day'] ,
    fiftyTwoWeekLowChange = json['fiftyTwoWeekLowChange'] ,
    fiftyTwoWeekLowChangePercent = json['fiftyTwoWeekLowChangePercent'] ,
    fiftyTwoWeekRange = json['fiftyTwoWeekRange'] ,
    fiftyTwoWeekHighChange = json['fiftyTwoWeekHighChange'] ,
    fiftyTwoWeekHighChangePercent =
        json['fiftyTwoWeekHighChangePercent'] ,
    fiftyTwoWeekLow = json['fiftyTwoWeekLow'] ,
    fiftyTwoWeekHigh = json['fiftyTwoWeekHigh'] ,
    dividendDate = json['dividendDate'] ,
    earningsTimestamp = json['earningsTimestamp'] ,
    earningsTimestampStart = json['earningsTimestampStart'] ,
    earningsTimestampEnd = json['earningsTimestampEnd'] ,
    trailingAnnualDividendRate = json['trailingAnnualDividendRate'] ,
    trailingPE = json['trailingPE'] ,
    trailingAnnualDividendYield = json['trailingAnnualDividendYield'] ,
    epsTrailingTwelveMonths = json['epsTrailingTwelveMonths'] ,
    epsForward = json['epsForward'] ,
    epsCurrentYear = json['epsCurrentYear'] ,
    priceEpsCurrentYear = json['priceEpsCurrentYear'] ,
    sharesOutstanding = json['sharesOutstanding'] ,
    bookValue = json['bookValue'] ,
    fiftyDayAverage = json['fiftyDayAverage'] ,
    fiftyDayAverageChange = json['fiftyDayAverageChange'] ,
    fiftyDayAverageChangePercent = json['fiftyDayAverageChangePercent'] ,
    twoHundredDayAverage = json['twoHundredDayAverage'] ,
    twoHundredDayAverageChange = json['twoHundredDayAverageChange'] ,
    twoHundredDayAverageChangePercent =
        json['twoHundredDayAverageChangePercent'] ,
    marketCap = json['marketCap'] ,
    forwardPE = json['forwardPE'] ,
    priceToBook = json['priceToBook'] ,
    sourceInterval = json['sourceInterval'] ,
    exchangeDataDelayedBy = json['exchangeDataDelayedBy'] ,
    marketState = json['marketState'] ,
    gmtOffSetMilliseconds = json['gmtOffSetMilliseconds'] ,
    esgPopulated = json['esgPopulated'] ,
    exchange = json['exchange'] ,
    shortName = json['shortName'] ,
    longName = json['longName'] ,
    messageBoardId = json['messageBoardId'] ,
    exchangeTimezoneName = json['exchangeTimezoneName'] ,
    market = json['market'] ,
    tradeable = json['tradeable'] ,
    exchangeTimezoneShortName = json['exchangeTimezoneShortName'] ,
    firstTradeDateMilliseconds = json['firstTradeDateMilliseconds'] ,
    priceHint = json['priceHint'] ,
    displayName = json['displayName'] ,
    symbol = json['symbol'] ,;
}
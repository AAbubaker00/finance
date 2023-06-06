class YahooQuote{

  


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
    triggerable = json['triggerable'] as bool
    currency = json['currency'] ,
    regularMarketChange = json['regularMarketChange'] as num
    regularMarketChangePercent = json['regularMarketChangePercent'] as num
    regularMarketTime = json['regularMarketTime'] as num
    regularMarketPrice = json['regularMarketPrice'] as num
    regularMarketDayHigh = json['regularMarketDayHigh'] as num
    regularMarketDayRange = json['regularMarketDayRange'] ,
    regularMarketDayLow = json['regularMarketDayLow'] as num
    regularMarketVolume = json['regularMarketVolume'] as num
    regularMarketPreviousClose = json['regularMarketPreviousClose'] as num
    bid = json['bid'] as num
    ask = json['ask'] as num
    bidSize = json['bidSize'] as num
    askSize = json['askSize'] as num
    fullExchangeName = json['fullExchangeName'] ,
    financialCurrency = json['financialCurrency'] ,
    regularMarketOpen = json['regularMarketOpen'] as num
    averageDailyVolume3Month = json['averageDailyVolume3Month'] as num
    averageDailyVolume10Day = json['averageDailyVolume10Day'] as num
    fiftyTwoWeekLowChange = json['fiftyTwoWeekLowChange'] as num
    fiftyTwoWeekLowChangePercent = json['fiftyTwoWeekLowChangePercent'] as num
    fiftyTwoWeekRange = json['fiftyTwoWeekRange'] ,
    fiftyTwoWeekHighChange = json['fiftyTwoWeekHighChange'] as num
    fiftyTwoWeekHighChangePercent =
        json['fiftyTwoWeekHighChangePercent'] as num
    fiftyTwoWeekLow = json['fiftyTwoWeekLow'] as num
    fiftyTwoWeekHigh = json['fiftyTwoWeekHigh'] as num
    dividendDate = json['dividendDate'] as num
    earningsTimestamp = json['earningsTimestamp'] as num
    earningsTimestampStart = json['earningsTimestampStart'] as num
    earningsTimestampEnd = json['earningsTimestampEnd'] as num
    trailingAnnualDividendRate = json['trailingAnnualDividendRate'] as num
    trailingPE = json['trailingPE'] as num
    trailingAnnualDividendYield = json['trailingAnnualDividendYield'] as num
    epsTrailingTwelveMonths = json['epsTrailingTwelveMonths'] as num
    epsForward = json['epsForward'] as num
    epsCurrentYear = json['epsCurrentYear'] as num
    priceEpsCurrentYear = json['priceEpsCurrentYear'] as num
    sharesOutstanding = json['sharesOutstanding'] as num
    bookValue = json['bookValue'] as num
    fiftyDayAverage = json['fiftyDayAverage'] as num
    fiftyDayAverageChange = json['fiftyDayAverageChange'] as num
    fiftyDayAverageChangePercent = json['fiftyDayAverageChangePercent'] as num
    twoHundredDayAverage = json['twoHundredDayAverage'] as num
    twoHundredDayAverageChange = json['twoHundredDayAverageChange'] as num
    twoHundredDayAverageChangePercent =
        json['twoHundredDayAverageChangePercent'] as num
    marketCap = json['marketCap'] as num
    forwardPE = json['forwardPE'] as num
    priceToBook = json['priceToBook'] as num
    sourceInterval = json['sourceInterval'] as num
    exchangeDataDelayedBy = json['exchangeDataDelayedBy'] as num
    marketState = json['marketState'] ,
    gmtOffSetMilliseconds = json['gmtOffSetMilliseconds'] as num
    esgPopulated = json['esgPopulated'] as bool
    exchange = json['exchange'] ,
    shortName = json['shortName'] ,
    longName = json['longName'] ,
    messageBoardId = json['messageBoardId'] ,
    exchangeTimezoneName = json['exchangeTimezoneName'] ,
    market = json['market'] ,
    tradeable = json['tradeable'] as bool
    exchangeTimezoneShortName = json['exchangeTimezoneShortName'] ,
    firstTradeDateMilliseconds = json['firstTradeDateMilliseconds'] as num
    priceHint = json['priceHint'] as num
    displayName = json['displayName'] ,
    symbol = json['symbol'] ,;
}
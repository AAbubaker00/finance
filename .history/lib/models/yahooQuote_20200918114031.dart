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
    :..language = json['language'] as String
    ..region = json['region'] as String
    ..quoteType = json['quoteType'] as String
    ..quoteSourceName = json['quoteSourceName'] as String
    ..triggerable = json['triggerable'] as bool
    ..currency = json['currency'] as String
    ..regularMarketChange = json['regularMarketChange'] as num
    ..regularMarketChangePercent = json['regularMarketChangePercent'] as num
    ..regularMarketTime = json['regularMarketTime'] as num
    ..regularMarketPrice = json['regularMarketPrice'] as num
    ..regularMarketDayHigh = json['regularMarketDayHigh'] as num
    ..regularMarketDayRange = json['regularMarketDayRange'] as String
    ..regularMarketDayLow = json['regularMarketDayLow'] as num
    ..regularMarketVolume = json['regularMarketVolume'] as num
    ..regularMarketPreviousClose = json['regularMarketPreviousClose'] as num
    ..bid = json['bid'] as num
    ..ask = json['ask'] as num
    ..bidSize = json['bidSize'] as num
    ..askSize = json['askSize'] as num
    ..fullExchangeName = json['fullExchangeName'] as String
    ..financialCurrency = json['financialCurrency'] as String
    ..regularMarketOpen = json['regularMarketOpen'] as num
    ..averageDailyVolume3Month = json['averageDailyVolume3Month'] as num
    ..averageDailyVolume10Day = json['averageDailyVolume10Day'] as num
    ..fiftyTwoWeekLowChange = json['fiftyTwoWeekLowChange'] as num
    ..fiftyTwoWeekLowChangePercent = json['fiftyTwoWeekLowChangePercent'] as num
    ..fiftyTwoWeekRange = json['fiftyTwoWeekRange'] as String
    ..fiftyTwoWeekHighChange = json['fiftyTwoWeekHighChange'] as num
    ..fiftyTwoWeekHighChangePercent =
        json['fiftyTwoWeekHighChangePercent'] as num
    ..fiftyTwoWeekLow = json['fiftyTwoWeekLow'] as num
    ..fiftyTwoWeekHigh = json['fiftyTwoWeekHigh'] as num
    ..dividendDate = json['dividendDate'] as num
    ..earningsTimestamp = json['earningsTimestamp'] as num
    ..earningsTimestampStart = json['earningsTimestampStart'] as num
    ..earningsTimestampEnd = json['earningsTimestampEnd'] as num
    ..trailingAnnualDividendRate = json['trailingAnnualDividendRate'] as num
    ..trailingPE = json['trailingPE'] as num
    ..trailingAnnualDividendYield = json['trailingAnnualDividendYield'] as num
    ..epsTrailingTwelveMonths = json['epsTrailingTwelveMonths'] as num
    ..epsForward = json['epsForward'] as num
    ..epsCurrentYear = json['epsCurrentYear'] as num
    ..priceEpsCurrentYear = json['priceEpsCurrentYear'] as num
    ..sharesOutstanding = json['sharesOutstanding'] as num
    ..bookValue = json['bookValue'] as num
    ..fiftyDayAverage = json['fiftyDayAverage'] as num
    ..fiftyDayAverageChange = json['fiftyDayAverageChange'] as num
    ..fiftyDayAverageChangePercent = json['fiftyDayAverageChangePercent'] as num
    ..twoHundredDayAverage = json['twoHundredDayAverage'] as num
    ..twoHundredDayAverageChange = json['twoHundredDayAverageChange'] as num
    ..twoHundredDayAverageChangePercent =
        json['twoHundredDayAverageChangePercent'] as num
    ..marketCap = json['marketCap'] as num
    ..forwardPE = json['forwardPE'] as num
    ..priceToBook = json['priceToBook'] as num
    ..sourceInterval = json['sourceInterval'] as num
    ..exchangeDataDelayedBy = json['exchangeDataDelayedBy'] as num
    ..marketState = json['marketState'] as String
    ..gmtOffSetMilliseconds = json['gmtOffSetMilliseconds'] as num
    ..esgPopulated = json['esgPopulated'] as bool
    ..exchange = json['exchange'] as String
    ..shortName = json['shortName'] as String
    ..longName = json['longName'] as String
    ..messageBoardId = json['messageBoardId'] as String
    ..exchangeTimezoneName = json['exchangeTimezoneName'] as String
    ..market = json['market'] as String
    ..tradeable = json['tradeable'] as bool
    ..exchangeTimezoneShortName = json['exchangeTimezoneShortName'] as String
    ..firstTradeDateMilliseconds = json['firstTradeDateMilliseconds'] as num
    ..priceHint = json['priceHint'] as num
    ..displayName = json['displayName'] as String
    ..symbol = json['symbol'] as String;
}
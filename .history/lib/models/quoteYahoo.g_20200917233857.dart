// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quoteYahoo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteYahoo _$QuoteYahooFromJson(Map<String, dynamic> json) {
  return QuoteYahoo()
    ..language = json['language'] as String
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

Map<String, dynamic> _$QuoteYahooToJson(QuoteYahoo instance) =>
    <String, dynamic>{
      'language': instance.language,
      'region': instance.region,
      'quoteType': instance.quoteType,
      'quoteSourceName': instance.quoteSourceName,
      'triggerable': instance.triggerable,
      'currency': instance.currency,
      'regularMarketChange': instance.regularMarketChange,
      'regularMarketChangePercent': instance.regularMarketChangePercent,
      'regularMarketTime': instance.regularMarketTime,
      'regularMarketPrice': instance.regularMarketPrice,
      'regularMarketDayHigh': instance.regularMarketDayHigh,
      'regularMarketDayRange': instance.regularMarketDayRange,
      'regularMarketDayLow': instance.regularMarketDayLow,
      'regularMarketVolume': instance.regularMarketVolume,
      'regularMarketPreviousClose': instance.regularMarketPreviousClose,
      'bid': instance.bid,
      'ask': instance.ask,
      'bidSize': instance.bidSize,
      'askSize': instance.askSize,
      'fullExchangeName': instance.fullExchangeName,
      'financialCurrency': instance.financialCurrency,
      'regularMarketOpen': instance.regularMarketOpen,
      'averageDailyVolume3Month': instance.averageDailyVolume3Month,
      'averageDailyVolume10Day': instance.averageDailyVolume10Day,
      'fiftyTwoWeekLowChange': instance.fiftyTwoWeekLowChange,
      'fiftyTwoWeekLowChangePercent': instance.fiftyTwoWeekLowChangePercent,
      'fiftyTwoWeekRange': instance.fiftyTwoWeekRange,
      'fiftyTwoWeekHighChange': instance.fiftyTwoWeekHighChange,
      'fiftyTwoWeekHighChangePercent': instance.fiftyTwoWeekHighChangePercent,
      'fiftyTwoWeekLow': instance.fiftyTwoWeekLow,
      'fiftyTwoWeekHigh': instance.fiftyTwoWeekHigh,
      'dividendDate': instance.dividendDate,
      'earningsTimestamp': instance.earningsTimestamp,
      'earningsTimestampStart': instance.earningsTimestampStart,
      'earningsTimestampEnd': instance.earningsTimestampEnd,
      'trailingAnnualDividendRate': instance.trailingAnnualDividendRate,
      'trailingPE': instance.trailingPE,
      'trailingAnnualDividendYield': instance.trailingAnnualDividendYield,
      'epsTrailingTwelveMonths': instance.epsTrailingTwelveMonths,
      'epsForward': instance.epsForward,
      'epsCurrentYear': instance.epsCurrentYear,
      'priceEpsCurrentYear': instance.priceEpsCurrentYear,
      'sharesOutstanding': instance.sharesOutstanding,
      'bookValue': instance.bookValue,
      'fiftyDayAverage': instance.fiftyDayAverage,
      'fiftyDayAverageChange': instance.fiftyDayAverageChange,
      'fiftyDayAverageChangePercent': instance.fiftyDayAverageChangePercent,
      'twoHundredDayAverage': instance.twoHundredDayAverage,
      'twoHundredDayAverageChange': instance.twoHundredDayAverageChange,
      'twoHundredDayAverageChangePercent':
          instance.twoHundredDayAverageChangePercent,
      'marketCap': instance.marketCap,
      'forwardPE': instance.forwardPE,
      'priceToBook': instance.priceToBook,
      'sourceInterval': instance.sourceInterval,
      'exchangeDataDelayedBy': instance.exchangeDataDelayedBy,
      'marketState': instance.marketState,
      'gmtOffSetMilliseconds': instance.gmtOffSetMilliseconds,
      'esgPopulated': instance.esgPopulated,
      'exchange': instance.exchange,
      'shortName': instance.shortName,
      'longName': instance.longName,
      'messageBoardId': instance.messageBoardId,
      'exchangeTimezoneName': instance.exchangeTimezoneName,
      'market': instance.market,
      'tradeable': instance.tradeable,
      'exchangeTimezoneShortName': instance.exchangeTimezoneShortName,
      'firstTradeDateMilliseconds': instance.firstTradeDateMilliseconds,
      'priceHint': instance.priceHint,
      'displayName': instance.displayName,
      'symbol': instance.symbol
    };

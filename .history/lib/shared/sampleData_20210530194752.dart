// import 'package:flutter/scheduler.dart';

class SampleData {
  var apple = {
    'Invested': 451,
    'avgPrice': 37.36,
    'history': [
      {
        'type': 'Market Buy',
        'averagePrice': 37.36,
        'fillPrice': 37.36,
        'filledOn': '2017-09-20',
        'filledQuantity': 12,
        'outstandingShares': 12
      }
    ],
    'symbol': 'AAPL',
    'shares': 12,
    'buyPrice': 37.36,
    'exchange': 'nasdaq',
    'buyDate': '2017-09-20',
  };

  var intel = {
    'Invested': 478.3,
    'avgPrice': 47.83,
    'history': [
      {
        'type': 'Market Buy',
        'averagePrice': 47.83,
        'fillPrice': 47.83,
        'filledOn': '2019-06-12',
        'filledQuantity': 10,
        'outstandingShares': 10
      }
    ],
    'symbol': 'INTC',
    'shares': 10,
    'buyPrice': 47.83,
    'exchange': 'NASDAQ',
    'buyDate': '2019-06-12',
  };

  var cmtl = {
    'symbol': 'CMTL',
    'shares': 10,
    'buyPrice': 26.67,
    'Invested': 266.7,
    'avgPrice': 26.67,
    'history': [
      {
        'type': 'Market Buy',
        'averagePrice': 266.7,
        'fillPrice': 26.67,
        'filledOn': '2018-11-06',
        'filledQuantity': 10,
        'outstandingShares': 10
      }
    ],
    'exchange': 'NASDAQ',
    'buyDate': '2018-11-06',
  };

  var ko = {
    'Invested': 531.2,
    'avgPrice': 53.12,
    'history': [
      {
        'type': 'Market Buy',
        'averagePrice': 53.12,
        'fillPrice': 53.12,
        'filledOn': '2020-11-10',
        'filledQuantity': 10,
        'outstandingShares': 10
      }
    ],
    'symbol': 'KO',
    'shares': 10,
    'buyPrice': 53.12,
    'exchange': 'NYSE',
    'buyDate': '2020-11-10',
  };

  var tsla = {
    'Invested': 3880.4,
    'avgPrice': 388.04,
    'history': [
      {
        'type': 'Market Buy',
        'averagePrice': 388.04,
        'fillPrice': 388.04,
        'filledOn': '2020-10-30',
        'filledQuantity': 10,
        'outstandingShares': 10
      }
    ],
    'symbol': 'TSLA',
    'shares': 10,
    'buyPrice': 388.04,
    'exchange': 'NYSE',
    'buyDate': '2020-10-30',
  };

  var amzn = {
    'Invested': 32185.1,
    'avgPrice': 3218.51,
    'history': [
      {
        'type': 'Market Buy',
        'averagePrice': 3218.51,
        'fillPrice': 3218.51,
        'filledOn': '2021-01-06',
        'filledQuantity': 10,
        'outstandingShares': 10
      }
    ],
    'symbol': 'AMZN',
    'shares': 10,
    'buyPrice': 3218.51,
    'exchange': 'NYSE',
    'buyDate': '2021-01-06',
  };

  var fb = {
    'Invested': 1625.6,
    'avgPrice': 162.56,
    'history': [
      {
        'type': 'Market Buy',
        'averagePrice': 162.56,
        'fillPrice': 162.56,
        'filledOn': '2019-02-20',
        'filledQuantity': 10,
        'outstandingShares': 10
      }
    ],
    'symbol': 'FB',
    'shares': 10,
    'buyPrice': 162.56,
    'exchange': 'NYSE',
    'buyDate': '2019-02-20',
  };

  var dis = {
    'Invested': 1147.5,
    'avgPrice': 114.75,
    'history': [
      {
        'type': 'Market Buy',
        'averagePrice': 114.75,
        'fillPrice': 114.75,
        'filledOn': '2018-11-07',
        'filledQuantity': 10,
        'outstandingShares': 10
      }
    ],
    'symbol': 'DIS',
    'shares': 10,
    'buyPrice': 114.75,
    'exchange': 'NYSE',
    'buyDate': '2018-11-07',
  };

  List getSamplePortfolio() {
    return [
      {
        'name': "Demo",
        'baseCurrency': 'USD',
        'stocks': [fb, dis, apple, amzn, tsla, ko, cmtl, intel]
      }
    ];
  }

  Map getSampleStates() {
    // var brightness = SchedulerBinding.instance.window.platformBrightness;
    // bool isDark = brightness == Brightness.dark;

    return {
      'states': {'dark': true, 'private': false}
    };
  }
}

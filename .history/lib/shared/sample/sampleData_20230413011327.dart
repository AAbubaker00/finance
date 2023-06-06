import 'package:intl/intl.dart';

class SampleData {
  var apple = {
    'symbol': 'AAPL',
    'quantity': 1024,
    'purchasePrice': 37.36,
    'exchange': 'nasdaq',
  };

  var ko = {
    'symbol': 'KO',
    'quantity': 52,
    'purchasePrice': 53.12,
    'exchange': 'NYSE',
  };

  var tsla = {
    'symbol': 'TSLA',
    'quantity': 10,
    'purchasePrice': 160.04,
    'exchange': 'NYSE',
  };

  var amzn = {
    'symbol': 'AMZN',
    'quantity': 10,
    'purchasePrice': 3218.51,
    'exchange': 'NYSE',
  };


  var dis = {
    'symbol': 'DIS',
    'quantity': 23,
    'purchasePrice': 114.75,
    'exchange': 'NYSE',
  };

  List getSamplePortfolio() {
    return [
      {
        'name': "Demo",
        'goal': 100000,
        'holdings': [apple, amzn, tsla, ko, dis]
      }
    ];
  }

  Map getSampleStates() {
    return {
      'states': {'theme': true, 'private': false}
    };
  }

  Map getGuestProfileData() {
    return {
      'baseCurrency': 'USD',
      'isVertified': false,
      'lastUpdated': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'subscription': 'anon',
      'userEmail': 'na',
      'userName': 'Guest'
    };
  }
}

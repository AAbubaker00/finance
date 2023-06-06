import 'package:Strice/services/yahooapi/yahoo_api_provider.dart';
import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';
class MarketChangeNotifier with ChangeNotifier {
  final List portfolios = ['sdsd', 'sdsd', 'as', 'ssewee'];

  // MarketChangeNotifier(this.portfolios);

  Stream<List<Map>> get getMarketChange async* {
    for (var i = 0; i < portfolios.length; i++) {
      await Future.delayed(Duration(seconds: 2))
      yield portfolios.sublist(0, i + 1);
    }
  }
}

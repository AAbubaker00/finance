import 'package:Strice/services/yahooapi/yahoo_api_provider.dart';
import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';
class MarketChangeNotifier with ChangeNotifier {
  final List portfolios = ['sdsd', 'sdsd', 'as'];

  // MarketChangeNotifier(this.portfolios);

  Stream<List<Map>> get getMarketChange async* {
    
  }
}

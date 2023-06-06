import 'package:Strice/services/yahooapi/yahoo_api_provider.dart';
import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';
class MarketChangeNotifier with ChangeNotifier {
  Stream marketChange(List assets) {
    for(var asset in assets){
      asset['marketData']['quote'] =
              await YahooApiService().getYahooQuote(exchange: asset['exchange'], symbol: asset['symbol']);
    }
  }
}

import 'package:Strice/services/yahooapi/yahoo_api_provider.dart';
import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';
class MarketChangeNotifier with ChangeNotifier {
  Future<Stream> marketChange(List assets) async {
    for (var asset in assets) {
      asset['marketData']['quote'] =
          await YahooApiService().getYahooQuote(exchange: asset['exchange'], symbol: asset['symbol']);
    }
  }
}

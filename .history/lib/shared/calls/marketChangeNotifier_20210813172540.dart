import 'package:Strice/services/yahooapi/yahoo_api_provider.dart';
import 'package:Strice/shared/update/update.dart';
import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';
class MarketChangeNotifier {
  final List<Map> portfolios; // = ['sdsd', 'sdsd', 'as', 'ssewee'];
  final Map rates;

  MarketChangeNotifier(this.portfolios, this.rates);

  // MarketChangeNotifier(this.portfolios);

  Stream<List<Map>> get getMarketChange async* {
    for (Map portfolio in portfolios) {
      for (var assetType in portfolio['assets']) {
        for (var asset in assetType) {
          asset['marketData']['quote'] =
              await YahooApiService().getYahooQuote(exchange: asset['exchange'], symbol: asset['symbol']);

          Update('USD').updatePortfolio(portfolio);
        }
      }
    }

    for (var i = 0; i < portfolios.length; i++) {
      await Future.delayed(Duration(seconds: 2));
      // print('here');

      yield portfolios.sublist(0, i + 1);
    }
  }
}

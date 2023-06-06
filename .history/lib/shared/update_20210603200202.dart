import 'package:Strice/services/forex/forexConversion.dart';
import 'package:Strice/services/yahooapi/yahoo_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:Strice/extensions/stringExt.dart';

class Update {
  String baseCurrency;
  Map newRates = {};
  List reFilter = [];
  int counter = 0;

  
  Update(this.baseCurrency);

  updateValues(List portfolios, BuildContext context, Map data) {
    for (var portfolio in portfolios) {
      for (var stock in portfolio['stocks']) {
        if (reFilter.isEmpty) {
          reFilter.add(stock);
        } else {
          int isStockExist = reFilter.indexWhere((element) => element['symbol'] == stock['symbol']);

          if (isStockExist == -1) {
            reFilter.add(stock);
          }
        }
      }
    }

    // data.forEach((key, value) {
    //   if (key == 'states') {
    //     print(value);
    //   }
    // });

    getRates();
    getMarketData(portfolios, context, data);
  }

  getRates() async {
    newRates = await ForexConversion().getLatestFxRates();
  }

  getMarketData(List portfolios, BuildContext context, Map data) async {
    reFilter.forEach((stock) async {
      stock['marketData'] =
          await YahooApiService().getAllStockData(symbol: stock['symbol'], exchange: stock['exchange']);
      counter++;

      if (counter == reFilter.length) {
        for (var portfolio in portfolios) {
          portfolio = updatePortfolio(portfolio, filterStocks: reFilter, rates: newRates);

          // print(newRates);

          Navigator.pushReplacementNamed(context, '/home', arguments: {
            'initalData': data['initalData'],
            'portfolios': portfolios,
            'userDetails': data['userDetails'],
            'offlineData': true,
            'states': data['prStates'],
            'rates': newRates
          });
        }
      }
    });
  }

  Map updatePortfolio(Map portfolio, {List filterStocks, Map rates}) {
    portfolio['isSelected'] = false;
    // print(filterStocks);
    // baseCurrency = portfolio['baseCurrency'];

    // print(rates['rates']);
    // print(baseCurrency);

    portfolio['stocks'].sort((a, b) => DateTime.parse(a['buyDate']).compareTo(DateTime.parse(b['buyDate'])));

    portfolio['forex'] = {'base': baseCurrency, 'rates': rates};

    for (var stock in portfolio['stocks']) {
      if (filterStocks != null) {
        int stockIndex = filterStocks.indexWhere((element) => element['symbol'] == stock['symbol']);
        stock['marketData'] = filterStocks[stockIndex]['marketData'];
      }

      String quote = stock['marketData']['quote']['currency'].toString().capitalizeAll();

      double cvrtRate = getRate(rates, quote);

      stock['marketPrice'] = ((double.parse(stock['marketData']['quote']['regularMarketPrice'].toString()) /
              (stock['exchange'] == 'LSE' ? 100.0 : 1.0))) *
          cvrtRate;

      stock['convrtBuyPrice'] = stock['avgPrice'];
      stock['convrtBuyPrice'] *= cvrtRate;

      stock['change'] = stock['marketPrice'] - (double.parse(stock['convrtBuyPrice'].toString()));
      stock['percDiff'] =
          (double.parse(stock['change'].toString()) / double.parse(stock['convrtBuyPrice'].toString())) * 100;

      stock['value'] = stock['marketPrice'] * double.parse(stock['shares'].toString());

      stock['Invested'] = stock['convrtBuyPrice'] * double.parse(stock['shares'].toString());
      stock['change'] = (double.parse(stock['change'].toString()) * double.parse(stock['shares'].toString()));
    }

    return portfolio;
  }

  double getRate(Map rates, String quote) {
    if (baseCurrency != 'USD' && quote != 'USD') {
      return (rates['rates']['$baseCurrency']) * (1 / rates['rates']['$quote']);
    } else if (baseCurrency == 'USD' && quote != 'USD') {
      return 1 / (rates['rates'][quote]);
    } else if (baseCurrency != 'USD' && quote == 'USD') {
      return rates['rates']['$baseCurrency'];
    } else {
      return 1;
    }
  }

  List currencySymbols = [
    {'short': 'GBP', 'symbol': '£', 'name': 'Pound sterling'},
    {'short': 'USD', 'symbol': '\$', 'name': 'United States Dollar'},
    {'short': 'EUR', 'symbol': '€', 'name': 'Euro'},
    {'short': 'CAD', 'symbol': 'C\$', 'name': 'Canadian dollar'},
    {'short': 'HKD', 'symbol': 'HK\$', 'name': 'Hong Kong dollar'},
    {'short': 'ISK', 'symbol': 'ISK', 'name': 'Icelandic króna'},
    {'short': 'PHP', 'symbol': '₱', 'name': 'Philippine peso'},
    {'short': 'DKK', 'symbol': 'Kr.', 'name': 'Danish krone'},
    {'short': 'HUF', 'symbol': 'Ft', 'name': 'Hungarian forint'},
    {'short': 'CZK', 'symbol': 'Kč', 'name': 'Czech koruna'},
    {'short': 'RON', 'symbol': 'lei', 'name': 'Romanian leu'},
    {'short': 'SEK', 'symbol': 'kr', 'name': 'Swedish krona'},
    {'short': 'IDR', 'symbol': 'Rp', 'name': 'Indonesian rupiah'},
    {'short': 'BRL', 'symbol': 'R\$', 'name': 'Brazilian real'},
    {'short': 'RUB', 'symbol': '₽', 'name': 'Russian ruble'},
    {'short': 'HRK', 'symbol': 'kn', 'name': 'Croatian kuna'},
    {'short': 'JPY', 'symbol': '‎¥', 'name': 'Japanese yen'},
    {'short': 'THB', 'symbol': '฿', 'name': 'Thai baht'},
    {'short': 'CHF', 'symbol': 'CHf', 'name': 'Swiss franc'},
    {'short': 'BGN', 'symbol': 'Лв.', 'name': 'Bulgarian lev'},
    {'short': 'TRY', 'symbol': '₺', 'name': 'Turkish lira'},
    {'short': 'CNY', 'symbol': '¥', 'name': 'Renminbi'},
    {'short': 'NOK', 'symbol': 'kr', 'name': 'Norwegian krone'},
    {'short': 'NZD', 'symbol': 'NZ\$', 'name': 'New Zealand dollar'},
    {'short': 'ZAR', 'symbol': 'R', 'name': 'South African rand'},
    {'short': 'MXN', 'symbol': 'Mex\$', 'name': 'Mexican peso'},
    {'short': 'SGD', 'symbol': 'S\$', 'name': 'Singapore dollar'},
    {'short': 'AUD', 'symbol': 'A\$', 'name': 'Australian dollar'},
    {'short': 'ILS', 'symbol': '₪', 'name': 'Israeli Shekel'},
    {'short': 'KRW', 'symbol': '₩', 'name': 'Korean won'},
    {'short': 'PLN', 'symbol': 'zł', 'name': 'Polish Zloty'}
  ];

  Map getCurrencySymbol() {
    return currencySymbols.firstWhere((element) => element['short'] == baseCurrency, orElse: () => 
    {'short': '??', 'symbol': '??', 'name': 'Unknown'},
    );
  }
}

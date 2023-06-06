import 'package:Valuid/services/database/database.dart';
import 'package:Valuid/services/yahooapi/yahoo_api_provider.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Valuid/extensions/stringExt.dart';

import '../../models/quote/quote.dart';

class Initialise {
  String baseCurrency;

  Map rates = {}, states = {};

  List filteredHoldings = [], filteredQuotes = [];
  List portfolios = [];
  int counter = 0;

  BuildContext context;
  final Map databaseData;

  DocumentSnapshot documentSnapshot;

  Initialise({
    this.baseCurrency,
    this.context,
    this.databaseData,
    this.documentSnapshot,
    this.states,
  });

 

  Map updatePortfolio(Map portfolio, {List filteredHoldings, rates}) {
    portfolio['forex'] = {'base': baseCurrency, 'rates': rates};
    portfolio['invested'] = 0.0;
    portfolio['value'] = 0.0;
    portfolio['change'] = 0.0;
    portfolio['changePercent'] = 0.0;

    for (var holdingType in portfolio['assets']) {
      holdingType['change'] = 0.0;
      holdingType['invested'] = 0.0;

      for (var holding in holdingType['items']) {
        QuoteObject linkedQuote;
        // print(holdingType['items'].length);

        if (filteredHoldings != null) {
          linkedQuote = filteredQuotes.firstWhere((quote) => quote.symbol == holding['symbol']);
        }

        String currency = linkedQuote.currency;
        double cvrtRate = getRate(rates, currency);

        holding['marketPrice'] = double.parse(linkedQuote.regularMarketPrice.toString()) * cvrtRate;
        holding['regularMarketChange'] = double.parse(linkedQuote.regularMarketPrice.toString()) * cvrtRate;
        holding['convrtBuyPrice'] = holding['avgPrice'] * cvrtRate;

        holding['change'] = holding['marketPrice'] - (double.parse(holding['convrtBuyPrice'].toString()));
        holding['percDiff'] = (double.parse(holding['change'].toString()) /
                double.parse(holding['convrtBuyPrice'].toString())) *
            100;

        holding['invested'] = holding['convrtBuyPrice'] * double.parse(holding['shares'].toString());
        holding['change'] =
            (double.parse(holding['change'].toString()) * double.parse(holding['shares'].toString()));

        holdingType['change'] += holding['change'];
        // holdingType['dailyChange'] += holding['dailyChange'];
        holdingType['invested'] += holding['invested'];

        holding['value'] = holding['change'] + holding['invested'];

        portfolio['invested'] += holding['invested'];
        portfolio['value'] += holding['value'];

        portfolio['change'] += double.parse(holding['change'].toString());
        // portfolio['dailyChange'] += holding['regularMarketChange'] * holding['shares'];
      }

      // portfolio['dailyChangePercent'] += (portfolio['dailyChange'] / portfolio['investedValue']) * 100;
      portfolio['changePercent'] = (portfolio['change'] / portfolio['invested']) * 100;
    }

    return portfolio;
  }

  double getRate(Map rates, String quote) {
    if (baseCurrency != 'USD' && quote != 'USD') {
      return (rates['rates']['$baseCurrency']) * (1 / rates['rates']['$quote']);
    } else if (baseCurrency == 'USD' && quote != 'USD') {
      return (rates['rates'][quote]);
    } else if (baseCurrency != 'USD' && quote == 'USD') {
      return 1 / rates['rates']['$baseCurrency'];
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
    {'short': 'JPY', 'symbol': '¥', 'name': 'Japanese yen'},
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
    return currencySymbols.firstWhere(
      (element) => element['short'] == baseCurrency.capitalizeAll(),
      orElse: () => {'short': '??', 'symbol': '??', 'name': 'Unknown'},
    );
  }
}

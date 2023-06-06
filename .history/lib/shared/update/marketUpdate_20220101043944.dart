import 'package:Strice/pages/home/home.dart';
import 'package:Strice/services/database/database.dart';
import 'package:Strice/services/yahooapi/yahoo_api_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Strice/extensions/stringExt.dart';

class MarketUpdate {
  String baseCurrency;
  Map rates = {};
  List filteredHoldings = [];
  int counter = 0;

  Map data;
  List portfolios;
  BuildContext context;

  final _auth = FirebaseAuth.instance;

  final Map databaseData;

  DocumentSnapshot documentSnapshot;

  MarketUpdate(
      {@required this.baseCurrency, this.data, this.context, this.databaseData, this.documentSnapshot});

  updateValues(BuildContext context) {
    User currentUser = _auth.currentUser;

    if (currentUser.isAnonymous) {
      portfolios = databaseData['portfolios'];
    } else {
      portfolios = (documentSnapshot.data() as Map)['portfolios'];
    }

    for (var portfolio in portfolios) {
      for (var holdingType in portfolio['assets']) {
        for (var holding in holdingType['items']) {
          if (filteredHoldings.isEmpty) {
            filteredHoldings.add(holding);
          } else {
            int isAssetExist =
                filteredHoldings.indexWhere((element) => element['symbol'] == holding['symbol']);

            if (isAssetExist == -1) {
              filteredHoldings.add(holding);
            }
          }
        }
      }
    }

    getRates();
    getMarketData();
  }

  getRates() async {
    if (rates == null) {
      rates = await DatabaseService().getRates();
    }
  }

  getMarketData() async {
    filteredHoldings.forEach((asset) async {
      asset['marketData'] =
          await YahooApiService().getAllAssetData(symbol: asset['symbol'], exchange: asset['exchange']);
      counter++;

      if (counter == filteredHoldings.length) {
        for (var portfolio in portfolios) {
          portfolio = updatePortfolio(portfolio, filterAssets: filteredHoldings, rates: rates);

          Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Home(),
            settings: RouteSettings(arguments: {
              'initalData': databaseData,
              'portfolios': portfolios,
              'themeMode': true,
              'news': null,
              'filteredAssets': filterAssets,
              'rates': rates,
            })));
        }
      }
    });
  }

  Map updatePortfolio(Map portfolio, {List filterAssets, Map rates}) {
    // for (var assetType in portfolio['assets']) {
    //   assetType['items'].sort((a, b) => DateTime.parse(a['buyDate']).compareTo(DateTime.parse(b['buyDate'])));
    // }

    portfolio['forex'] = {'base': baseCurrency, 'rates': rates};

    for (var assetType in portfolio['assets']) {
      for (var asset in assetType['items']) {
        bool isLSE = asset['exchange'] == 'LSE' ? true : false;

        if (filterAssets != null) {
          int assetIndex = filterAssets.indexWhere((element) => element['symbol'] == asset['symbol']);
          asset['marketData'] = filterAssets[assetIndex]['marketData'];
        }

        String quote = asset['marketData']['quote']['currency'].toString().capitalizeAll();

        double cvrtRate = getRate(rates, quote);

        // print('${asset['symbol']} : $cvrtRate');

        asset['marketPrice'] = ((double.parse(asset['marketData']['quote']['regularMarketPrice'].toString()) /
                (isLSE ? 100.0 : 1.0))) *
            cvrtRate;

        // PrintFunctions().printStartEndLine(asset['marketData']['quote']['regularMarketPrice']);

        asset['regularMarketChange'] =
            ((double.parse(asset['marketData']['quote']['regularMarketChange'].toString()) /
                    (isLSE ? 100.0 : 1.0))) *
                cvrtRate;

        asset['convrtBuyPrice'] = asset['avgPrice'];
        asset['convrtBuyPrice'] *= cvrtRate;

        asset['change'] = asset['marketPrice'] - (double.parse(asset['convrtBuyPrice'].toString()));
        asset['percDiff'] =
            (double.parse(asset['change'].toString()) / double.parse(asset['convrtBuyPrice'].toString())) *
                100;

        asset['Invested'] = asset['convrtBuyPrice'] * double.parse(asset['shares'].toString());
        asset['change'] =
            (double.parse(asset['change'].toString()) * double.parse(asset['shares'].toString()));

        asset['value'] = asset['change'] + asset['Invested'];

        // if (asset['symbol'] == 'PCXCU') {
        //   print(asset['change']);
        // }
      }
    }

    portfolio['investedValue'] = 0.0;
    portfolio['portfolioValue'] = 0.0;
    portfolio['change'] = 0.0;
    portfolio['changePercent'] = 0.0;
    portfolio['dailyChange'] = 0.0;
    portfolio['dailyChangePercent'] = 0.0;

    for (var assetType in portfolio['assets']) {
      for (var asset in assetType['items']) {
        // print(asset['regularMarketChange']);

        // print('${asset['symbol']} : ${asset['value']}');
        portfolio['investedValue'] += asset['Invested'];
        portfolio['portfolioValue'] += asset['value'];
        portfolio['change'] += double.parse(asset['change'].toString());
        portfolio['dailyChange'] += asset['regularMarketChange'];
      }
      // print(portfolio['dailyChange']);
    }

    portfolio['dailyChangePercent'] += (portfolio['dailyChange'] / portfolio['investedValue']) * 100;

    return portfolio;
  }

  double getRate(Map rates, String quote) {
    if (baseCurrency != 'USD' && quote != 'USD') {
      return (rates['rates']['$baseCurrency']) * (1 / rates['rates']['$quote']);
    } else if (baseCurrency == 'USD' && quote != 'USD') {
      return (rates['rates'][quote]);
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

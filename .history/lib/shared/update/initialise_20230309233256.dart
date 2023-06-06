import 'package:Valuid/pages/home/home.dart';
import 'package:Valuid/services/coingecko/coinGecko.dart';
import 'package:Valuid/services/database/database.dart';
import 'package:Valuid/services/yahooapi/yahoo_api_provider.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Valuid/extensions/stringExt.dart';

class Initialise {
  String baseCurrency;

  Map rates = {}, states = {}, commodities = {};

  List filteredStockHoldings = [],
      filteredCryptoHoldings = [],
      filteredHoldings = [],
      filteredCommoditiesHoldings = [];
  List portfolios = [];

  int counter = 0;

  BuildContext context;

  final _auth = FirebaseAuth.instance;

  final Map databaseData;

  DocumentSnapshot documentSnapshot;

  Initialise(
      {this.baseCurrency,
      this.context,
      this.databaseData,
      this.documentSnapshot,
      this.states,
      this.commodities});

  updateValues() async {
    User currentUser = _auth.currentUser;

    if (currentUser.isAnonymous) {
      portfolios = databaseData['portfolios'];
    } else {
      portfolios = (documentSnapshot.data() as Map)['portfolios'];
    }

    // print('object');

    for (var portfolio in portfolios) {
      for (var holdingType in portfolio['assets']) {
        // PrintFunctions().printStartEndLine(holdingType['id']);

        if (holdingType['id'] == 'stocks') {
          for (var holding in holdingType['items']) {
            holding['typeId'] = 'stocks';

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
        } else if (holdingType['id'] == 'cryptos') {
          for (var holding in holdingType['items']) {
            holding['typeId'] = 'cryptos';

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
        } else if (holdingType['id'] == 'commodities') {
          for (var holding in holdingType['items']) {
            holding['typeId'] = 'commodities';

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
    }

    // print('here');

    await getRates();
    await getCommodities();
    return getMarketData();
  }

  updateOnHoldings(DataObject dataObject) async {
    dataObject.onStockHoldings.clear();
    dataObject.onCryptoHoldings.clear();
    dataObject.onCommodityHoldings.clear();

    List removeTypesIndex = dataObject.onPortfolio['assets'].where((holdingType) => holdingType['items'].length == 0).toList();

    for(var removeIndex in removeTypesIndex){
      dataObject.onPortfolio['assets'].removeAt(removeIndex);
    }

    if (dataObject.portfolios.length > 0) {
      for (var holdingType in dataObject.onPortfolio['assets']) {
        if (holdingType['id'] == 'stocks') {
          dataObject.onStockHoldings.addAll(holdingType['items']);
          dataObject.regions.clear();

          for (var asset in holdingType['items']) {
            if (asset['marketData']['assets'].containsKey('country')) {
              int isRegionExist = dataObject.regions
                  .indexWhere((region) => asset['marketData']['assets']['country'] == region);

              if (isRegionExist == -1) {
                dataObject.regions.add(asset['marketData']['assets']['country']);
              }
            }
          }
        } else if (holdingType['id'] == 'cryptos') {
          dataObject.onCryptoHoldings.addAll(holdingType['items']);
        } else if (holdingType['id'] == 'commodities') {
          dataObject.onCommodityHoldings.addAll(holdingType['items']);
        }
      }

      dataObject.onStockHoldingSymbols = List.generate(dataObject.onStockHoldings.length,
          (index) => dataObject.onStockHoldings[index]['symbol'].replaceAll('.L', ''));
    }
  }

  getRates() async {
    rates = await DatabaseService().getRates();
  }

  getCommodities() async {
    commodities = await DatabaseService().getCommodities();

    // print(commodities);
  }

  getMarketData() async {
    // print(filteredHoldings.length);

    if (filteredHoldings.length > 0) {
      // print(filteredHoldings.length);

       filteredHoldings.forEach((holding) async {
        // print('object');

        if (holding['typeId'] == 'stocks') {
          // print('here');

          holding['marketData'] = await YahooApiService()
              .getAllAssetData(symbol: holding['symbol'], exchange: holding['exchange']);
          counter++;
        } else if (holding['typeId'] == 'cryptos') {
          holding['marketData'] = await CoinGeko().getCoinResult(holding['id']);

          // print(holding);

          counter++;
        } else if (holding['typeId'] == 'commodities') {
          counter++;
        }

        if (counter == filteredHoldings.length) {
          // print('object');

          for (var portfolio in portfolios) {
            portfolio = updatePortfolio(portfolio, filteredHoldings: filteredHoldings, rates: rates);
          }

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(
                  data: {
                    'initalData': databaseData,
                    'portfolios': portfolios,
                    'theme': states['theme'],
                    // 'yahooNews': null,
                    'filteredStocks': filteredStockHoldings,
                    'filteredCrypto': filteredCryptoHoldings,
                    'rates': rates,
                    'commodities': commodities,
                    'dividends': [],
                    'earnings': [],
                    'holidays': [],
                    'notificationsEvents': [],

                    'lastCalenderUpdate': ''
                  },
                ),
              ));
        }
      });
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(
              data: {
                'initalData': databaseData,
                'portfolios': portfolios,
                'theme': states['theme'],
                // 'yahooNews': null,
                'filteredStocks': filteredStockHoldings,
                'filteredCrypto': filteredCryptoHoldings,
                'filteredCommodities': filteredCommoditiesHoldings,
                'notificationsEvents': [],
                'rates': rates,
                'commodities': commodities,
                'dividends': [],
                'earnings': [],
                'holidays': [],
                'lastCalenderUpdate': ''
              },
            ),
          ));
    }
  }

  Map updatePortfolio(Map portfolio, {List filteredHoldings, rates}) {
    if (!portfolio.containsKey('goal')) {
      portfolio['goal'] = '100000';
    }

    // print(portfolio['goal']);

    portfolio['forex'] = {'base': baseCurrency, 'rates': rates};
    portfolio['investedValue'] = 0.0;
    portfolio['portfolioValue'] = 0.0;
    portfolio['change'] = 0.0;
    portfolio['returnPercentage'] = 0.0;
    portfolio['dailyChange'] = 0.0;
    portfolio['dailyChangePercent'] = 0.0;
    // portfolio['news'] = [];

    portfolio['dividendsInvested'] = 0.0;
    portfolio['dividendsValue'] = 0.0;
    portfolio['dividendsReturn'] = 0.0;

    for (var holdingType in portfolio['assets']) {
      if (holdingType['id'] == 'stocks' && holdingType['items'].isNotEmpty) {
        holdingType['change'] = 0.0;
        holdingType['dailyChange'] = 0.0;
        holdingType['invested'] = 0.0;
        holdingType['view'] = true;

        for (var holding in holdingType['items']) {
          // print(holdingType['items'].length);
          bool isLSE = holding['exchange'] == 'LSE' ? true : false;

          if (filteredHoldings != null) {
            int holdingIndex = filteredHoldings.indexWhere(
                (element) => element['symbol'] == holding['symbol'] && element['typeId'] == 'stocks');
            holding['marketData'] = filteredHoldings[holdingIndex]['marketData'];
          }

          // PrintFunctions().printStartEndLine(holding['marketData']);
          // PrintFunctions().printStartEndLine(holding['symbol']);

          String quote = holding['marketData']['quote']['currency'].toString().capitalizeAll();

          double cvrtRate = getRate(rates, quote);

          // PrintFunctions().printStartEndLine('$quote vs $baseCurrency - $cvrtRate');
          // PrintFunctions().printStartEndLine(cvrtRate);

          // print(cvrtRate);

          // print('${holding['symbol']} : $cvrtRate');
          // print(holding['marketData']['quote']['regularMarketPrice']);

          holding['marketPrice'] =
              ((double.parse(holding['marketData']['quote']['regularMarketPrice'].toString()) /
                      (isLSE ? 100.0 : 1.0))) *
                  cvrtRate;

          // PrintFunctions().printStartEndLine(holding['marketData']['quote']['regularMarketPrice']);

          // holding['regularMarketChange'] =
          //     ((double.parse(holding['marketData']['quote']['regularMarketChange'].toString()) /
          //             (isLSE ? 100.0 : 1.0))) *
          //         cvrtRate;

          // holding['dailyChange'] =
          //     ((holding['regularMarketChange'] * holding['shares'] / (isLSE ? 100.0 : 1.0))) * cvrtRate;

          // holding['dailyChnagePercDiff'] = holding['daily']

          holding['convrtBuyPrice'] = holding['avgPrice'];
          holding['convrtBuyPrice'] *= cvrtRate;

          holding['change'] = holding['marketPrice'] - (double.parse(holding['convrtBuyPrice'].toString()));
          holding['percDiff'] = (double.parse(holding['change'].toString()) /
                  double.parse(holding['convrtBuyPrice'].toString())) *
              100;

          holding['Invested'] = holding['convrtBuyPrice'] * double.parse(holding['shares'].toString());
          holding['change'] =
              (double.parse(holding['change'].toString()) * double.parse(holding['shares'].toString()));

          holdingType['change'] += holding['change'];
          // holdingType['dailyChange'] += holding['dailyChange'];
          holdingType['invested'] += holding['Invested'];

          holding['value'] = holding['change'] + holding['Invested'];

          if (holding['marketData']['quote'].containsKey('trailingAnnualDividendRate')) {
            portfolio['dividendsInvested'] += holding['Invested'];
            portfolio['dividendsValue'] += holding['value'];
            portfolio['dividendsReturn'] += holding['change'];
          }

          portfolio['investedValue'] += holding['Invested'];
          portfolio['portfolioValue'] += holding['value'];

          portfolio['change'] += double.parse(holding['change'].toString());
          // portfolio['dailyChange'] += holding['regularMarketChange'] * holding['shares'];
        }

        // portfolio['dailyChangePercent'] += (portfolio['dailyChange'] / portfolio['investedValue']) * 100;
        portfolio['returnPercentage'] = (portfolio['change'] / portfolio['investedValue']) * 100;
      }
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

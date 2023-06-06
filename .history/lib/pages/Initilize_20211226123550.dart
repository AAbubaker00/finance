import 'package:Strice/pages/home/home.dart';
import 'package:Strice/services/database/database.dart';
import 'package:Strice/shared/dataObject/data_object.dart' as dO;
import 'package:Strice/shared/printFunctions/custom_Print_Functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Strice/services/forex/forexConversion.dart';
import 'package:Strice/services/yahooapi/yahoo_api_provider.dart';
import 'package:Strice/shared/update/marketUpdate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Initialize {
  List filterAssets = [], portfolios = [];
  Map states, userDetails, locationData, device_data = {};

  String baseCurrency = 'USD';

  int assetCount = 0, counter = 0;

  Map rates = {};

  final BuildContext context;

  final _auth = FirebaseAuth.instance;

  Initialize({DocumentSnapshot documentSnapshot, this.context, this.states, this.initalData, this.rates}) {
    // initalData = {'portfolios': docs['portfolios']};
    User currentUser = _auth.currentUser;

    if (currentUser.isAnonymous) {
      portfolios = initalData['portfolios'];
      userDetails = initalData['profile_data'];
    } else {
      dO.DatabaseData databaseData = dO.DatabaseData.fromMap((documentSnapshot.data() as Map));

      // portfolios = (documentSnapshot.data() as Map)['portfolios'];
      // userDetails = (documentSnapshot.data() as Map)['profile_data'];
      // locationData = (documentSnapshot.data() as Map)['user_location'];
      // device_data = (documentSnapshot.data() as Map)['device_data'];
    }

    // baseCurrency = docs['userDetails']['baseCurrency'];

    for (var portfolio in portfolios) {
      for (var assetType in portfolio['assets']) {
        for (var asset in assetType['items']) {
          if (filterAssets.isEmpty) {
            filterAssets.add(asset);
          } else {
            int isAssetExist = filterAssets.indexWhere((element) => element['symbol'] == asset['symbol']);

            if (isAssetExist == -1) {
              filterAssets.add(asset);
            }
          }
        }
      }
    }

    // PrintFunctions().printStartEndLine('Phase 1: ${sp.elapsed}');
    // sp.stop();
    // sp.reset();
    // sp.start();

    getRates();

    getMarketData();
  }

  Stopwatch sp = Stopwatch();

  getRates() async {
    if (rates == null) {
      rates = await DatabaseService().getRates();

      // PrintFunctions().printStartEndLine('Phase 2: ${sp.elapsed}');
      // sp.stop();
      // sp.reset();
      // sp.start();
    }
  }

  getMarketData() {
    filterAssets.forEach((asset) async {
      asset['marketData'] =
          await YahooApiService().getAllAssetData(symbol: asset['symbol'], exchange: asset['exchange']);
      counter++;

      // print(rates);

      if (counter == filterAssets.length) {
        for (var portfolio in portfolios) {
          portfolio =
              MarketUpdate(baseCurrency).updatePortfolio(portfolio, filterAssets: filterAssets, rates: rates);
        }
        PrintFunctions().printStartEndLine('Phase 3: ${sp.elapsed}');
        sp.stop();
        sp.reset();

        isFinished();
      }
    });
  }

  isFinished() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Home(),
            settings: RouteSettings(arguments: {
              'initalData': initalData,
              'portfolios': portfolios,
              'userDetails': userDetails,
              'locationData': locationData,
              'device_data': device_data,
              'themeMode': states['theme'],
              'lastMarketUpdate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
              'news': null,
              'lastMarketCall': DateFormat('yyyy-MM-dd').format(DateTime.now()),
              'filteredAssets': filterAssets,
              'rates': rates,
            })));

    // Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false, arguments: {
    //   'initalData': initalData,
    //   'portfolios': portfolios,
    //   'userDetails': userDetails,
    //   'locationData': locationData,
    //   'device_data': device_data,
    //   'offlineData': false,
    //   'states': states,
    //   'lastMarketUpdate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    //   'lastMarketCall': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    //   'filteredAssets': filterAssets,
    //   'rates': rates,
    // });
  }
}

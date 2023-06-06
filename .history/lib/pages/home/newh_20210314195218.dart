import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/models/user/user.dart';
import 'package:finance/pages/Initilize.dart';
import 'package:finance/services/forex/forexConversion.dart';
import 'package:finance/services/yahooapi/yahoo_api_provider.dart';
import 'package:finance/shared/fileHandling.dart';
import 'package:finance/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:finance/extensions/stringExt.dart';

class Homes extends StatefulWidget {
  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  Map prStates = {
    'states': {'dark': true, 'private': false}
  };
  Map initData = {}, rates;
  Map<String, dynamic> masterAccount = {};
  Map data = {};

  List<Map<dynamic, dynamic>> stocks = [];
  List portfolios = [];

  double portfolioCount = 0;
  double stockCount = 0;
  double sharesCount = 0;
  double investedValue = 0;
  double portfolioValue = 0;
  double settingSpacing = 17;
  double ratio;

  String userName;
  String userEmail;
  String userNumber;
  String baseCurrency = '';
  String currencySymbol = '';
  String baseC = '';
  String name;
  String description;

  bool isDarkMode = false;
  bool updateChanges = false;
  bool isSaveData = false;
  bool isPrivate = false;
  bool updating = false;
  bool isDark = true;

  UserData user;

  TextStyle assetHeaderStyle;
  TextStyle setOptionStyle;

  loadData(QuerySnapshot querySnapshot, BuildContext context) async {
    
    assetHeaderStyle = TextStyle(color: DarkTheme(isDark).textColorVarient, fontWeight: FontWeight.w600);
    setOptionStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: DarkTheme(isDark).textColor,
    );



    var states = await OfflineDataset().readStates();
    var ofData = await OfflineDataset().readPortfolios();

    if (states == '') {
      OfflineDataset().writeStates(json.encode(prStates));
    } else {
      var statesJson = json.decode(states);
      prStates = statesJson;
    }

    if (ofData == '') {
      if (querySnapshot == null) {
        return MainLoading();
      } else {
        Initialize(querySnapshot: querySnapshot, context: context, isDataChanged: false, states: prStates);
      }
    } else {
      var odJson = json.decode(ofData);

      setState(() {
        isDark = (odJson['states']['dark']);
        portfolios = odJson['portfolios'];
        userName = odJson['userDetails']['userName'];
        userEmail = odJson['userDetails']['userEmail'];
        userNumber = odJson['userDetails']['userNumber'];
        baseC = odJson['userDetails']['baseCurrency'];
        initData = odJson['initalData'];
        rates = odJson['rates'];

        for (var portfolio in portfolios) {
          baseCurrency = Update(baseC).getCurrencySymbol()['symbol'];

          if (updateChanges) {
            Update(baseC).updatePortfolio(portfolio, rates: rates);
            updateChanges = false;
          }

          portfolio['investedValue'] = 0.0;
          portfolio['portfolioValue'] = 0.0;
          portfolio['change'] = 0.0;

          for (var stock in portfolio['stocks']) {
            // print('${stock['symbol']} : ${stock['value']}');
            portfolio['investedValue'] += stock['Invested'];
            portfolio['portfolioValue'] += stock['value'];
            portfolio['change'] += double.parse(stock['change'].toString());
          }
        }
      });

      if (updateChanges) {
      OfflineDataset().writePortfolios(json.encode(data));
      isSaveData = false;
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    final querySnapshot = Provider.of<QuerySnapshot>(context);
    user = (Provider.of<UserData>(context));


    return Container();
  }
}

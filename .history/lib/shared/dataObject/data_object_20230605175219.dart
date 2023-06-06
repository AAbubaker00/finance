import 'package:valuid/models/account/account.dart';
import 'package:valuid/models/portfolio/portfolio.dart';
import 'package:valuid/models/quote/quote.dart';
import 'package:valuid/shared/dividends/dividends.dart';
import 'package:valuid/shared/earnings/earnings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DataObject {
  DataObject();

  BuildContext context;

  List<Dividends> dividends = [];
  List<Earnings?> earnings = [];

  GlobalKey<NavigatorState> key;
  Function changePage;
  int pageindex;

  List<PortfolioObject> portfolios = [];
  List<QuoteObject> watchlist = [];
  PortfolioObject? onPortfolio;
  AccountObject account;
  QuoteObject onHolding;

  String lastCalenderUpdate = '';
  String userCurrency = '';
  String userCurrencySymbol = '';
  String sort = 'A-Z';

  double height;
  double width;

  bool isLoaded = true;

  List displayHolding = [];

  User user;

  DocumentSnapshot? oldDoc;

  DataObject.fromMap(Map _data) : lastCalenderUpdate = _data['lastCalenderUpdate'];

  dataObjectToMap(DataObject _data) {
    List<Map> dividendsToMap = [];

    if (_data.dividends != null && _data.dividends.isNotEmpty) {
      for (var dividend in _data.dividends) {
        dividendsToMap.add(Dividends().dividendsToMap(dividend));
      }
    }

    List<Map> earningsToMap = [];

    if (_data.earnings != null && _data.earnings.isNotEmpty) {
      for (var earning in _data.earnings) {
        earningsToMap.add(Earnings().earningsToMap(earning));
      }
    }

    return {
      'dividends': dividendsToMap,
      'earnings': earningsToMap,
      'lastCalenderUpdate': _data.lastCalenderUpdate
    };
  }
}

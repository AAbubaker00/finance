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

  late BuildContext context;

  late List<Dividends> dividends = [];
  late List<Earnings?> earnings = [];

  late GlobalKey<NavigatorState> key;
  late Function changePage;
  late int pageindex;

  late List<PortfolioObject> portfolios = [];
  late List<QuoteObject> watchlist = [];
  late PortfolioObject? onPortfolio;
  late AccountObject account;
  late QuoteObject onHolding;

  late String lastCalenderUpdate = '';
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

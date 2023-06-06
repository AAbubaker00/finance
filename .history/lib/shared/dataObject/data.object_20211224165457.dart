import 'package:flutter/cupertino.dart';

class DataObject {
  String userName;
  var themeMode;
  List portfolios;
  double ratio;
  Map parseData;
  var baseCurrency;
  double width;
  double height;
  BuildContext context;
  Map originalData;
  Map rates;

  DataObject.fromMap(Map _data)
      :    userName = data['userDetails']['userName'],
        userEmail = data['userDetails']['userEmail'],
        portfolios = data['portfolios'];
        baseC = 'USD'; //data['userDetails']['baseCurrency'];
        baseCurrency = MarketUpdate(baseC).getCurrencySymbol()['symbol'];
        mainData = data['initalData'];
        rates = data['rates'];


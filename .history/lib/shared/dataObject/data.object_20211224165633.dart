import 'package:flutter/cupertino.dart';

class DataObject {
  String 
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
      :    userName = _data['userDetails']['userName'],
        userEmail = _data['userDetails']['userEmail'],
        portfolios = _data['portfolios'],
        baseCurrency = MarketUpdate(baseC).getCurrencySymbol()['symbol'],
        mainData = _data['initalData'],
        rates = _data['rates'];

}


class User{
  String name;
  String email;

  user.from
}
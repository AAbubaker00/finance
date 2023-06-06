import 'package:flutter/cupertino.dart';

class DataObject {
  String userName;
  var themeMode;
  List portfolios;
  double ratio;
  Map data;
  var baseCurrency;
  double width;
  double height;
  BuildContext context;
  Map originalData;


  DataObject.fromMap(Map _data) : 
  userName = _data['userName'];



  
}

import 'package:flutter/cupertino.dart';

class DataObject {
  var userName;
  var themeMode;
  var portfolios;
  var ratio;
  var data;
  var baseCurrency;
  var width;
  var height;
  BuildContext context;
  var originalData;


  DataObject.fromMap(Map _data) : 
  userName = _data['userName'];



  
}

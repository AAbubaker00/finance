import 'package:flutter/cupertino.dart';

class DataObject {
  final userName;
  final themeMode;
  final portfolios;
  final ratio;
  final data;
  final baseCurrency;
  final width;
  final height;
  final BuildContext context;
  final originalData;


  DataObject.fromMap(Map _data, this.themeMode, this.portfolios, this.ratio, this.data, this.baseCurrency, this.width, this.height, this.context, this.originalData) : userName = _data[]



  
}

import 'dart:js';

import 'package:flutter/cupertino.dart';

class Sort {
  Future searchAssets;

  Sorty(BuildContext context){
    searchAssets = DefaultAssetBundle.of(context).loadString("assets/Exchange/LSE/LSE.json;")
  }
}

import 'dart:js';

import 'package:flutter/cupertino.dart';

class Sort {
  Future searchAssets;

  Sorty(Bui){
    searchAssets = DefaultAssetBundle.of(BuildContext context).loadString("assets/Exchange/LSE/LSE.json;")
  }
}

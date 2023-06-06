import 'dart:js';

import 'package:flutter/cupertino.dart';

class Sort {
  Future searchAssets;

  Sorty(){
    searchAssets = DefaultAssetBundle.of(BuildContext context).loadString(key)
  }
}

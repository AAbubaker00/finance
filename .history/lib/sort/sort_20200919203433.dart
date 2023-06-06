import 'package:flutter/material.dart';
import 'dart:convert';

class Sort {
  Future searchAssets;

  Sort(BuildContext context) {
    searchAssets = DefaultAssetBundle.of(context)
        .loadString("assets/Exchanges/LSE/LSE.json");
    
    searchAssets
    print(dataJson);
  }
}

import 'package:flutter/material.dart';
import 'dart'

class Sort {
  Future searchAssets;

  Sorty(BuildContext context) {
    searchAssets = DefaultAssetBundle.of(context)
        .loadString("assets/Exchange/LSE/LSE.json;");
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';

class Sort {
  Future searchAssets;

  Lis

  Sort(BuildContext context) {
    searchAssets = DefaultAssetBundle.of(context)
        .loadString("assets/Exchanges/LSE/LSE.json");

    searchAssets.then((d) => {
      s
    });
    print(dataJson);
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';

class Sort {
  Future searchAssets;

  Map<String, dynamic> data;

  Sort(BuildContext context) {
    searchAssets = DefaultAssetBundle.of(context)
        .loadString("assets/Exchanges/LSE/LSE.json");

    searchAssets.then((d) => {
      data = json.decode(d),
      print(data["Name"])
    });

  }
}

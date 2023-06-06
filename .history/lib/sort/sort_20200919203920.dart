import 'package:flutter/material.dart';
import 'dart:convert';

class Sort {
  Future searchAssets;

  Map<Stringdynamic> data;

  Sort(BuildContext context) {
    searchAssets = DefaultAssetBundle.of(context)
        .loadString("assets/Exchanges/LSE/LSE.json");

    searchAssets.then((d) => {
      data = json.decode(d)
    });

    print(data);
  }
}

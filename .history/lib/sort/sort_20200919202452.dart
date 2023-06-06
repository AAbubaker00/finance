import 'package:flutter/material.dart';
import 'dart:convert';

class Sort {
  Future searchAssets;

  Sort(BuildContext context) {
    searchAssets = DefaultAssetBundle.of(context)
        .loadString("assets/Exchange/LSE/LSE.json");

    //print(searchAssets);
  }
}

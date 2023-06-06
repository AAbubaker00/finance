import 'package:finance/models/LSE.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

class Sort {
  Future searchAssets;

  List<LSE> data = List<LSE>();

  Sort(BuildContext context) {
    parseJson();
  }

  Future<String> _loadFromAssets() async {
    return await rootBundle.loadString("assets/Exchanges/LSE/LSE.json");
  }

  Future parseJson() async {
    String jsonString = await _loadFromAssets();
    final jsonResponse = jsonDecode(jsonString);

    print(jsonResponse['Name']);
  }
}

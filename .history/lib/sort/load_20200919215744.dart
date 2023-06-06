import 'package:finance/models/LSE.dart';
import 'package:finance/models/offline_data/offlinemode.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

class Sort {
  Future searchAssets;

  List<OfflineData> data = List<OfflineData>();

  Sort(BuildContext context) {
    parseJson();
  }

  Future<String> _loadFromAssets() async {
    return await rootBundle.loadString("assets/Exchanges/LSE/LSE.json");
  }

  Future parseJson() async {
    String jsonString = await _loadFromAssets();
    final jsonResponse = jsonDecode(jsonString);

    for (var q in jsonResponse) {
      data.add(OfflineData.fromJson(q));
    }
  }
}

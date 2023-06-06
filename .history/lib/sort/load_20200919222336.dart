import 'package:finance/models/LSE.dart';
import 'package:finance/models/offline_data/offlinemode.dart';
import 'package:finance/pages/search.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

class LoadData {
  Future searchAssets;

  List<OfflineData> data = List<OfflineData>();

  LoadData(BuildContext context) {
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

    Search(data);
  }

  List<OfflineData> getOfflineDataJson() {
    return data;
  }
}

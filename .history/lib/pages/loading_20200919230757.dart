import 'dart:convert';

import 'package:finance/models/offline_data/offlinemode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List<OfflineData> data = List<OfflineData>();
  Future searchAssets;

  @override
  void initState() {
    super.initState();
    parseJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Loading..."),
    );
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

    Navigator.pushReplacementNamed(context, '/search', arguments: {
      
    });
  }
}

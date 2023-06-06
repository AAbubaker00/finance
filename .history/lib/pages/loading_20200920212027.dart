import 'dart:convert';

import 'package:finance/models/offline_data/storeddata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart' as csv; 
import 'dart:convert';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List<StoredData> data = List<StoredData>();
  Future searchAssets;

  @override
  void initState() async {
    super.initState();

    http.Response response = await http.get(
        "https://query1.finance.yahoo.com/v7/finance/download/AAPL?period1=1569010146&period2=1600632546&interval=1d&events=history");
    List<List<dynamic>> csvData = csv.cs
    
    
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
      data.add(StoredData.fromJson(q));
    }

    Navigator.pushReplacementNamed(context, '/search',
        arguments: {'storeddata': data});
  }
}

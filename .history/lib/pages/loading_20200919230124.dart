import 'dart:convert';

import 'package:finance/models/offline_data/offlinemode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future searchAssets;

  List<OfflineData> data = List<OfflineData>();


  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Loading..."),
    );
  }
}

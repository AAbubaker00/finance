import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

class Sort {
  Future searchAssets;

  Map<String, dynamic> data;

  Sort(BuildContext context) {}

  Future<String> _loadFromAssets() async {
    return await rootBundle.loadString("assets/Exchanges/LSE/LSE.json");
    
  }
}

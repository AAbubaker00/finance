import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';
class MarketChangeNotifier with ChangeNotifier {
  Stream<List<String>> get marketChange {

    return Stream.value(value)['ddd'];
  }
}

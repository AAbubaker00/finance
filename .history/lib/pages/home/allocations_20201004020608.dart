import 'package:flutter/material.dart';

class Allocations extends StatefulWidget {
  Map<dynamic, dynamic> userStocks;

  Allocations(this.userStocks) {
    _AllocationsState().stocks = userStocks;
  }

  @override
  _AllocationsState createState() => _AllocationsState();
}

class _AllocationsState extends State<Allocations> {
  LMap<dynamic, dynamic> stocks = {};

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 1,
    );
  }
}

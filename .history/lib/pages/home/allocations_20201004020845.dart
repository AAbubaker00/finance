import 'package:flutter/material.dart';

class Allocations extends StatefulWidget {
  List<Map<dynamic, dynamic>> userStocks;

  Allocations(this.userStocks) {
    _AllocationsState().stocks = userStocks;
  }

  @override
  _AllocationsState createState() => _AllocationsState();
}

class _AllocationsState extends State<Allocations> {
  List<Map<dynamic, dynamic>> stocks = [{}];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 1,
      children: stocks.map((e) {
        return Container(
          child: Text(""),
        )
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';

class Allocations extends StatefulWidget {
  Map<dynamic, dynamic> Userstocks;

  Allocations(this.Userstocks

  @override
  _AllocationsState createState() => _AllocationsState();
}

class _AllocationsState extends State<Allocations> {
  Map<dynamic, dynamic> stocks = {};

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 1,
      children: [],
    );
  }
}

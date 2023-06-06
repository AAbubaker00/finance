import 'package:Onvesting/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvesting/shared/dataObject/data_object.dart';
import 'package:flutter/material.dart';

class HoldingsPage extends StatefulWidget {
  final DataObject dataObject;
  final Map onPortfolio;

  HoldingsPage({Key key, this.dataObject, this.onPortfolio}) : super(key: key);

  @override
  State<HoldingsPage> createState() => _HoldingsPageState();
}

class _HoldingsPageState extends State<HoldingsPage> {
  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      appBarTitle: 'Holdings',
      dataObject: widget.dataObject,
      body: ,
    );
  }
}

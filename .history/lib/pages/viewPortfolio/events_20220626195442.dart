import 'package:Onvest/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvest/shared/dataObject/data_object.dart';
import 'package:flutter/material.dart';

class PortfolioEvents extends StatefulWidget {
  final DataObject dataObject;

  const PortfolioEvents({Key key, this.dataObject}) : super(key: key);

  @override
  State<PortfolioEvents> createState() => Portfolio_EventsState();
}

class Portfolio_EventsState extends State<PortfolioEvents> {
  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      dataObject: widget.dataObject,
      appBarTitle: 'Activity',
      
    );
  }
}

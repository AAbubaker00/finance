import 'package:Onvest/shared/TextStyle/customTextStyles.dart';
import 'package:Onvest/shared/dataObject/data_object.dart';
import 'package:Onvest/shared/decoration/customDecoration.dart';
import 'package:Onvest/shared/themes/themes.dart';
import 'package:Onvest/extensions/stringExt.dart' as str;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

double earningsPecentage = 0.0;
double earnings = 0.0;

class HoldingViewCard extends StatelessWidget {
  final Map holding;
  final DataObject dataObject;
  final String returnOption;
  final bool isPrivate;

  const HoldingViewCard({Key key, this.holding, this.dataObject, this.returnOption, this.isPrivate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Investment {
  Widget getInvestment(
      {holding, theme, DataObject dataObject, context, String returnOption, bool isPrivate}) {
    getReturnResult(holding, returnOption);

    return  }

  getReturnResult(var holding, String returnOption) {
    switch (returnOption) {
      case 'Max':
        earnings = holding['change'];
        earningsPecentage = holding['percDiff'];
        break;
      case '24H':
        earnings = holding['shares'] * holding['marketData']['quote']['regularMarketChange'];
        earningsPecentage = holding['marketData']['quote']['regularMarketChangePercent'];
        break;
      case '1y':
        break;
      case '4y':
        break;
    }
  }
}

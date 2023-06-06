import 'package:Valuid/models/quote/quote.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/extensions/stringExt.dart' as str;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

double earningsPecentage = 0.0;
double earnings = 0.0;

class HoldingViewCard extends StatelessWidget {
  final QuoteObject holding;
  final DataObject dataObject;
  final String returnOption;
  final bool isCoin;
  final bool isCommodiy;

  const HoldingViewCard(
      {Key key,
      this.holding,
      this.dataObject,
      this.returnOption,
      this.isCoin = false,
      this.isCommodiy = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    getReturnResult(holding, returnOption);

    return Ink(
      decoration: CustomDecoration().curvedBaseContainerDecoration,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 17),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Text(
                    holding.name,
                    style: CustomTextStyles(dataObject.context).portfolioNameStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                holding.value > 1000000000
                    ? '${dataObject.userCurrencySymbol}${NumberFormat.compact().format(holding['value'])}'
                    : '${dataObject.userCurrencySymbol}${holding['value'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: CustomTextStyles(dataObject.context)
                    .holdingValueStyle
                    .copyWith(fontWeight: FontWeight.w600),
                softWrap: true,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    holding['shares'] > 10000000
                        ? '${NumberFormat.compact().format(holding['shares'])} Shares '
                        : '${holding['shares'].toStringAsFixed(0).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} Shares',
                    style: CustomTextStyles(dataObject.context).holdingSubValueStyle),
                Text(
                    earnings < 0
                        ? '-${dataObject.userCurrencySymbol}${(earnings * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(earningsPecentage * -1).toStringAsFixed(2).addCommas()}%)'
                        : '+${dataObject.userCurrencySymbol}${(earnings).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${earningsPecentage.toStringAsFixed(2).addCommas()}%)',
                    style: CustomTextStyles(dataObject.context).holdingSubValueStyle.copyWith(
                        fontWeight: FontWeight.w700, color: earnings > 0 ? greenVarient : redVarient)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getReturnResult(var holding, String returnOption) {
    switch (returnOption) {
      case 'Max':
        earnings = holding['change'];
        earningsPecentage = holding['percDiff'];
        break;
      case '24H':
        earnings = holding['dailyChange'];
        earningsPecentage = holding['marketData']['quote']['regularMarketChangePercent'];
        break;
      case '1y':
        break;
      case '4y':
        break;
    }
  }
}

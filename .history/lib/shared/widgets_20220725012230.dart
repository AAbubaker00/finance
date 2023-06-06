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
  final Map holding;
  final DataObject dataObject;
  final String returnOption;
  final bool isPrivate;
  final bool isCoin;

  const HoldingViewCard({Key key, this.holding, this.dataObject, this.returnOption, this.isPrivate, this.isCoin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    getReturnResult(holding, returnOption);

    return Ink(
      decoration: CustomDecoration(dataObject.theme).curvedBaseContainerDecoration,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    holding['marketData']['quote'].containsKey('longName')
                        ? "${holding['marketData']['quote']['longName'].toString().removeStr()}"
                        : holding['marketData']['quote']['shortName'].toString().removeStr(),
                    style: CustomTextStyles(dataObject.theme, dataObject.context).portfolioNameStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                isPrivate
                    ? '...'
                    : holding['value'] > 1000000000
                        ? '${dataObject.userCurrencySymbol}${NumberFormat.compact().format(holding['value'])}'
                        : '${dataObject.userCurrencySymbol}${holding['value'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: CustomTextStyles(dataObject.theme, dataObject.context).holdingValueStyle,
                softWrap: true,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Text(
                    //   '${holding['marketData']['quote']['symbol']} - ',
                    //   style: CustomTextStyles(dataObject.theme, context)
                    //       .holdingSubValueStyle
                    //       .copyWith(color: UserThemes(dataObject.theme).textColor),
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    Text(
                        holding['shares'] > 1000000
                            ? '${NumberFormat.compact().format(holding['shares'])} SHARES '
                            : '${holding['shares'].toStringAsFixed(0).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} SHARES',
                        style: CustomTextStyles(dataObject.theme, dataObject.context).holdingSubValueStyle),
                  ],
                ),
                Ink(
                  // padding: EdgeInsets.all(2),
                  // decoration: CustomDecoration(dataObject.theme).curvedContainerDecoration.copyWith(
                  //     border: Border.all(
                  //         color:
                  //             earnings > 0 ? UserThemes(dataObject.theme).greenVarient : UserThemes(dataObject.theme).redVarient),
                  //     color: earnings > 0 ? UserThemes(dataObject.theme).greenVarient : UserThemes(dataObject.theme).redVarient),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                        isPrivate
                            ? '${dataObject.userCurrencySymbol}...'
                            : earnings < 0
                                ? '-${dataObject.userCurrencySymbol}${(earnings * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(earningsPecentage * -1).toStringAsFixed(2)}%)'
                                : '+${dataObject.userCurrencySymbol}${(earnings).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${earningsPecentage.toStringAsFixed(2)}%)',
                        style: CustomTextStyles(dataObject.theme, dataObject.context)
                            .holdingSubValueStyle
                            .copyWith(
                                fontWeight: FontWeight.w700,
                                color: earnings > 0
                                    ? UserThemes(dataObject.theme).greenVarient
                                    : UserThemes(dataObject.theme).redVarient)),
                  ),
                ),
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

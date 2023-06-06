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
  final 

  const HoldingViewCard({Key key, this.holding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Investment {
  Widget getInvestment(
      {holding,
      theme,
      DataObject dataObject,
      context,
      Function function,
      String returnOption,
      bool isPrivate}) {
    getReturnResult(holding, returnOption);

    return Ink(
      decoration: CustomDecoration(theme).curvedBaseContainerDecoration,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
                    style: CustomTextStyles(theme, context).portfolioNameStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                isPrivate
                    ? '...'
                    : holding['value'] > 1000000000
                        ? '$datacurrencySymbol${NumberFormat.compact().format(holding['value'])}'
                        : '$currencySymbol${holding['value'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: CustomTextStyles(theme, context).holdingValueStyle,
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
                    //   style: CustomTextStyles(theme, context)
                    //       .holdingSubValueStyle
                    //       .copyWith(color: UserThemes(theme).textColor),
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    Text(
                        holding['shares'] > 1000000
                            ? '${NumberFormat.compact().format(holding['shares'])} SHARES '
                            : '${holding['shares'].toStringAsFixed(0).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} SHARES',
                        style: CustomTextStyles(theme, context).holdingSubValueStyle),
                  ],
                ),
                Ink(
                  // padding: EdgeInsets.all(2),
                  // decoration: CustomDecoration(theme).curvedContainerDecoration.copyWith(
                  //     border: Border.all(
                  //         color:
                  //             earnings > 0 ? UserThemes(theme).greenVarient : UserThemes(theme).redVarient),
                  //     color: earnings > 0 ? UserThemes(theme).greenVarient : UserThemes(theme).redVarient),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                        isPrivate
                            ? '$currencySymbol...'
                            : earnings < 0
                                ? '-$currencySymbol${(earnings * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(earningsPecentage * -1).toStringAsFixed(2)}%)'
                                : '+$currencySymbol${(earnings).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${earningsPecentage.toStringAsFixed(2)}%)',
                        style: CustomTextStyles(theme, context).holdingSubValueStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            color: earnings > 0
                                ? UserThemes(theme).greenVarient
                                : UserThemes(theme).redVarient)),
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

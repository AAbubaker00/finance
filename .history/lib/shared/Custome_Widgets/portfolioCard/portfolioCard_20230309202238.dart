import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Valuid/extensions/stringExt.dart';

class PortfolioCard extends StatelessWidget {
  final DataObject dataObject;
  final Map portfolio;
  final int index;

  const PortfolioCard({Key key, this.dataObject, this.portfolio, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(circularRadius),
        color: Color(0xFF083958), .withOpacity(.1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(portfolio['name'].toString(),
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles(dataObject.theme, dataObject.context).portfolioNameStyle.copyWith(
                        fontWeight: FontWeight.w800,
                      )),
              Text(
                  portfolio['portfolioValue'] > 1000000000
                      ? '${dataObject.userCurrencySymbol}${NumberFormat.compact().format(portfolio['portfolioValue'])}'
                      : '${dataObject.userCurrencySymbol}${portfolio['portfolioValue'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}', //${p['baseCurrency']}
                  style:
                      CustomTextStyles(dataObject.theme, dataObject.context).calenderDateTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Return',
                        style: CustomTextStyles(dataObject.theme, dataObject.context)
                            .portfolioNameStyle
                            .copyWith(color: UserThemes(dataObject.theme).textColor.withOpacity(.7))),
                    Row(
                      children: [
                        Text(
                            ((portfolio['change'] >= 10000000 || portfolio['change'] <= -10000000)
                                    ? (portfolio['change'] >= 0)
                                        ? '+${dataObject.userCurrencySymbol}${NumberFormat.compact().format(portfolio['change'])}'
                                        : '-${dataObject.userCurrencySymbol}${(NumberFormat.compact().format((portfolio['change'] * -1)))} '
                                    : (portfolio['change'] >= 0)
                                        ? '+${dataObject.userCurrencySymbol}${double.parse(portfolio['change'].toString()).toStringAsFixed(2).addCommas()}'
                                        : '-${dataObject.userCurrencySymbol}${(double.parse(portfolio['change'].toString()) * -1).toStringAsFixed(2).addCommas()}') +
                                ' (${(portfolio['returnPercentage']).toStringAsFixed(2)}%)',
                            style: CustomTextStyles(dataObject.theme, dataObject.context)
                                .portfolioNameStyle
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: (portfolio['change'] > 0)
                                        ? UserThemes(dataObject.theme).greenVarient
                                        : UserThemes(dataObject.theme).redVarient)),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Invested',
                          style: CustomTextStyles(dataObject.theme, dataObject.context)
                              .portfolioNameStyle
                              .copyWith(color: UserThemes(dataObject.theme).textColor.withOpacity(.7))),
                      Text(
                          '${dataObject.userCurrencySymbol}${double.parse(portfolio['investedValue'].toString()).toStringAsFixed(2).addCommas()}',
                          style: CustomTextStyles(dataObject.theme, dataObject.context).portfolioNameStyle),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

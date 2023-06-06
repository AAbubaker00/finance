import 'package:Valuid/models/portfolio/portfolio.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Valuid/extensions/stringExt.dart';

class PortfolioCard extends StatelessWidget {
  final DataObject dataObject;
  final PortfolioObject portfolio;
  final int index;

  const PortfolioCard({Key key, this.dataObject, this.portfolio, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('sds');
    return Ink(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(color: VarientColours().profColors[index].withOpacity(.05)),
        borderRadius: BorderRadius.circular(circularRadius),
        color: VarientColours().profColors[index].withOpacity(.1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(portfolio.name,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles(dataObject.context).portfolioNameStyle.copyWith(
                        fontWeight: FontWeight.w800,
                      )),
              Text(
                  portfolio.value > 1000000000
                      ? '${dataObject.userCurrencySymbol}${NumberFormat.compact().format(portfolio.value)}'
                      : '${dataObject.userCurrencySymbol}${portfolio.value.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}', //${p['baseCurrency']}
                  style: CustomTextStyles(dataObject.context)
                      .pageHeaderStyle
                      .copyWith(fontWeight: FontWeight.w500))
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
                    Text('RETURN',
                        style: CustomTextStyles(dataObject.context)
                            .tableHeaderStyle
                            .copyWith(color: textColor.withOpacity(.6))),
                    Row(
                      children: [
                        Text(
                            ((portfolio.change >= 10000000 || portfolio.change <= -10000000)
                                    ? (portfolio.change >= 0)
                                        ? '+${dataObject.userCurrencySymbol}${NumberFormat.compact().format(portfolio.change)}'
                                        : '-${dataObject.userCurrencySymbol}${(NumberFormat.compact().format((portfolio.change * -1)))} '
                                    : (portfolio.change >= 0)
                                        ? '+${dataObject.userCurrencySymbol}${double.parse(portfolio.change.toString()).toStringAsFixed(2).addCommas()}'
                                        : '-${dataObject.userCurrencySymbol}${(double.parse(portfolio.change.toString()) * -1).toStringAsFixed(2).addCommas()}') +
                                ' (${(portfolio.changePercent).toStringAsFixed(2)}%)',
                            style: CustomTextStyles(dataObject.context).portfolioNameStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: (portfolio.change > 0) ? greenVarient : redVarient)),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('INVESTED',
                          style: CustomTextStyles(dataObject.context)
                              .tableHeaderStyle
                              .copyWith(color: textColor.withOpacity(.6))),
                      Text(
                          '${dataObject.userCurrencySymbol}${double.parse(portfolio.invested.toString()).toStringAsFixed(2).addCommas()}',
                          style: CustomTextStyles(dataObject.context).portfolioNameStyle),
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

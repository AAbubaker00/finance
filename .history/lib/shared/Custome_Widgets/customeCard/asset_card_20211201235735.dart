import 'package:Strice/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Strice/extensions/stringExt.dart' as str;

class CustomeHoldingCard extends StatelessWidget {
  final Function editHoldingFunction;
  final Function viewHoldingFunction;
  final dynamic stock;
  final double ratio;
  final bool isPrivate;
  final String currencySymbol;
  final String baseCurrency;
  final themeMode;
  final int index;
  final bool isLast;

  CustomeHoldingCard(this.editHoldingFunction, this.stock, this.ratio, this.isPrivate, this.currencySymbol,
      this.baseCurrency, this.themeMode, this.index, this.isLast, this.viewHoldingFunction);

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    final TextStyle headerStyle =
        TextStyle(color: UserThemes(themeMode).textColorVarient, fontWeight: FontWeight.w400);
    final TextStyle sectionHeaderStyle = TextStyle(
      color: UserThemes(themeMode).textColorVarient,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );

    return InkWell(
      onLongPress: () {
        editHoldingFunction(stock);
      },
      onTap: () => viewHoldingFunction(
          stock), //Navigator.pushNamed(context, '/holding', arguments: stock),//viewHoldingFunction(stock),
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Units().circularRadius),
      ),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: UserThemes(themeMode).summaryColour, // .withOpacity(.8),
          borderRadius: BorderRadius.circular(Units().circularRadius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          "${stock['marketData']['quote']['longName'].toString().removeStr()}",
                          style: TextStyle(
                              fontSize: 22,
                              color: UserThemes(themeMode).textColor,
                              fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 30,
                            ),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text('$currencySymbol',
                                  style: TextStyle(
                                      color: UserThemes(themeMode).textColorVarient,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w300)),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              isPrivate
                                  ? '--.--'
                                  : stock['value'] > 1000000000
                                      ? '${NumberFormat.compact().format(stock['value'])}'
                                      : '${stock['value'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                              style: TextStyle(
                                  color: UserThemes(themeMode).textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                            isPrivate
                                ? '--.--'
                                : stock['shares'] > 1000000
                                    ? '${NumberFormat.compact().format(stock['shares'])} SHARES'
                                    : '${stock['shares'].toStringAsFixed(0).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} SHARES',
                            style: TextStyle(
                                color: UserThemes(themeMode).textColorVarient,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                      ),
                      Row(
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                                isPrivate
                                    ? '--.--'
                                    : stock['change'] < 0
                                        ? '-$currencySymbol${(stock['change'] * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${stock['percDiff'].toStringAsFixed(2)}%)'
                                        : '+$currencySymbol${(stock['change']).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (+${stock['percDiff'].toStringAsFixed(2)}%)',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: double.parse(stock['change'].toString()) < 0
                                        ? UserThemes(themeMode).redVarient
                                        : UserThemes(themeMode).greenVarient)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

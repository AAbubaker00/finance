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
            Container(
              child: stock['logo'] == null
                  ? Padding(
                      padding: EdgeInsets.only(right: 13, top: 13, bottom: 13, left: 3),
                      child: Container(
                        height: 90, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
                        width: 50,
                        decoration: BoxDecoration(
                          color: UserThemes(themeMode).backgroundColour,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "${stock['symbol']}",
                            style: TextStyle(
                                color: UserThemes(themeMode).textColor, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(stock['logo'],
                        errorBuilder: (context, error, stackTrace) => Container(
                              height: 48, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
                              width: 48, //(ratio <= 1.6) ? _width * 0.045 : _width * 0.11,
                              decoration: BoxDecoration(
                                color: UserThemes(themeMode).backgroundColour,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Text(
                                    "${stock['symbol']}",
                                    style: TextStyle(
                                        color: UserThemes(themeMode).textColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                        height: 48, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
                        width: 4, //(ratio <= 1.6) ? _width * 0.045 : _width * 0.11,
                        fit: stock['logoRatio'] != 1 ? BoxFit.fill : BoxFit.fill),
                  ),
            ),
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
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          isPrivate
                              ? '--.--'
                              : stock['value'] > 1000000000
                                  ? '$currencySymbol${NumberFormat.compact().format(stock['value'])}'
                                  : '$currencySymbol${stock['value'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                          style: TextStyle(
                              color: UserThemes(themeMode).textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                        ),
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

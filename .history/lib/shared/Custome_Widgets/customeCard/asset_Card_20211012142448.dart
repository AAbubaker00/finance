import 'package:Strice/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Strice/extensions/stringExt.dart' as str;

class CustomeAssetCard extends StatelessWidget {
  final Function editHoldingFunction;
  final Function viewHoldingFunction;
  final dynamic stock;
  final double ratio;
  final bool isPrivate;
  final String currencySymbol;
  final String baseCurrency;
  final isDark;
  final int index;
  final bool isLast;

  CustomeAssetCard(this.editHoldingFunction, this.stock, this.ratio, this.isPrivate, this.currencySymbol,
      this.baseCurrency, this.isDark, this.index, this.isLast, this.viewHoldingFunction);

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    final TextStyle headerStyle =
        TextStyle(color: DarkTheme(isDark).textColorVarient, fontWeight: FontWeight.w400);
    final TextStyle sectionHeaderStyle = TextStyle(
      color: DarkTheme(isDark).textColorVarient,
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
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: isLast ? Colors.transparent : DarkTheme(isDark).border))),
        child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: Edge
                child: stock['logo'] == null
                    ? Padding(
                        padding: EdgeInsets.only(right: 13, top: 13, bottom: 13, left: 3),
                        child: Container(
                          height: 160, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
                          width: 41,
                          decoration: BoxDecoration(
                            color: DarkTheme(isDark).backgroundColour,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "${stock['symbol']}",
                              style: TextStyle(
                                  color: DarkTheme(isDark).textColor, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        // color: Colors.transparent,
                        padding: EdgeInsets.only(right: 13, top: 13, bottom: 13, left: 3),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(stock['logo'],
                              errorBuilder: (context, error, stackTrace) => Container(
                                    height: 160, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
                                    width: 41, //(ratio <= 1.6) ? _width * 0.045 : _width * 0.11,
                                    decoration: BoxDecoration(
                                      color: DarkTheme(isDark).backgroundColour.withOpacity(.7),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Center(
                                        child: Text(
                                          "${stock['symbol']}",
                                          style: TextStyle(
                                              color: DarkTheme(isDark).textColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                              height: 160, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
                              width: 41, //(ratio <= 1.6) ? _width * 0.045 : _width * 0.11,
                              fit: stock['logoRatio'] != 1 ? BoxFit.contain : BoxFit.fill),
                        ),
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
                                fontSize: 18,
                                color: DarkTheme(isDark).textColor,
                                fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              isPrivate
                                  ? '--.--'
                                  : stock['value'] > 1000000000
                                      ? '$currencySymbol${NumberFormat.compact().format(stock['value'])}'
                                      : '$currencySymbol${stock['value'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                              style: TextStyle(
                                color: DarkTheme(isDark).textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
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
                                      ? '${NumberFormat.compact().format(stock['shares'])} SHARES @ $currencySymbol${stock['avgPrice']}'
                                      : '${stock['shares'].toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} SHARES @ $currencySymbol${stock['buyPrice']}',
                              style: TextStyle(
                                  color: DarkTheme(isDark).textColorVarient,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15)),
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
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: double.parse(stock['change'].toString()) < 0
                                          ? DarkTheme(isDark).redVarient
                                          : DarkTheme(isDark).greenVarient)),
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
      ),
    );
  }
}

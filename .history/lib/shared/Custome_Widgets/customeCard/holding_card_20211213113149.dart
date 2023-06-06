import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Strice/extensions/stringExt.dart' as str;

class CustomeHoldingCard extends StatelessWidget {
  final dynamic stock;
  final double ratio;
  final bool isPrivate;
  final String currencySymbol;
  final String baseCurrency;
  final themeMode;

  CustomeHoldingCard(this.stock, this.ratio, this.isPrivate, this.currencySymbol,
      this.baseCurrency, this.themeMode, );

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
    

    return Ink(
      padding: EdgeInsets.symmetric(horizontal: 10,),
      decoration: BoxDecoration(
        // color: UserThemes(themeMode).summaryColour, // .withOpacity(.8),
        // borderRadius: BorderRadius.circular(Units().circularRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Padding(
          //   padding: EdgeInsets.only(right: 10),
          //   child: stock['logo'] == null
          //       ? Container(
          //           height: 47, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
          //           width: 46,
          //           decoration: BoxDecoration(
          //             color: UserThemes(themeMode).backgroundColour,
          //             border: Border.all(color: UserThemes(themeMode).seperator),
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           child: Center(
          //             child: Text(
          //               "${stock['symbol']}",
          //               style:
          //                   TextStyle(color: UserThemes(themeMode).textColor, fontWeight: FontWeight.w500),
          //             ),
          //           ),
          //         )
          //       : ClipRRect(
          //           borderRadius: BorderRadius.circular(13.0),
          //           child: Image.network(stock['logo'],
          //               errorBuilder: (context, error, stackTrace) => Container(
          //                     height: 44, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
          //                     width: 43, //(ratio <= 1.6) ? _width * 0.045 : _width * 0.11,
          //                     decoration: BoxDecoration(
          //                       color: UserThemes(themeMode).backgroundColour,
          //                       borderRadius: BorderRadius.circular(13),
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsets.all(5.0),
          //                       child: Center(
          //                         child: Text(
          //                           "${stock['symbol']}",
          //                           style: TextStyle(
          //                               color: UserThemes(themeMode).textColor,
          //                               fontWeight: FontWeight.bold),
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //               height: 44, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
          //               width: 43, //(ratio <= 1.6) ? _width * 0.045 : _width * 0.11,
          //               fit: BoxFit.scaleDown),
          //         ),
          // ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          "${stock['marketData']['quote']['longName'].toString().removeStr()}",
                          style: CustomTextStyles(themeMode).portfolioNameStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                        style: CustomTextStyles(themeMode).holdingValueStyle,
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
                          style: CustomTextStyles(themeMode).holdingSubValueStyle),
                    ),
                    Row(
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                              isPrivate
                                  ? '--.--'
                                  : stock['change'] < 0
                                      ? '-$currencySymbol${(stock['change'] * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(stock['percDiff'] * -1).toStringAsFixed(2)}%)'
                                      : '+$currencySymbol${(stock['change']).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${stock['percDiff'].toStringAsFixed(2)}%)',
                              style: CustomTextStyles(themeMode).holdingSubValueStyle.copyWith(
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
    );
  }
}

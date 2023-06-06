import 'package:Strice/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomeAssetCard extends StatelessWidget {
  final Function editHoldingFunction;
  final dynamic stock;
  final double ratio;
  final isPrivate

  double _height = 0.0, _width = 0.0;


  CustomeAssetCard(this.editHoldingFunction, this.stock, this.ratio);

  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Ink(
      decoration: BoxDecoration(
          color: DarkTheme(isDark).summaryColour,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: DarkTheme(isDark).border)),
      child: InkWell(
        onLongPress: () {
          editHoldingFunction(stock);
        },
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(left: 5, right: 10, top: 10, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  stock['logo'] == null
                      ? Padding(
                          padding: EdgeInsets.only(right: 10.0, left: 5),
                          child: Container(
                            height: (ratio <= 1.6) ? _height * 0.08 : _height * 0.05,
                            width: (ratio <= 1.6) ? _width * 0.06 : _width * 0.1,
                            decoration: BoxDecoration(
                              color: DarkTheme(isDark).backgroundColour.withOpacity(.4),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  "${stock['symbol']}",
                                  style: TextStyle(
                                      color: DarkTheme(isDark).textColor, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(right: 10.0, left: 5),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.network(stock['logo'],
                                  errorBuilder: (context, error, stackTrace) => Container(
                                        height: (ratio <= 1.6) ? _height * 0.09 : _height * 0.05,
                                        width: (ratio <= 1.6) ? _width * 0.07 : _width * 0.1,
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
                                  height: (ratio <= 1.6) ? _height * 0.06 : _height * 0.035,
                                  width: (ratio <= 1.6) ? _width * 0.045 : _width * 0.075,
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${stock['marketData']['quote']['longName']}",
                          style: TextStyle(
                              fontSize: 17, color: DarkTheme(isDark).textColor, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(isPrivate ? '--.--' : '${stock['shares']} SHARES',
                            style: TextStyle(
                                color: DarkTheme(isDark).textColorVarient, fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('INVESTED', style: headerStyle),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            isPrivate
                                ? '--.--'
                                : stock['Invested'] > 100000
                                    ? '$currencySymbol${NumberFormat.compact().format(stock['Invested'])}'
                                    : '$currencySymbol${stock['Invested'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                            style: TextStyle(
                              color: DarkTheme(isDark).textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('RETURN', style: headerStyle),
                      Text(
                          isPrivate
                              ? '--.--'
                              : double.parse(stock['change'].toString()) > 999999.0
                                  ? '$baseCurrency ${NumberFormat.compact().format(stock['change']).toString()}'
                                  : stock['change'] < 0
                                      ? '-$currencySymbol${(stock['change'] * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
                                      : '+$currencySymbol${(stock['change']).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: double.parse(stock['change'].toString()) < 0
                                  ? DarkTheme(isDark).redVarient
                                  : DarkTheme(isDark).greenVarient)),
                      Text(
                        '${stock['percDiff'].toStringAsFixed(2)}%',
                        style: TextStyle(
                            color: double.parse(stock['change'].toString()) < 0
                                ? DarkTheme(isDark).redVarient
                                : DarkTheme(isDark).greenVarient),
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

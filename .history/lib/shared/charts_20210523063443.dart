import 'package:Strice/shared/themes.dart';
import 'package:Strice/shared/update.dart';
import 'package:Strice/extensions/stringExt.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CCharts {
  List cagrData;

  CCharts(this.cagrData, this.invested);

  String inception_date = '';

  getInceptionDae(List stocks) {
    if (stocks.length > 1) {
      stocks.sort((a, b) => DateTime.parse(a['buyDate']).compareTo(DateTime.parse(b['buyDate'])));
      inception_date = stocks[0]['buyDate'];
    } else {
      inception_date = stocks[0]['buyDate'];
    }

    return inception_date;
  }

  setCAGRData(
    String baseCurrency,
    Map rates,
    List stocks,
  ) {
    inception_date = getInceptionDae(stocks);

    for (var stock in stocks) {
      int removeIndex = stock['marketData']['chartData']['max']['timestamp'].indexOf(stock['buyDate']);

      // print('${stock['symbol']} : $removeIndex');

      stock['useTime'] = stock['marketData']['chartData']['max']['timestamp']
          .getRange(removeIndex, stock['marketData']['chartData']['max']['timestamp'].length - 1)
          .toList();
      stock['usePrice'] = stock['marketData']['chartData']['max']['close']
          .getRange(removeIndex, stock['marketData']['chartData']['max']['close'].length - 1)
          .toList();

      // print(stock['useTime']);
    }

    for (var stock in stocks) {
      if (stocks.length > 2) {
        stock['history']
            .sort((a, b) => DateTime.parse(a['filledOn']).compareTo(DateTime.parse(b['filledOn'])));
        stock['history'] = stock['history'].reversed.toList();
      }

      String quote = stock['marketData']['quote']['currency'].toString().capitalizeAll();
      double cvrtRate = Update(baseCurrency).getRate(rates, quote);

      for (var date in stock['useTime']) {
        var lastEvent = stock['history'].firstWhere(
            (event) =>
                DateTime.parse(event['filledOn']).isBefore(DateTime.parse(date)) || event['filledOn'] == date,
            orElse: () => null);

        if (lastEvent == null) {
          // print(lastEvent);
        } else {
          try {
            // print(lastEvent);
            double assetTotalShares = double.parse(lastEvent['outstandingShares'].toString());
            double assetAveragePrice = double.parse(lastEvent['averagePrice'].toString()) * cvrtRate;

            int dateIndex = stock['useTime'].indexOf(date);
            double priceAtDateIndex =
                (stock['usePrice'][dateIndex] / (stock['exchange'] == 'LSE' ? 100 : 1)) * cvrtRate;

            if (cagrData.isEmpty) {
              cagrData.add({
                'date': date,
                'value': ((priceAtDateIndex - assetAveragePrice) * assetTotalShares) +
                    (assetTotalShares * assetAveragePrice),
                'invested': assetTotalShares * assetAveragePrice,
                'assets': 1
              });
            } else {
              var isEventExist = cagrData.firstWhere((event) => event['date'] == date, orElse: () => null);

              if (isEventExist == null) {
                cagrData.add({
                  'date': date,
                  'value': ((priceAtDateIndex - assetAveragePrice) * assetTotalShares) +
                      (assetTotalShares * assetAveragePrice),
                  'invested': assetTotalShares * assetAveragePrice,
                  'assets': 1
                });
              } else {
                int eventIndex = cagrData.indexOf(isEventExist);

                try {
                  cagrData[eventIndex]['value'] +=
                      ((priceAtDateIndex - assetAveragePrice) * assetTotalShares) +
                          (assetTotalShares * assetAveragePrice);
                  cagrData[eventIndex]['invested'] += (assetTotalShares * assetAveragePrice);
                  cagrData[eventIndex]['assets'] += 1;
                } on Exception catch (e) {
                  // print(e);
                }
              }
            }
          } catch (e) {
            // TODO

            // print(e);
          }
        }
      }
    }

    cagrData.sort((a, b) => DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])));

    cagrData = cagrData
        .where((plot) => !(cagrData.indexOf(plot) != 0 &&
            cagrData.indexOf(plot) < cagrData.length - 1 &&
            (plot['assets'] < cagrData[cagrData.indexOf(plot) + 1]['assets'] &&
                plot['assets'] < cagrData[cagrData.indexOf(plot) - 1]['assets'])))
        .toList();

    return cagrData;
    // print(cagrData);
  }

  List<FlSpot> cagrDataTable = [];
  // ignore: non_constant_identifier_names
  List<FlSpot> cagarData_interval = [];

  bool isPlotsLoaded = false;
  double interval = 0.0;
  double index = 0.0;
  double crossPoint = 0.0;
  double invested = 0.0;

  LineChart getCAGRChart(int timeframInterval, bool isDark, String baseCurrency, bool isPrivate) {
    if (!isPlotsLoaded) {
      for (var plot in cagrData) {
        cagrDataTable.add(FlSpot(index, double.parse(plot['value'].toStringAsFixed(2))));
        index++;

        if (interval == 0.0) {
          interval = double.parse(plot['value'].toString());
        } else {
          interval = (interval > double.parse(plot['value'].toString()))
              ? interval
              : double.parse(plot['value'].toString());
        }
      }

      // if (mounted) {
      //   setState(() {
      //     // print('plot sec');
      //     isPlotsLoaded = true;
      //   });
      // }
    }

    for (var plot in cagrData) {
      if (interval == 0.0) {
        interval = double.parse(plot['value'].toString());
      } else {
        interval = (interval > double.parse(plot['value'].toString()))
            ? interval
            : double.parse(plot['value'].toString());
      }
    }

    if (cagrDataTable.length < timeframInterval) {
      cagarData_interval = cagrDataTable;
    } else {
      if (timeframInterval == 1) {
        cagarData_interval = cagrDataTable;
      } else {
        cagrDataTable = cagrDataTable.reversed.toList();
        cagarData_interval = cagrDataTable.getRange(0, timeframInterval).toList();
        cagrDataTable = cagrDataTable.reversed.toList();
      }
    }

    interval = interval / 10;

    // print(interval);
    return LineChart(LineChartData(
      gridData: FlGridData(
        show: false,
        horizontalInterval: interval == 0.0 ? 1 : interval,
        getDrawingHorizontalLine: (value) =>
            FlLine(color: DarkTheme(isDark).border.withOpacity(.5), strokeWidth: 1),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            getTextStyles: (value) => TextStyle(color: DarkTheme(isDark).textColor),
            showTitles: false,
            reservedSize: 0,
            interval: 100),
        leftTitles: SideTitles(
          showTitles: false,
          interval: interval == 0.0 ? 1 : interval,
          getTitles: (value) {
            if (isPrivate) {
              return '----.----';
            } else {
              return value > 1000000
                  ? '${NumberFormat.compact().format((((value - invested) / invested) * 100).toStringAsFixed(2)).toString()}%'
                  : '${(((value - invested) / invested) * 100).toStringAsFixed(2)}%';
            }
          },
          getTextStyles: (value) => TextStyle(
            letterSpacing: 0,
            color: DarkTheme(isDark).chartTextColour.withOpacity(.5),
            fontSize: 10,
          ),
          reservedSize: 35,
        ),
        rightTitles: SideTitles(
          interval: interval == 0.0 ? 1 : interval,
          showTitles: true,
          getTitles: (value) {
            if (isPrivate) {
              return '----.----';
            } else {
              return value > 1000000
                  ? NumberFormat.compact().format(value).toString()
                  : '${Update(baseCurrency).getCurrencySymbol()['symbol']} ${value.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
            }
          },
          getTextStyles: (value) => TextStyle(
            letterSpacing: 0,
            color: DarkTheme(isDark).chartTextColour,
            fontSize: 10,
          ),
          reservedSize: 50,
        ),
      ),
      // minY: investedValue / 3,
      // extraLinesData: ExtraLinesData(
      //     horizontalLines: [HorizontalLine(y: crossPoint, color: DarkTheme(isDark).blueVarient)]),
      lineTouchData: LineTouchData(
        enabled: true,
        handleBuiltInTouches: true,
        fullHeightTouchLine: true,
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: DarkTheme(isDark).blueVarient.withOpacity(0.6),
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                // if (flSpot.x == 0 || flSpot.x == 6) {
                //   return null;
                // }
                return LineTooltipItem(
                  '${Update(baseCurrency).getCurrencySymbol()['symbol']} ${flSpot.y.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n${DateTime.parse(cagrData[flSpot.x.toInt()]['date'].toString()).day} ${months[DateTime.parse(cagrData[flSpot.x.toInt()]['date'].toString()).month - 1]} ${DateTime.parse(cagrData[flSpot.x.toInt()]['date'].toString()).year}',
                  TextStyle(color: DarkTheme(isDark).textColor),
                );
              }).toList();
            }),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          colors: [DarkTheme(isDark).blueVarient],
          spots: cagarData_interval,
          isCurved: true,
          barWidth: 1.1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradientFrom: Offset(1, -1),
            gradientTo: Offset(1, 1),
            gradientColorStops: [.90, 2],
            colors: [
              DarkTheme(isDark).blueVarient.withOpacity(.09),
              DarkTheme(isDark).blueVarient.withOpacity(.01)
            ],
          ),
        ),
      ],
    ));
  }

  List months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
}

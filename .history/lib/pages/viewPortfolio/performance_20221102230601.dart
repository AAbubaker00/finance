import 'package:Valuid/services/stooq/stooq.dart';
import 'package:Valuid/services/yahooapi/yahoo_api_provider.dart';
import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/GeneralObject/generalObject.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/calculations/cagr/cagr.dart';
import 'package:Valuid/shared/charts/charts.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/disclaimers/disclaimers.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:Valuid/extensions/stringExt.dart';

class Performance extends StatefulWidget {
  final DataObject dataObject;

  Performance({Key key, this.dataObject}) : super(key: key);

  @override
  State<Performance> createState() => _PerformanceState();
}

class _PerformanceState extends State<Performance> {
  Map selectedPortfolio = {}, snpData = {};
  List holdings = [];

  Map currentYear = {};

  @override
  void initState() {
    super.initState();

    inceptionDate = InceptionDate().getInceptionDae(widget.dataObject.onStockHoldings);
    totalDays = DateTime.now().difference(inceptionDate).inDays;

    // print(inceptionDate);

    getSNPData();
  }

  List<Map> timeFrame = [
    // {'time': '1W', 'selected': false, 'interval': 7},
    // {'time': '1M', 'selected': false, 'interval': 30},
    {'time': '3M', 'selected': false, 'interval': 90},
    {'time': '6M', 'interval': 180},
    {'time': '1Y', 'interval': 255},
    {'time': '2Y', 'interval': 510},
    {'time': '3Y', 'interval': 765},
    // {'time': '4Y', 'interval': 1020},
    // {'time': '5Y', 'interval': 1275},
    {'time': 'MAX', 'interval': 1},
  ];

  Map selectedYear = {};

  int timeframInterval = 255, totalDays;

  double cagr_rate = 0.0;

  DateTime inceptionDate;

  bool isDataLoaded = false;

  Future<bool> ins() async {
    holdings.clear();

    for (var holdingType in widget.dataObject.onPortfolio['assets']) {
      holdings += holdingType['items'];
    }

    holdings = widget.dataObject.onStockHoldings;

    for (var holding in holdings) {
      if (!holding['marketData'].containsKey('chartData')) {
        holding['marketData']['chartData'] = {
          'max': await YahooApiService()
              .getYahooChartData(timePeriod: '1d', symbol: holding['symbol'], exchange: holding['exchange']),
        };
      }
    }

    if (widget.dataObject.onPortfolio.containsKey('cagr') &&
        widget.dataObject.onPortfolio['cagr'] != null &&
        widget.dataObject.onPortfolio['cagr'].isNotEmpty) {
    } else {
      print('heere');
      widget.dataObject.onPortfolio['cagr'] =
          await CAGR().setCAGRData({'currency': 'USD', 'rates': widget.dataObject.rates, 'assets': holdings});

      print('heere');
    }

    cagr_rate = pow(
            ((widget.dataObject.onPortfolio['portfolioValue'] -
                    widget.dataObject.onPortfolio['investedValue']) /
                widget.dataObject.onPortfolio['investedValue']),
            (1 / totalDays)) -
        1;

    // print(cagr_rate);

    await setAnnualPerformanceCDT();

    return Future.value(true);
  }

  getSNPData() async {
    snpData = await Stooq().getGSPCHistoricalData(inceptionDate: inceptionDate);

    setState(() {});

    // print(snpData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: isDataLoaded ? Future.value(true) : ins(),
        builder: (context, snapshot) {
          if (isDataLoaded == true) {
            return CWScaffold(
              appBarTitle: 'Analysis',
              dataObject: widget.dataObject,
              bottomAppBarBorderColour: false,
              // appbarColourOption: 2,
              body: CWListView(
                physics: ScrollPhysics(),
                children: [
                  // getCagr(),
                  // SizedBox(height: Units().mainSpacing),
                  getComparison(),
                  SizedBox(height: Units().mainSpacing),
                  SizedBox(height: Units().mainSpacing),

                  // Container(
                  //   padding: EdgeInsets.only(
                  //     top: 20,
                  //   ),
                  //   decoration: BoxDecoration(
                  //       color: UserThemes(widget.dataObject.theme).summaryColour,
                  //       border: Border.symmetric(
                  //           horizontal: BorderSide(color: UserThemes(widget.dataObject.theme).border))),
                  //   height: widget.dataObject.height * 0.5,
                  //   child: Column(
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.only(bottom: 30),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Text('CUMULATIVE RETURNS'),
                  //             // style: sectionHeader.copyWith(
                  //             //     color: UserThemes(widget.dataObject.theme).textColorVarient.withOpacity(.5))),
                  //           ],
                  //         ),
                  //       ),
                  //       Container(
                  //         height: widget.dataObject.height * 0.2,
                  //         width: widget.dataObject.width,
                  //         child: getCumativeReturn(),
                  //       ),
                  //       Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  //         child: DataTable(
                  //             columnSpacing: 20,
                  //             horizontalMargin: 0,
                  //             showBottomBorder: true,
                  //             headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                  //               return UserThemes(widget.dataObject.theme).border;
                  //             }),
                  //             headingRowHeight: 30,
                  //             dataRowHeight: 30,
                  //             dividerThickness: 0,
                  //             dataTextStyle: TextStyle(),
                  //             columns: <DataColumn>[
                  //               DataColumn(
                  //                 label: Padding(
                  //                   padding: EdgeInsets.only(left: 5.0),
                  //                   child: Text(
                  //                     'Year',
                  //                   ),
                  //                 ),
                  //               ),
                  //               DataColumn(
                  //                 label: Text(
                  //                   'Investment',
                  //                 ),
                  //               ),
                  //               DataColumn(
                  //                 label: Text(
                  //                   'Return',
                  //                 ),
                  //               ),
                  //               DataColumn(
                  //                 label: Text(
                  //                   'Return % ',
                  //                 ),
                  //               )
                  //             ],
                  //             rows: [
                  //               DataRow(cells: [
                  //                 DataCell(
                  //                   Container(
                  //                       padding: EdgeInsets.only(left: 5),
                  //                       decoration: BoxDecoration(
                  //                           border: Border(
                  //                               left: BorderSide(
                  //                                   color: VarientColours().customColours[0], width: 5))),
                  //                       child: Text(
                  //                         currentYear['id'].toString(),
                  //                       )),
                  //                 ),
                  //                 DataCell(
                  //                   Text(
                  //                     '$widget.dataObject.userCurrencySymbol${currentYear['closeInvestment'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                  //                   ),
                  //                 ),
                  //                 DataCell(Text(
                  //                   currentYear['returnPerc'].isNegative
                  //                       ? '-$widget.dataObject.userCurrencySymbol${(currentYear['return'] * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
                  //                       : '+$widget.dataObject.userCurrencySymbol${currentYear['return'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                  //                 )),
                  //                 DataCell(Text(
                  //                   currentYear['returnPerc'].isNegative
                  //                       ? '${(currentYear['returnPerc']).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}%'
                  //                       : '${currentYear['returnPerc'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}%',
                  //                 )),
                  //               ])
                  //             ]),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            );
          } else {
            return Loading(
              theme: widget.dataObject.theme,
            );
          }
        });
  }

  getCagr() {
    return Ink(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      decoration: CustomDecoration(widget.dataObject.theme).topWidgetDecoration,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Performance', style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).sectionHeader),
                InkWell(
                  // onTap: () => showSortFunction(),
                  borderRadius: BorderRadius.circular(50),
                  child: Ink(
                    decoration: BoxDecoration(
                      border: Border.all(color: UserThemes(widget.dataObject.theme).seperator),
                      borderRadius: BorderRadius.circular(50),
                      color: UserThemes(widget.dataObject.theme).summaryColour,
                    ),
                    padding: EdgeInsets.all(3),
                    child: ClipRRect(
                        child: Image.asset(
                      'assets/icons/iinfo.png',
                      width: 20,
                      height: 20,
                      color: UserThemes(widget.dataObject.theme).iconColour,
                    )),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
            child: Container(
              // decoration: CustomDecoration(widget.dataObject.theme).curvedContainerDecoration.copyWith(borderRadius: BorderRadius.circular(50)),
              // padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Portfolio CAGR',
                              style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).tableHeaderStyle),
                          SizedBox(width: 2),
                          Text(cagr_rate > 0 ? '+${cagr_rate.toStringAsFixed(2)}%' : '-${cagr_rate * -1}',
                              style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).feedHeaderStyle.copyWith(
                                    fontWeight: FontWeight.w600,
                                  )),
                        ],
                      ),
                      SizedBox(
                        height: Units().mainSpacing * 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Avg. Annual Return',
                              style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).tableHeaderStyle),
                          SizedBox(width: 2),
                          Text(
                              cagr_rate > 0
                                  ? '+${widget.dataObject.userCurrencySymbol}${(cagr_rate * widget.dataObject.onPortfolio['investedValue'] * 1 / 100).toStringAsFixed(2).addCommas()}%'
                                  : '-${widget.dataObject.userCurrencySymbol}${(cagr_rate * -1 * widget.dataObject.onPortfolio['investedValue'] * 1 / 100).toStringAsFixed(2).addCommas()}',
                              style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).feedHeaderStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: cagr_rate.isNegative
                                      ? UserThemes(widget.dataObject.theme).redVarient
                                      : UserThemes(widget.dataObject.theme).greenVarient)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Units().mainSpacing * 2,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Current ${DateTime.now().year.toString()} Earnings',
                              style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).tableHeaderStyle),
                          SizedBox(width: 2),
                          Text(
                              currentYear['return'] > 0
                                  ? '+${widget.dataObject.userCurrencySymbol}${((currentYear['return'].toStringAsFixed(2)).toString().addCommas())}'
                                  : '-${widget.dataObject.userCurrencySymbol}${((currentYear['return'] * -1).toStringAsFixed(2)).toString().addCommas()}',
                              style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).feedHeaderStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: currentYear['return'].isNegative
                                      ? UserThemes(widget.dataObject.theme).redVarient
                                      : UserThemes(widget.dataObject.theme).greenVarient)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          //       decoration: CustomDecoration(widget.dataObject.theme).curvedContainerDecoration,
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             mainAxisSize: MainAxisSize.min,
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             children: [
          //               Icon(
          //                 Icons.circle,
          //                 color: VarientColours().chartColours[0],
          //                 size: Units().iconSize - 10,
          //               ),
          //               SizedBox(
          //                 width: 5,
          //               ),
          //               Container(
          //                 child: Text(
          //                   "Portfolio",
          //                   style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).tableHeaderStyle,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.only(top: 5.0, bottom: 2),
          //             child: Text(
          //               '${cagr_rate.toStringAsFixed(2)}%',
          //               style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).tableValueStyle,
          //             ),
          //           ),
          //           Text(
          //               cagr_rate > 0
          //                   ? '+${widget.dataObject.userCurrencySymbol}${(cagr_rate * widget.dataObject.onPortfolio['investedValue'] / 100).toStringAsFixed(2).addCommas()}'
          //                   : '-${widget.dataObject.userCurrencySymbol}${(cagr_rate * -1 * widget.dataObject.onPortfolio['investedValue'] / 100).toStringAsFixed(2).addCommas()}',
          // style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).tableHeaderStyle.copyWith(
          //     color: cagr_rate.isNegative
          //         ? UserThemes(widget.dataObject.theme).redVarient
          //         : UserThemes(widget.dataObject.theme).greenVarient))
          //         ],
          //       ),
          //     ),
          //   ],
          // ),

          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 110, minWidth: widget.dataObject.width),
                child: SizedBox(
                  child: CustomCharts(widget.dataObject.theme, widget.dataObject.context).getCAGRChart(
                      baseCurrency: widget.dataObject.userCurrencySymbol,
                      // snpData: snpData.isNotEmpty || snpData != null ? snpData['snpSTDFormat'] : [],
                      portfolioCagrData: widget.dataObject.onPortfolio['cagr'],
                      invested: widget.dataObject.onPortfolio['investedValue'],
                      isPrivate: false,
                      timeframInterval: timeframInterval),
                  width: widget.dataObject.width,
                )),
          ),

          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Ink(
              decoration: CustomDecoration(widget.dataObject.theme).curvedContainerDecoration.copyWith(
                    borderRadius: BorderRadius.circular(5),
                  ),
              padding: EdgeInsets.all(2.5),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: timeFrame.map((time) {
                    return Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: InkWell(
                            onTap: () => setState(() {
                              timeframInterval = time['interval'];
                            }),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: CustomDecoration(widget.dataObject.theme)
                                  .curvedContainerDecoration
                                  .copyWith(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: UserThemes(widget.dataObject.theme).backgroundColour),
                                      // borderRadius: BorderRadius.circular(50),

                                      color: time['interval'] == timeframInterval
                                          ? UserThemes(widget.dataObject.theme).blueVarient
                                          : UserThemes(widget.dataObject.theme).backgroundColour),
                              child: Center(
                                child: Text(
                                  time['time'],
                                  style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).tableHeaderStyle.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: time['interval'] == timeframInterval
                                          ? UserThemes(widget.dataObject.theme).iconColour
                                          : UserThemes(widget.dataObject.theme).textColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        time == timeFrame.last
                            ? Container()
                            : VerticalDivider(
                                color: UserThemes(widget.dataObject.theme).seperator,
                                width: 2,
                              ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getComparison() {
    return Ink(
      padding: EdgeInsets.only(
        top: 15,
      ),
      decoration: CustomDecoration(widget.dataObject.theme).topWidgetDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Portfolio Performance', style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).sectionHeader),
                InkWell(
                  // onTap: () => showSortFunction(),
                  borderRadius: BorderRadius.circular(50),
                  child: Ink(
                    decoration: BoxDecoration(
                      border: Border.all(color: UserThemes(widget.dataObject.theme).seperator),
                      borderRadius: BorderRadius.circular(50),
                      color: UserThemes(widget.dataObject.theme).summaryColour,
                    ),
                    padding: EdgeInsets.all(3),
                    child: ClipRRect(
                        child: Image.asset(
                      'assets/icons/iinfo.png',
                      width: 20,
                      height: 20,
                      color: UserThemes(widget.dataObject.theme).iconColour,
                    )),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, top: 20),
            child: Container(
              height: 150,
              width: widget.dataObject.width,
              child: getAnnualPerformanceChart(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: yearPerfDta.map((year) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: InkWell(
                      onTap: () => setState(() => selectedYear = year),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                        decoration: CustomDecoration(widget.dataObject.theme)
                            .curvedContainerDecoration
                            .copyWith(
                                border: Border.all(
                                    color: selectedYear == year
                                        ? UserThemes(widget.dataObject.theme).blueVarient
                                        : UserThemes(widget.dataObject.theme).seperator)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: VarientColours().customColours[yearPerfDta.indexOf(year)],
                                  size: Units().iconSize - 10,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  child: Text(
                                    "${year['id']}",
                                    style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).tableHeaderStyle,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0, bottom: 2),
                              child: Text(
                                year['returnPerc'].isNegative
                                    ? '-${widget.dataObject.userCurrencySymbol}${(year['return'] * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
                                    : '+${widget.dataObject.userCurrencySymbol}${year['return'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).tableValueStyle,
                              ),
                            ),
                            Text(
                                year['returnPerc'].isNegative
                                    ? '-${(year['returnPerc']).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}%'
                                    : '+${year['returnPerc'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}%',
                                style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).tableHeaderStyle.copyWith(
                                    color: year['returnPerc'].isNegative
                                        ? UserThemes(widget.dataObject.theme).redVarient
                                        : UserThemes(widget.dataObject.theme).greenVarient))
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          //    Padding(
          //   padding: const EdgeInsets.only(left: 15.0, right: 15),
          //   child: RichText(
          //       // textAlign: TextAlign.center,
          //       text: TextSpan(children: <TextSpan>[
          //     TextSpan(
          //       text: 'Disclaimer: ',
          //       style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).disclaimerTextStyle.copyWith(
          //             color: UserThemes(widget.dataObject.theme).textColor,
          //           ),
          //     ),
          //     TextSpan(
          //       text: allocation_disclaimer,
          //       style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).disclaimerTextStyle,
          //     ),
          //   ])),
          // ),
        ],
      ),
    );
  }

  List yearPerfDta = [];
  List<List<FlSpot>> ypfdTable = [];
  double index = 0.0;
  List usedYears = [];

  setAnnualPerformanceCDT() {
    yearPerfDta.clear();
    ypfdTable.clear();

    for (var date in widget.dataObject.onPortfolio['cagr']) {
      if (yearPerfDta.isEmpty) {
        yearPerfDta.add({
          'id': DateTime.parse(date['date']).year,
          'dates': [],
        });
      } else {
        if (DateTime.parse(date['date']).year != inceptionDate.year) {
          var isYearExist = yearPerfDta.firstWhere((year) => year['id'] == DateTime.parse(date['date']).year,
              orElse: () => null);

          if (isYearExist == null) {
            yearPerfDta.add({'id': DateTime.parse(date['date']).year, 'dates': []});
          }
        }
      }
    }

    for (var year in yearPerfDta) {
      for (var date in widget.dataObject.onPortfolio['cagr']) {
        if (DateTime.parse(date['date']).year == year['id']) {
          year['dates'].add(date);
        }
      }
    }

    for (var year in yearPerfDta) {
      year['dates'].sort((a, b) => DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])));

      for (var date in year['dates']) {
        double value = date['value'];
        double invested = date['invested'];

        if (year['dates'].indexOf(date) == 0) {
          date['yearChange'] = (value - invested);
        } else {
          date['yearChange'] = ((value - year['dates'][0]['yearChange'] - invested) / invested) * 100;
        }
      }
    }

    for (var year in yearPerfDta) {
      year['dates'].removeAt(0);

      // print('${year['dates'][0]} : ${year['dates'].last}');

      index = 0.0;

      List<FlSpot> yearTable = [];
      yearTable.clear();

      for (var date in year['dates']) {
        yearTable.add(FlSpot(index, double.parse(date['yearChange'].toStringAsFixed(2))));
        index++;
      }

      ypfdTable.add(yearTable);
    }

    if (ypfdTable.length >= 5) {
      usedYears = yearPerfDta
          .where((year) =>
              yearPerfDta.indexOf(year) <= yearPerfDta.length - 2 &&
              yearPerfDta.indexOf(year) >= yearPerfDta.length - 5)
          .toList();

      ypfdTable = ypfdTable.getRange(ypfdTable.length - 5, ypfdTable.length - 1).toList();
    }

    for (var year in yearPerfDta) {
      year['openValue'] = year['dates'].first['value'];
      year['closeValue'] = year['dates'].last['value'];

      // print(year['dates'].last['invested']);

      year['closeInvestment'] = year['dates'].last['invested'];

      year['return'] = (year['closeValue'] - year['closeInvestment']);
      year['returnPerc'] = (year['return'] * 100) / year['closeInvestment'];
    }

    currentYear = yearPerfDta.last;

    // print(currentYear);

    yearPerfDta = yearPerfDta.getRange(yearPerfDta.length - 5, yearPerfDta.length - 1).toList();
    isDataLoaded = true;
    selectedYear = yearPerfDta.last;
  }

  getAnnualPerformanceChart() {
    return LineChart(LineChartData(
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          horizontalInterval: 50,
          verticalInterval: 50,
          getDrawingHorizontalLine: (value) => FlLine(
            color: UserThemes(widget.dataObject.theme).backgroundColour,
            strokeWidth: 2,
            dashArray: [2, 4],
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: UserThemes(widget.dataObject.theme).backgroundColour,
            strokeWidth: 2,
            dashArray: [2, 4],
          ),
        ),
        titlesData: FlTitlesData(
          show: false,
          bottomTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
          leftTitles: SideTitles(showTitles: false),
          rightTitles: SideTitles(showTitles: false),
        ),
        lineTouchData: LineTouchData(
          enabled: false,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: UserThemes(widget.dataObject.theme).backgroundColour.withOpacity(0.8),
            // getTooltipItems: (touchedSpots) => touchedSpots
            //     .map((spot) =>
            //         LineTooltipItem('${spot.y}%', CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).tableValueStyle))
            //     .toList()),
          ),
          touchCallback: (LineTouchResponse touchResponse) {},
          handleBuiltInTouches: true,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        lineBarsData: ypfdTable.map((year) {
          return LineChartBarData(
            colors: [
              VarientColours()
                  .customColours[ypfdTable.indexOf(year)]
                  .withOpacity(ypfdTable.indexOf(year) == yearPerfDta.indexOf(selectedYear) ? 1 : .5)
            ],
            spots: year,
            isCurved: false,
            barWidth: .9,
            isStrokeCapRound: true,

            dotData: FlDotData(
              show: false,

                      ),
            belowBarData: BarAreaData(
              show: false,
              gradientFrom: Offset(1, -1),
              gradientTo: Offset(1, 1),
              gradientColorStops: [.90, 2],
              colors: [
                VarientColours().customColours[ypfdTable.indexOf(year)].withOpacity(.05),
                VarientColours().customColours[ypfdTable.indexOf(year)].withOpacity(.008)
              ],
            ),
          );
        }).toList()));
  }

  List cuReturnPeriods = [
    {'period': 30, 'return': 0.0, 'id': '1-Month'},
    {'period': 90, 'return': 0.0, 'id': '3-Month'},
    {'period': 180, 'return': 0.0, 'id': '6-Month'},
    {'period': 265, 'return': 0.0, 'id': '1-Year'},
    {'period': 1095, 'return': 0.0, 'id': '3-Year'},
    {'period': 1825, 'return': 0.0, 'id': '5-Year'}
  ];

  List<BarChartGroupData> crpCDT = [];

  getCumativeReturn() {
    crpCDT.clear();
    for (var period in cuReturnPeriods) {
      if (period['period'] < widget.dataObject.onPortfolio['cagr'].length) {
        double endValue =
            widget.dataObject.onPortfolio['cagr'][widget.dataObject.onPortfolio['cagr'].length - 1]['value'];

        double startValue = widget.dataObject.onPortfolio['cagr']
            [widget.dataObject.onPortfolio['cagr'].length - period['period']]['value'];
        double periodReturn =
            ((endValue - startValue) / widget.dataObject.onPortfolio['investedValue']) * 100;

        period['return'] = periodReturn;
      }
    }

    // print(cuReturnPeriods);

    cuReturnPeriods = cuReturnPeriods.where((element) => element['return'] != 0.0).toList();

    int index = 0;

    for (var period in cuReturnPeriods) {
      // lowest = lowest < period['return'] ? period['return'] : lowest;

      crpCDT.add(BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            borderRadius: BorderRadius.circular(5),
            y: period['return'],
            width: 25,
            // gradientFrom: Offset(1, -1),
            // gradientTo: Offset(1, 1),
            // gradientColorStops: [.70, 1],
            colors: [VarientColours().chartColours[index]],
          ),
        ],
        barsSpace: 10,
        showingTooltipIndicators: [0],
      ));

      index++;
    }

    index = 0;

    return BarChart(
      BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              // fitInsideVertically: true,
              fitInsideHorizontally: true,
              tooltipBgColor: Colors.transparent,
              tooltipPadding: EdgeInsets.all(0),
              getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
              ) {
                return BarTooltipItem(
                  '${rod.y.toStringAsFixed(2)}%',
                  TextStyle(
                    color: UserThemes(widget.dataObject.theme).textColor,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value, _) => TextStyle(
                  color: UserThemes(widget.dataObject.theme).textColorVarient,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
              margin: 30,
              getTitles: (double value) {
                // String txt = value.toInt() == 0
                //     ? '${DateFormat('dd-MM-yyyy').format(inceptionDate)} \nto \n${inceptionDate.year}-12-31'
                //     : '${years[value.toInt() - 1]['id']}-12-31 \nto \n${years[value.toInt()]['id']}-12-31';

                // return 'FY ${years[value.toInt()]['id']}';
                // print(0]['id']);
                // print(value);

                int index = value.toInt();

                return cuReturnPeriods[index]['id'].toString();
              },
            ),
            leftTitles: SideTitles(showTitles: false),
          ),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) =>
                FlLine(color: UserThemes(widget.dataObject.theme).border.withOpacity(.3), strokeWidth: 1),
            horizontalInterval: 20,
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: crpCDT),
    );
  }

  List years = [];
  List<BarChartGroupData> yearsCDT = [];

  getPerformanceChart() {
    widget.dataObject.onPortfolio['cagr']
        .sort((a, b) => DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])));
    yearsCDT.clear();
    years.clear();

    for (var date in widget.dataObject.onPortfolio['cagr']) {
      if (years.isEmpty) {
        years.add({'id': DateTime.parse(date['date']).year, 'roi': 0.0});
      } else {
        if (DateTime.parse(date['date']).year != inceptionDate.year) {
          var isYearExist =
              years.firstWhere((year) => year['id'] == DateTime.parse(date['date']).year, orElse: () => null);

          if (isYearExist == null) {
            years.add({'id': DateTime.parse(date['date']).year, 'roi': 0.0});
          }
        }
      }
    }

    for (var year in years) {
      if (year['id'] != DateTime.now().year) {
        int finalDay = 31;

        var initialValue = (year['id'] == inceptionDate.year)
            ? widget.dataObject.onPortfolio['cagr']
                .firstWhere((date) => DateTime.parse(date['date']) == inceptionDate, orElse: () => null)
            : widget.dataObject.onPortfolio['cagr'].firstWhere(
                (date) =>
                    DateTime.parse(date['date']) ==
                    DateTime.parse('${years[years.indexOf(year) - 1]['id']}-12-$finalDay'),
                orElse: () => null);

        while (initialValue == null) {
          finalDay--;

          initialValue = widget.dataObject.onPortfolio['cagr'].firstWhere(
              (date) =>
                  DateTime.parse(date['date']) ==
                  DateTime.parse('${years[years.indexOf(year) - 1]['id']}-12-$finalDay'),
              orElse: () => null);
        }

        // print(initialValue);

        finalDay = 31;

        var finalValue = widget.dataObject.onPortfolio['cagr'].firstWhere(
            (date) => DateTime.parse(date['date']) == DateTime.parse('${year['id']}-12-$finalDay'),
            orElse: () => null);

        // print(finalValue);

        while (finalValue == null) {
          finalDay--;

          finalValue = widget.dataObject.onPortfolio['cagr'].firstWhere(
              (date) => DateTime.parse(date['date']) == DateTime.parse('${year['id']}-12-$finalDay'),
              orElse: () => null);
        }

        year['roi'] = ((finalValue['value'] - initialValue['value']) / finalValue['invested']) * 100;
        year['roi'] = year['roi'] < -100 ? year['roi'] + 100 : year['roi'];
        // print(year['roi']);
      }
    }

    int index = 0;
    double lowest = 0;

    for (var year in years) {
      lowest = year['roi'] < lowest ? year['roi'] : lowest;

      yearsCDT.add(BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            borderRadius: BorderRadius.circular(5),
            y: year['roi'] < 0 ? year['roi'] : year['roi'],
            width: 25,
            // gradientFrom: Offset(1, -1),
            // gradientTo: Offset(1, 1),
            // gradientColorStops: [.70, 1],
            colors: [VarientColours().customColours[index]],
          ),
        ],
        barsSpace: 10,
        showingTooltipIndicators: [0],
      ));

      index++;
    }

    index = 0;

    return BarChart(
      BarChartData(
          minY: lowest,
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              // fitInsideVertically: true,
              fitInsideHorizontally: true,
              tooltipBgColor: Colors.transparent,
              tooltipPadding: EdgeInsets.all(0),

              getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
              ) {
                return BarTooltipItem(
                  '${rod.y.toStringAsFixed(2)}%',
                  TextStyle(
                    color: UserThemes(widget.dataObject.theme).textColor,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value, _) => TextStyle(
                  color: UserThemes(widget.dataObject.theme).textColorVarient,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
              margin: 30,
              getTitles: (double value) {
                // String txt = value.toInt() == 0
                //     ? '${DateFormat('dd-MM-yyyy').format(inceptionDate)} \nto \n${inceptionDate.year}-12-31'
                //     : '${years[value.toInt() - 1]['id']}-12-31 \nto \n${years[value.toInt()]['id']}-12-31';

                return '${years[value.toInt()]['id']}';

                // return txt;
              },
            ),
            leftTitles: SideTitles(showTitles: false),
          ),
          gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) => FlLine(
                    color: UserThemes(widget.dataObject.theme).seperator,
                    strokeWidth: 1,
                    dashArray: [2, 4],
                  ),
              getDrawingVerticalLine: (value) => FlLine(
                    color: UserThemes(widget.dataObject.theme).seperator,
                    strokeWidth: 1,
                    dashArray: [2, 4],
                  ),
              horizontalInterval: 20,
              verticalInterval: 20),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: yearsCDT),
    );
  }
}

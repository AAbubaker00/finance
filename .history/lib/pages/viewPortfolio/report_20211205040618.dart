import 'dart:ui';

import 'package:Strice/extensions/stringExt.dart';
import 'package:Strice/services/Network/network.dart';
import 'package:Strice/services/stooq/stooq.dart';
import 'package:Strice/shared/GeneralObject/generalObject.dart';
import 'package:Strice/shared/ads/ad.dart';
import 'package:Strice/shared/ads/ad_helper.dart';
import 'package:Strice/shared/charts/charts.dart';
import 'package:Strice/shared/dateFormat/customeDateFormatter.dart';
import 'package:Strice/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/units/units.dart';
import 'package:Strice/shared/update/marketUpdate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> with TickerProviderStateMixin {
  List performance = [], assets = [], snpHistoricalData, topAssets = [], leastAssets = [];
  List<String> sortOptions = ['0', '1', '2', '3'];
  List adsGenerated = [];

  Map data = {};

  double _height = 0.0, _width = 0.0, ratio, iconSize = 10, barWidth = 10;
  double investedValue = 0.0, portfolioValue = 0.0;
  double topFivePercentage = 0.0, monthsSinceInception;
  double setTopTenAssetChartDataPercentage = 0.0;

  double totalShares = 0;

  int timeframInterval = 261;

  String baseCurrency = 'USD',
      currencySymbol = '',
      inceptionDateSTR,
      largestAssetType,
      selectedSortOption = '0';

  var themeMode = true;

  DateTime inception_Date;

  bool isSnpDataLoaded = false, isMainLoaded = false, isPerformanceLoaded = false, isTop = false;

  TextStyle headerStyle, sublineStyle, sectionHeader, disclaimerHeader, disclaimerSub;

  Duration timeSinceInception;

  @override
  void initState() {
    super.initState();
    ratio = (window.physicalSize.height / window.physicalSize.width);

    _floatingBottomAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(
            onAdLoaded: (_) => setState(() {
                  adsLoaded();
                }),
            onAdFailedToLoad: (_, error) => PrintFunctions().printStartEndLine(error)),
        request: AdRequest());

    _floatingBottomAd.load();
  }

  adsLoaded() {
    for (int i = 0; i != 2; i++) {
      _floatingBottomAd = BannerAd(
          size: AdSize.banner,
          adUnitId: AdHelper.bannerAdUnitId,
          listener: BannerAdListener(
              onAdLoaded: (_) => setState(() => isAdLoaded = true),
              onAdFailedToLoad: (_, error) => PrintFunctions().printStartEndLine(error)),
          request: AdRequest());

      _floatingBottomAd.load();

      adsGenerated.add(_floatingBottomAd);

      isAdLoaded = true;
    }
  }

  BannerAd _floatingBottomAd;
  bool isAdLoaded = false;

  getSnPHistoricalData() async {
    snpHistoricalData = (await Network('').getConnectionStatus())
        ? await Stooq().getGSPCHistoricalData(inceptionDate: inception_Date)
        : [];

    setState(() async {
      if (await Network('').getConnectionStatus() == true) {
        isSnpDataLoaded = true;
        isPerformanceLoaded = true;
      }
    });
  }
 
  _setSort() {
    topAssetAnnualPerformance.clear();
    leastAssetAnnualPerformance.clear();
    topAssets.clear();
    leastAssets.clear();

    setState(() {
      assets.sort((a, b) {
        var lastYearChangeA = a['marketData']['chartData']['max']['years'].firstWhere(
            (year) => year['id'] == (DateTime.now().year - (double.parse(selectedSortOption)).toInt()));
        var lastYearChangeB = b['marketData']['chartData']['max']['years'].firstWhere(
            (year) => year['id'] == (DateTime.now().year - (double.parse(selectedSortOption)).toInt()));
        return lastYearChangeA['roi'].compareTo(lastYearChangeB['roi']);
      });

      assets = assets.reversed.toList();

      for (var asset in assets) {
        List<FlSpot> assetAnnualPerformance = [];
        double index = 0.0;

        if (assets.indexOf(asset) < 5) {
          // print(asset['symbol']);
          topAssets.add(asset);

          var lastYear = asset['marketData']['chartData']['max']['years'].firstWhere(
              (year) => year['id'] == DateTime.now().year - (double.parse(selectedSortOption)).toInt());

          for (var date in lastYear['dates']) {
            assetAnnualPerformance.add(FlSpot(index, double.parse((date['change'].toStringAsFixed(2)))));
            index++;
          }

          topAssetAnnualPerformance.add(assetAnnualPerformance);
        }
      }

      assets.sort((a, b) {
        var lastYearChangeA = a['marketData']['chartData']['max']['years'].firstWhere(
            (year) => year['id'] == (DateTime.now().year - (double.parse(selectedSortOption)).toInt()));
        var lastYearChangeB = b['marketData']['chartData']['max']['years'].firstWhere(
            (year) => year['id'] == (DateTime.now().year - (double.parse(selectedSortOption)).toInt()));
        return lastYearChangeA['roi'].compareTo(lastYearChangeB['roi']);
      });

      for (var asset in assets) {
        List<FlSpot> assetAnnualPerformance = [];
        double index = 0.0;

        if (assets.indexOf(asset) < 5) {
          // print(asset['symbol']);
          leastAssets.add(asset);

          var lastYear = asset['marketData']['chartData']['max']['years'].firstWhere(
              (year) => year['id'] == DateTime.now().year - (double.parse(selectedSortOption)).toInt());

          for (var date in lastYear['dates']) {
            assetAnnualPerformance.add(FlSpot(index, double.parse((date['change'].toStringAsFixed(2)))));
            index++;
          }

          leastAssetAnnualPerformance.add(assetAnnualPerformance);
        }
      }
    });
  }

  _load() {
    if (isMainLoaded == false) {
      setState(() {
        currencySymbol = MarketUpdate(baseCurrency).getCurrencySymbol()['symbol'];
        assets = data['assets'];

        investedValue = data['invested'];
        portfolioValue = data['value'];
        performance = data['performance'];
        inception_Date = DateTime.parse(data['inception']);
        inceptionDateSTR =
            '${DateTime.parse(data['inception']).day} Sept ${DateTime.parse(data['inception']).year}';

        timeSinceInception = DateTime.now().difference(inception_Date);
        double year = 365;
        monthsSinceInception = year.remainder(timeSinceInception.inDays).toDouble();

        for (var stock in assets) {
          totalShares += stock['shares'];
        }

        setAnnualPerformanceChart();
        setAssetPerformance();

        isMainLoaded = true;
      });
    }

    if (snpHistoricalData == null || isPerformanceLoaded == true) {
      setAnnualPerformanceChart();
      isPerformanceLoaded = false;
    }

    if (isSnpDataLoaded == false) {
      getSnPHistoricalData();
    }
  }

  final _auth = FirebaseAuth.instance;
  User user;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    user = _auth.currentUser;
    data = ModalRoute.of(context).settings.arguments;
    themeMode = (data['data']['data']['states']['theme']);

    _load();

    headerStyle = TextStyle(
      fontSize: 17,
      color: UserThemes(themeMode).textColorVarient,
    );
    sublineStyle = TextStyle(
      fontSize: 15,
      color: UserThemes(themeMode).textColor,
    );
    sectionHeader = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w300,
      color: UserThemes(themeMode).textColor,
    );
    disclaimerHeader = TextStyle(
      color: UserThemes(themeMode).textColor,
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );
    disclaimerSub = TextStyle(
      color: UserThemes(themeMode).textColorVarient,
      fontSize: 11,
    );
    return Container(
      color: UserThemes(themeMode).backgroundColour,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: UserThemes(themeMode).backgroundColour,
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: UserThemes(themeMode).backColour, //change your color here
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: UserThemes(themeMode).backgroundColour,
              title: Text('Analysis', style: TextStyle(color: UserThemes(themeMode).textColor, fontSize: 20)),
            ),
            body: Scrollbar(
                radius: Radius.circular(Units().circularRadius),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                       decoration: BoxDecoration(
                                color: UserThemes(themeMode).summaryColour,
                                borderRadius: BorderRadius.circular(Units().circularRadius),
                                border: Border.all(color: UserThemes(themeMode).border, width: 1)),
                              child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text('PORTFOLIO vs S&P 500 Index', style: sectionHeader),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(children: [
                                    Icon(
                                      Icons.circle,
                                      color: VarientColours().customColours[2],
                                      size: iconSize,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Portfolio YTD', style: sublineStyle)
                                  ]),
                                  Row(children: [
                                    Icon(
                                      Icons.circle,
                                      color: VarientColours().customColours[1],
                                      size: iconSize,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('S&P 500 Index YTD', style: sublineStyle)
                                  ])
                                ],
                              ),
                            ),
                            Container(
                              height: _height * 0.25,
                              child: CustomCharts(themeMode).customeBarChart(
                                allYearData,
                                years,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: DataTable(
                                  columnSpacing: 10,
                                  horizontalMargin: 0,
                                  showBottomBorder: false,
                                  headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                                    return UserThemes(themeMode).border;
                                  }),
                                  headingRowHeight: 30,
                                  headingTextStyle: headerStyle,
                                  dataRowHeight: 35,
                                  dividerThickness: 0,
                                  dataTextStyle: TextStyle(),
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          'Year',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Center(
                                        child: Text(
                                          'Investment',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Center(
                                        child: Text(
                                          'Return',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Center(
                                        child: FittedBox(
                                          child: Text(
                                            'Portfolio',
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Center(
                                        child: Text(
                                          'S&P 500',
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: years.map((year) {
                                    return DataRow(
                                        color: MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                            if (years.indexOf(year).isOdd) {
                                              return UserThemes(themeMode).border;
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        cells: [
                                          DataCell(
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(year['id'].toString(), style: sublineStyle),
                                              ],
                                            ),
                                          ),
                                          DataCell(
                                            Center(
                                              child: Text(
                                                  '$currencySymbol${year['addedInvesment'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                                  style: sublineStyle),
                                            ),
                                          ),
                                          DataCell(Center(
                                            child: Text(
                                                year['roi'].isNegative
                                                    ? '-$currencySymbol${(year['roi_value'] * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
                                                    : '+$currencySymbol${year['roi_value'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                                style: sublineStyle.copyWith(
                                                    color: year['roi'].isNegative
                                                        ? UserThemes(themeMode).redVarient
                                                        : UserThemes(themeMode).greenVarient)),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                                year['roi'].isNegative
                                                    ? '${(year['roi']).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}%'
                                                    : '+${year['roi'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}%',
                                                style: sublineStyle.copyWith(
                                                    color: year['roi'].isNegative
                                                        ? UserThemes(themeMode).redVarient
                                                        : UserThemes(themeMode).greenVarient)),
                                          )),
                                          DataCell(Center(
                                            child: snpHistoricalData == null
                                                ? Text('--', style: sublineStyle)
                                                : Text(
                                                    (snpHistoricalData.firstWhere(
                                                                    (snpYear) => snpYear['id'] == year['id'])
                                                                as Map)['roi']
                                                            .isNegative
                                                        ? '-${((snpHistoricalData.firstWhere((snpYear) => snpYear['id'] == year['id']) as Map)['roi']).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}%'
                                                        : '+${(snpHistoricalData.firstWhere((snpYear) => snpYear['id'] == year['id']) as Map)['roi'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}%',
                                                    style: sublineStyle.copyWith(
                                                        color: (snpHistoricalData.firstWhere((snpYear) =>
                                                                        snpYear['id'] == year['id'])
                                                                    as Map)['roi']
                                                                .isNegative
                                                            ? UserThemes(themeMode).redVarient
                                                            : UserThemes(themeMode).greenVarient)),
                                          )),
                                        ]);
                                  }).toList()),
                            ),
                            disclaimer()
                          ],
                        ),
                      ),
                      adsGenerated.isEmpty
                          ? SizedBox(height: 15,)
                          : Padding(
                              padding: EdgeInsets.only(top: 15.0, bottom: 15),
                              child: CustomeAdWidget(isAdLoaded, adsGenerated[0]).checkBannerAdStatus(),
                            ),
                      Container(
                        padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                                color: UserThemes(themeMode).summaryColour,
                                borderRadius: BorderRadius.circular(Units().circularRadius),
                                border: Border.all(color: UserThemes(themeMode).border, width: 1)),
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 20, top: 10),
                              child: Text('${DateTime.now().year} GROWTH', style: sectionHeader),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(children: [
                                    Icon(
                                      Icons.circle,
                                      color: VarientColours().customColours[2],
                                      size: iconSize,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Portfolio', style: sublineStyle)
                                  ]),
                                  Row(children: [
                                    Icon(
                                      Icons.circle,
                                      color: VarientColours().customColours[1],
                                      size: iconSize,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('S&P 500 Index', style: sublineStyle)
                                  ])
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 10),
                              child: Container(
                                height: 150,
                                width: _width * .9,
                                child: CustomCharts(themeMode)
                                    .customeLineChart(primaryData: currentYearGrowth, extraFeatures: true),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: DataTable(
                                  columnSpacing: 10,
                                  horizontalMargin: 0,
                                  showBottomBorder: false,
                                  headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                                    return UserThemes(themeMode).border;
                                  }),
                                  headingRowHeight: 30,
                                  headingTextStyle: headerStyle,
                                  dataRowHeight: 35,
                                  dividerThickness: 0,
                                  dataTextStyle: TextStyle(),
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          ' ',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Investment',
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Return',
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'YTD',
                                      ),
                                    )
                                  ],
                                  rows: [
                                    DataRow(
                                        color: MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                            if (years.indexOf(years.last).isOdd) {
                                              return UserThemes(themeMode).border;
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        cells: [
                                          DataCell(
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('Portfolio', style: sublineStyle),
                                              ],
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                                '$currencySymbol${years.last['addedInvesment'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                                style: sublineStyle),
                                          ),
                                          DataCell(Text(
                                              years.last['roi'].isNegative
                                                  ? '-$currencySymbol${(years.last['roi_value'] * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
                                                  : '+$currencySymbol${years.last['roi_value'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                              style: sublineStyle.copyWith(
                                                  color: years.last['roi'].isNegative
                                                      ? UserThemes(themeMode).redVarient
                                                      : UserThemes(themeMode).greenVarient))),
                                          DataCell(Text('${years.last['roi'].toStringAsFixed(2)}%',
                                              style: sublineStyle.copyWith(
                                                  color: years.last['roi'].isNegative
                                                      ? UserThemes(themeMode).redVarient
                                                      : UserThemes(themeMode).greenVarient))),
                                        ]),
                                    DataRow(
                                        color: MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                            if (years.indexOf(years.last).isOdd) {
                                              return UserThemes(themeMode).border;
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        cells: [
                                          DataCell(
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('S&P', style: sublineStyle),
                                              ],
                                            ),
                                          ),
                                          DataCell(
                                            Text('---', style: sublineStyle),
                                          ),
                                          DataCell(Text(
                                              snpHistoricalData != null
                                                  ? (snpHistoricalData.firstWhere(
                                                              (year) => year['id'] == DateTime.now().year,
                                                              orElse: () => null) as Map)['roi_value']
                                                          .isNegative
                                                      ? '-$currencySymbol${((snpHistoricalData.firstWhere((year) => year['id'] == DateTime.now().year, orElse: () => null) as Map)['roi_value'] * -1).toStringAsFixed(2)}'
                                                      : '+$currencySymbol${(snpHistoricalData.firstWhere((year) => year['id'] == DateTime.now().year, orElse: () => null) as Map)['roi_value'].toStringAsFixed(2)}'
                                                  : '---',
                                              style: sublineStyle.copyWith(
                                                  color: snpHistoricalData != null
                                                      ? (snpHistoricalData.firstWhere(
                                                                  (year) => year['id'] == DateTime.now().year,
                                                                  orElse: () => null) as Map)['roi_value']
                                                              .isNegative
                                                          ? UserThemes(themeMode).redVarient
                                                          : UserThemes(themeMode).greenVarient
                                                      : UserThemes(themeMode).textColorVarient))),
                                          DataCell(Text(
                                              snpHistoricalData != null
                                                  ? ' ${(snpHistoricalData.firstWhere((year) => year['id'] == DateTime.now().year, orElse: () => null) as Map)['roi'].toStringAsFixed(2)}%'
                                                  : '---',
                                              style: sublineStyle.copyWith(
                                                  color: snpHistoricalData != null
                                                      ? (snpHistoricalData.firstWhere(
                                                                  (year) => year['id'] == DateTime.now().year,
                                                                  orElse: () => null) as Map)['roi']
                                                              .isNegative
                                                          ? UserThemes(themeMode).redVarient
                                                          : UserThemes(themeMode).greenVarient
                                                      : UserThemes(themeMode).textColorVarient))),
                                        ])
                                  ]),
                            ),
                            disclaimer()
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                                color: UserThemes(themeMode).summaryColour,
                                borderRadius: BorderRadius.circular(Units().circularRadius),
                                border: Border.all(color: UserThemes(themeMode).border, width: 1)),
                             child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text('6 MONTHLY RETURNS', style: sectionHeader),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(children: [
                                      Icon(
                                        Icons.circle,
                                        color: VarientColours().customColours[2],
                                        size: iconSize,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Portfolio', style: sublineStyle)
                                    ]),
                                    Row(children: [
                                      Icon(
                                        Icons.circle,
                                        color: VarientColours().customColours[1],
                                        size: iconSize,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('S&P 500 Index', style: sublineStyle)
                                    ])
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                height: _height * 0.25,
                                child: CustomCharts(themeMode)
                                    .customeBarChart(monthlyReturns, portfolioMonths, isMonths: true),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 20, top: 10),
                                child: DataTable(
                                    columnSpacing: 10,
                                    horizontalMargin: 0,
                                    showBottomBorder: false,
                                    headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                                      return UserThemes(themeMode).border;
                                    }),
                                    headingRowHeight: 30,
                                    headingTextStyle: headerStyle,
                                    dataRowHeight: 35,
                                    dividerThickness: 0,
                                    dataTextStyle: TextStyle(),
                                    columns: portfolioMonths
                                        .map((month) => DataColumn(
                                            label: Padding(
                                                padding: EdgeInsets.only(left: 5),
                                                child: Text(CustomeDateFormatter()
                                                    .monthsShort[month['id'] - 1]
                                                    .toString()))))
                                        .toList(),
                                    rows: totalMonthlyReturns
                                        .map((month) => DataRow(
                                            color: MaterialStateProperty.resolveWith<Color>((states) {
                                              if (totalMonthlyReturns.indexOf(month) == 0) {
                                                return VarientColours().customColours[2].withOpacity(.2);
                                              } else {
                                                return VarientColours().customColours[1].withOpacity(.2);
                                              }
                                            }),
                                            cells: totalMonthlyReturns[totalMonthlyReturns.indexOf(month)]
                                                .map((dataPoint) => DataCell(Center(
                                                      child: Text('${dataPoint['roi'].toStringAsFixed(2)}%',
                                                          style: sublineStyle.copyWith(
                                                              fontWeight: FontWeight.w800,
                                                              color: dataPoint['roi'].isNegative
                                                                  ? UserThemes(themeMode).redVarient
                                                                  : UserThemes(themeMode).greenVarient)),
                                                    )))
                                                .toList()))
                                        .toList()),
                              ),
                              disclaimer()
                            ],
                          ),
                        ),
                      ),
                      adsGenerated.isEmpty
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.only(bottom: 15.0),
                              child: CustomeAdWidget(isAdLoaded, adsGenerated[1]).checkBannerAdStatus(),
                            ),
                      Container(
                        padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                                color: UserThemes(themeMode).summaryColour,
                                borderRadius: BorderRadius.circular(Units().circularRadius),
                                border: Border.all(color: UserThemes(themeMode).border, width: 1)),
                              child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text('HOLDINGS COMPARISON', style: sectionHeader),
                                ),
                                Row(
                                  children: [
                                    Text(
                                        (DateTime.now().year - (double.parse(selectedSortOption)).toInt())
                                            .toString(),
                                        style: sublineStyle),
                                    _sortPopupMenu(),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('TOP RETURNS', style: sectionHeader),
                                  Text(
                                      (DateTime.now().year - (double.parse(selectedSortOption)).toInt())
                                          .toString(),
                                      style: sublineStyle),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: topAssets.map((asset) {
                                var year = asset['marketData']['chartData']['max']['years'].firstWhere(
                                    (year) =>
                                        year['id'] ==
                                        DateTime.now().year - (double.parse(selectedSortOption)).toInt());

                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.circle,
                                            color: VarientColours().customColours[topAssets.indexOf(asset)],
                                            size: iconSize),
                                        SizedBox(width: 5),
                                        Text(
                                          "${asset['symbol']}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: UserThemes(themeMode).textColor,
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Text(
                                        year['roi'].isNegative
                                            ? '${(year['roi']).toStringAsFixed(2)}%'
                                            : '${year['roi'].toStringAsFixed(2)}%',
                                        style: sublineStyle.copyWith(
                                            color: year['roi'].isNegative
                                                ? UserThemes(themeMode).redVarient
                                                : UserThemes(themeMode).greenVarient))
                                  ],
                                );
                              }).toList(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30.0, bottom: 50),
                              child: Container(
                                height: _height * 0.2,
                                child: CustomCharts(themeMode).customeLineChart(
                                  primaryData: topAssetAnnualPerformance,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('LOWEST RETURNS', style: sectionHeader),
                                  Text(
                                      (DateTime.now().year - (double.parse(selectedSortOption)).toInt())
                                          .toString(),
                                      style: sublineStyle),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: leastAssets.map((asset) {
                                var year = asset['marketData']['chartData']['max']['years'].firstWhere(
                                    (year) =>
                                        year['id'] ==
                                        DateTime.now().year - (double.parse(selectedSortOption)).toInt());

                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.circle,
                                            color: VarientColours().customColours[
                                                VarientColours().customColours.length -
                                                    leastAssets.indexOf(asset) -
                                                    1],
                                            size: iconSize),
                                        SizedBox(width: 5),
                                        Text(
                                          "${asset['symbol']}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: UserThemes(themeMode).textColor,
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Text(
                                        year['roi'].isNegative
                                            ? '${(year['roi']).toStringAsFixed(2)}%'
                                            : '${year['roi'].toStringAsFixed(2)}%',
                                        style: sublineStyle.copyWith(
                                            color: year['roi'].isNegative
                                                ? UserThemes(themeMode).redVarient
                                                : UserThemes(themeMode).greenVarient))
                                  ],
                                );
                              }).toList(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30.0, bottom: 20),
                              child: Container(
                                height: _height * 0.2,
                                child: CustomCharts(themeMode).customeLineChart(
                                    primaryData: leastAssetAnnualPerformance, colorSwitch: true),
                              ),
                            ),
                            disclaimer()
                          ],
                        ),
                      ),
                    ],
                  ),
                ))),
      ),
    );
  }

  disclaimer() {
    return Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: RichText(
            // textAlign: TextAlign.center,

            text: TextSpan(children: <TextSpan>[
          TextSpan(text: 'Disclaimer:', style: disclaimerHeader),
          TextSpan(
              text:
                  ' The figures shown relate to past performance. Past performance is not a reliable indicator of current or future results and should not be the sole factor of consideration when selecting a product or strategy.',
              style: disclaimerSub)
        ])));
  }

  Widget _sortPopupMenu() => PopupMenuButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: UserThemes(themeMode).backgroundColour,
        elevation: 8,
        offset: Offset(0, 50),
        onSelected: (value) {
          selectedSortOption = sortOptions[int.parse(value)];

          _setSort();
        },
        icon: Icon(
          Icons.sort,
          color: UserThemes(themeMode).iconColour,
          size: 20,
        ),
        itemBuilder: (context) => sortOptions.map<PopupMenuItem<String>>((String option) {
          return PopupMenuItem(
            value: option,
            child: Text(
              (DateTime.now().year - (double.parse(option)).toInt()).toString(),
              style: TextStyle(
                  color: selectedSortOption == option
                      ? UserThemes(themeMode).textColor
                      : UserThemes(themeMode).textColorVarient,
                  fontWeight: selectedSortOption == option ? FontWeight.w600 : FontWeight.w400),
            ),
          );
        }).toList(),
      );

  List<List<FlSpot>> topAssetAnnualPerformance = [];
  List<List<FlSpot>> leastAssetAnnualPerformance = [];
  setAssetPerformance() {
    for (var asset in assets) {
      asset['marketData']['chartData']['max']['years'] = [];

      for (var date in asset['marketData']['chartData']['max']['timestamp']) {
        if ((DateTime.now().year - 5) <= DateTime.parse(date).year) {
          if (asset['marketData']['chartData']['max']['years'].isEmpty) {
            asset['marketData']['chartData']['max']['years'].add({
              'id': DateTime.parse(date).year,
              'dates': [
                {
                  'date': date,
                  'value': asset['marketData']['chartData']['max']['close']
                      [asset['marketData']['chartData']['max']['timestamp'].indexOf(date)],
                  'change': 0
                }
              ]
            });
          } else {
            var isYearExist = asset['marketData']['chartData']['max']['years']
                .firstWhere((month) => month['id'] == DateTime.parse(date).year, orElse: () => null);

            if (isYearExist == null) {
              asset['marketData']['chartData']['max']['years'].add({
                'id': DateTime.parse(date).year,
                'dates': [
                  {
                    'date': date,
                    'value': asset['marketData']['chartData']['max']['close']
                        [asset['marketData']['chartData']['max']['timestamp'].indexOf(date)],
                    'change': 0
                  }
                ]
              });
            } else {
              asset['marketData']['chartData']['max']['years']
                      [asset['marketData']['chartData']['max']['years'].indexOf(isYearExist)]['dates']
                  .add({
                'date': date,
                'value': asset['marketData']['chartData']['max']['close']
                    [asset['marketData']['chartData']['max']['timestamp'].indexOf(date)],
                'change': 0
              });
            }
          }
        }
      }

      for (var year in asset['marketData']['chartData']['max']['years']) {
        var firstDataPoint = year['dates'].first;
        var lastDataPoint = year['dates'].last;

        year['roi'] = (((lastDataPoint['value'] - firstDataPoint['value'])) / firstDataPoint['value']) * 100;

        for (var date in year['dates']) {
          var change = ((date['value'] - firstDataPoint['value']) / firstDataPoint['value']) * 100;

          date['change'] = change;
        }
      }
    }

    _setSort();

    // stopwatch.stop();
    // print(stopwatch.elapsed);
  }

  List cuReturnPeriods = [
    {'period': 30, 'return': 0.0, 'id': '1-Month'},
    {'period': 90, 'return': 0.0, 'id': '3-Months'},
    {'period': 180, 'return': 0.0, 'id': '6-Months'},
    {'period': 265, 'return': 0.0, 'id': '1-year'},
    {'period': 1095, 'return': 0.0, 'id': '3-years'},
    {'period': 1825, 'return': 0.0, 'id': '5-years'}
  ];
  List<BarChartGroupData> crpCDT = [];
  getCumativeReturn() {
    crpCDT.clear();
    for (var period in cuReturnPeriods) {
      if (period['period'] < performance.length) {
        double endValue = performance[performance.length - 1]['value'];

        double startValue = performance[performance.length - period['period']]['value'];
        double periodReturn = ((endValue - startValue) / investedValue) * 100;

        period['return'] = periodReturn;
      }
    }

    // print(cuReturnPeriods);

    cuReturnPeriods = cuReturnPeriods.where((element) => element['return'] != 0.0).toList();

    int index = 0;

    for (var period in cuReturnPeriods) {
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
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              // fitInsideVertically: true,
              fitInsideHorizontally: true,
              tooltipBgColor: Colors.transparent,
              tooltipPadding: EdgeInsets.all(0),

              tooltipMargin: 5,
              getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
              ) {
                return BarTooltipItem(
                  '${rod.y.toStringAsFixed(2)}%',
                  TextStyle(
                    color: UserThemes(themeMode).textColor,
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
              getTextStyles: (value) => TextStyle(
                  color: UserThemes(themeMode).textColorVarient, fontWeight: FontWeight.w500, fontSize: 15),
              margin: 30,
              getTitles: (double value) {
                // String txt = value.toInt() == 0
                //     ? '${DateFormat('dd-MM-yyyy').format(inception_Date)} \nto \n${inception_Date.year}-12-31'
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
                FlLine(color: UserThemes(themeMode).border.withOpacity(.3), strokeWidth: 1),
            horizontalInterval: 20,
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: crpCDT),
    );
  }

  List<List<FlSpot>> currentYearMonthlyReturns = [];
  List<BarChartGroupData> monthlyReturns = [];
  List<List<FlSpot>> currentYearGrowth = [];
  List<List<FlSpot>> portfolioVSnPData = [];
  List<BarChartGroupData> allYearData = [];
  List<FlSpot> currentYearSnPGrowth = [];
  List<List<FlSpot>> yearsCDT = [];
  List years = [], usedYears = [];
  List portfolioMonths = [];
  List snpMonths = [];
  List<List> totalMonthlyReturns = [];
  setAnnualPerformanceChart() {
    currentYearMonthlyReturns.clear();
    currentYearSnPGrowth.clear();
    totalMonthlyReturns.clear();
    currentYearGrowth.clear();
    portfolioVSnPData.clear();
    portfolioMonths.clear();
    monthlyReturns.clear();
    allYearData.clear();
    snpMonths.clear();
    usedYears.clear();
    yearsCDT.clear();
    years.clear();

    // performance.sort((a, b) => DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])));

    for (var dataPoint in performance) {
      if (DateTime.parse(dataPoint['date']).year >= (DateTime.now().year - 2)) {
        dataPoint['return'] = ((dataPoint['value'] - dataPoint['invested']) / dataPoint['invested']) * 100;
        // print(dataPoint);
      }
    }

    for (var dataPoint in performance) {
      if (DateTime.parse(dataPoint['date']).year >= (DateTime.now().year - 2)) {
        if (years.isEmpty) {
          // print(dataPoint);
          // print('////////////////');
          years.add({
            'id': DateTime.parse(dataPoint['date']).year,
            'roi': 0.0,
            'addedInvesment': 0.0,
            'roi_value': 0.0,
            'dataPoints': [dataPoint]
          });
        } else {
          // if (DateTime.parse(dataPoint['date']).year != inception_Date.year) {
          var isYearExist = years.firstWhere((year) => year['id'] == DateTime.parse(dataPoint['date']).year,
              orElse: () => null);

          if (isYearExist == null) {
            years.add({
              'id': DateTime.parse(dataPoint['date']).year,
              'roi': 0.0,
              'addedInvesment': 0.0,
              'roi_value': 0.0,
              'dataPoints': [dataPoint]
            });
          } else {
            isYearExist['dataPoints'].add(dataPoint);
          }
          // }
        }
      }
    }

    double index = 0.0, indexS = 0.0;

    for (var year in years) {
      // year['dataPoints'].sort((a, b) => DateTime.parse(a['data']).compareTo(DateTime.parse(b['date'])));
      // print('===========START==================');
      // print(year['id']);

      // print('===========BEFORE==================');
      // print(year['dataPoints'].first);
      // print(year['dataPoints'].last);
      // print('===========BEFORE==================');

      var firstDataPoint = year['dataPoints'].first;
      var lastDataPoint = year['dataPoints'].last;

      for (var dataPoint in year['dataPoints']) {
        dataPoint['return'] = dataPoint['return'] -
            ((firstDataPoint['value'] - firstDataPoint['invested']) / firstDataPoint['invested']) * 100;
      }

      year['roi_value'] = (lastDataPoint['value'] - lastDataPoint['invested']) -
          (firstDataPoint['value'] - firstDataPoint['invested']);
      year['roi'] = year['dataPoints'].last['return'];

      if (year['id'] == inception_Date.year) {
        year['addedInvesment'] = lastDataPoint['invested'];
      } else {
        year['addedInvesment'] = lastDataPoint['invested'] - firstDataPoint['invested'];
      }

      index++;

      // print('===========AFTER==================');
      // print(year['dataPoints'].first);
      // print(year['dataPoints'].last);
      // print('===========AFTER==================');

      // print('===========END==================');
    }

    index = 0.0;

    for (var year in years) {
      List<FlSpot> yearTable = [];

      yearTable.clear();
      index = 0.0;

      // print(year['id']);

      for (var dataPoint in year['dataPoints']) {
        yearTable.add(FlSpot(index, double.parse(dataPoint['return'].toStringAsFixed(2))));
        index++;
      }

      // print(yearTable.first);
      // print(yearTable.last);
      // print('===========END==================');

      if (portfolioVSnPData.isEmpty) {
        portfolioVSnPData.add([FlSpot(indexS, double.parse(year['roi'].toStringAsFixed(2)))]);
      } else {
        portfolioVSnPData[0].add(FlSpot(indexS, double.parse(year['roi'].toStringAsFixed(2))));
      }

      indexS++;
      yearsCDT.add(yearTable);
    }

    indexS = 0.0;

    if (isSnpDataLoaded) {
      for (var year in snpHistoricalData) {
        if (portfolioVSnPData.length != 2) {
          portfolioVSnPData.add([FlSpot(indexS, double.parse(year['roi'].toStringAsFixed(2)))]);
        } else {
          portfolioVSnPData[1].add(FlSpot(indexS, double.parse(year['roi'].toStringAsFixed(2))));
        }

        indexS++;
      }
    }

    index = 0.0;

    for (var year in years) {
      isSnpDataLoaded
          ? allYearData.add(BarChartGroupData(
              x: index.toInt(),
              barRods: [
                BarChartRodData(
                  borderRadius: BorderRadius.circular(5),
                  y: year['roi'],
                  width: 25,
                  colors: [
                    year['id'] == DateTime.now().year
                        ? VarientColours().customColours[2]
                        : VarientColours().customColours[2].withOpacity(.4),
                  ],
                ),
                BarChartRodData(
                  borderRadius: BorderRadius.circular(5),
                  y: snpHistoricalData.firstWhere((snpYear) => year['id'] == snpYear['id'])['roi'],
                  width: 25,
                  colors: [
                    year['id'] == DateTime.now().year
                        ? VarientColours().customColours[1]
                        : VarientColours().customColours[1].withOpacity(.4),
                  ],
                )
              ],
              barsSpace: 10,
              showingTooltipIndicators: [0],
            ))
          : allYearData.add(BarChartGroupData(
              x: index.toInt(),
              barRods: [
                BarChartRodData(
                  borderRadius: BorderRadius.circular(5),
                  y: year['roi'],
                  width: 25,
                  colors: [
                    year['id'] == DateTime.now().year
                        ? VarientColours().customColours[2]
                        : VarientColours().customColours[2].withOpacity(.4),
                  ],
                )
              ],
              barsSpace: 10,
              showingTooltipIndicators: [0],
            ));
      index++;
    }

    // print(yearsCDT.length);

    // for (var year in yearsCDT) {

    //   print(year.first);
    //   print(year.last);
    //   print('===========END==================');
    // }

    indexS = 0.0;

    if (isSnpDataLoaded) {
      snpHistoricalData.forEach((year) {
        if (year['id'] == DateTime.now().year) {
          for (var dataPoint in year['dataPoints']) {
            currentYearSnPGrowth.add(FlSpot(indexS, double.parse(dataPoint['roi'].toStringAsFixed(2))));

            if (DateTime.now().month > 5) {
              if (DateTime.parse(dataPoint['date']).month >= (DateTime.now().month - 5)) {
                if (snpMonths.isEmpty) {
                  snpMonths.add({
                    'id': DateTime.parse(dataPoint['date']).month,
                    'dataPoints': [dataPoint]
                  });
                } else {
                  var isMonthExist = snpMonths.firstWhere(
                      (month) => month['id'] == DateTime.parse(dataPoint['date']).month,
                      orElse: () => null);

                  if (isMonthExist == null) {
                    snpMonths.add({
                      'id': DateTime.parse(dataPoint['date']).month,
                      'dataPoints': [dataPoint]
                    });
                  } else {
                    isMonthExist['dataPoints'].add(dataPoint);
                  }
                }
              }
            } else {
              if (snpMonths.isEmpty) {
                snpMonths.add({
                  'id': DateTime.parse(dataPoint['date']).month,
                  'dataPoints': [dataPoint]
                });
              } else {
                var isMonthExist = snpMonths.firstWhere(
                    (month) => month['id'] == DateTime.parse(dataPoint['date']).month,
                    orElse: () => null);

                if (isMonthExist == null) {
                  snpMonths.add({
                    'id': DateTime.parse(dataPoint['date']).month,
                    'dataPoints': [dataPoint]
                  });
                } else {
                  isMonthExist['dataPoints'].add(dataPoint);
                }
              }
            }

            indexS++;
          }
        }
      });
    }

    if (isSnpDataLoaded) {
      for (var month in snpMonths) {
        if (DateTime.now().month > 5) {
          if (month['id'] >= (DateTime.now().month - 5)) {
            var firstMonthDay = month['dataPoints'].first;
            var lastMonthDay = month['dataPoints'].last;

            // print(firstMonthDay);

            month['roi'] = ((lastMonthDay['close'] - firstMonthDay['open']) / firstMonthDay['close']) * 100;
          }
        } else {
          var firstMonthDay = month['dataPoints'].first;
          var lastMonthDay = month['dataPoints'].last;

          // print(firstMonthDay);

          month['roi'] = ((lastMonthDay['close'] - firstMonthDay['open']) / firstMonthDay['close']) * 100;
        }
      }
    }

    for (var year in years) {
      if (year['id'] == DateTime.now().year) {
        if (DateTime.now().month > 5) {
          for (var dataPoint in year['dataPoints']) {
            if (DateTime.parse(dataPoint['date']).month >= (DateTime.now().month - 5)) {
              if (portfolioMonths.isEmpty) {
                portfolioMonths.add({
                  'id': DateTime.parse(dataPoint['date']).month,
                  'dataPoints': [dataPoint]
                });

                // print(portfolioMonths);
              } else {
                var isMonthExist = portfolioMonths.firstWhere(
                    (month) => month['id'] == DateTime.parse(dataPoint['date']).month,
                    orElse: () => null);

                if (isMonthExist == null) {
                  portfolioMonths.add({
                    'id': DateTime.parse(dataPoint['date']).month,
                    'dataPoints': [dataPoint]
                  });
                } else {
                  isMonthExist['dataPoints'].add(dataPoint);
                }
              }
            }
          }
        } else {
          for (var dataPoint in year['dataPoints']) {
            if (portfolioMonths.isEmpty) {
              portfolioMonths.add({
                'id': DateTime.parse(dataPoint['date']).month,
                'dataPoints': [dataPoint]
              });

              // print(portfolioMonths);
            } else {
              var isMonthExist = portfolioMonths.firstWhere(
                  (month) => month['id'] == DateTime.parse(dataPoint['date']).month,
                  orElse: () => null);

              if (isMonthExist == null) {
                portfolioMonths.add({
                  'id': DateTime.parse(dataPoint['date']).month,
                  'dataPoints': [dataPoint]
                });
              } else {
                isMonthExist['dataPoints'].add(dataPoint);
              }
            }
          }
        }
      }
    }

    for (var month in portfolioMonths) {
      if (DateTime.now().month > 5) {
        if (month['id'] >= (DateTime.now().month - 5)) {
          var firstMonthDay = month['dataPoints'].first;
          var lastMonthDay = month['dataPoints'].last;

          // print(firstMonthDay);
          // print(lastMonthDay['return']);

          month['roi'] = (((lastMonthDay['value'] - lastMonthDay['invested']) -
                      (firstMonthDay['value'] - firstMonthDay['invested'])) /
                  ((firstMonthDay['value'] - firstMonthDay['invested']))) *
              100;
        }
      } else {
        var firstMonthDay = month['dataPoints'].first;
        var lastMonthDay = month['dataPoints'].last;

        // print(firstMonthDay);
        // print(lastMonthDay['return']);

        month['roi'] = (((lastMonthDay['value'] - lastMonthDay['invested']) -
                    (firstMonthDay['value'] - firstMonthDay['invested'])) /
                ((firstMonthDay['value'] - firstMonthDay['invested']))) *
            100;
      }
    }

    index = 0.0;

    for (var month in portfolioMonths) {
      isSnpDataLoaded
          ? monthlyReturns.add(BarChartGroupData(
              x: index.toInt(),
              barRods: [
                BarChartRodData(
                  borderRadius: BorderRadius.circular(5),
                  y: month['roi'],
                  width: 15,
                  colors: [
                    month['id'] == DateTime.now().month
                        ? VarientColours().customColours[2]
                        : VarientColours().customColours[2].withOpacity(.3),
                  ],
                ),
                BarChartRodData(
                  borderRadius: BorderRadius.circular(5),
                  y: snpMonths.firstWhere((snpMonth) => month['id'] == snpMonth['id'])['roi'],
                  width: 15,
                  colors: [
                    month['id'] == DateTime.now().month
                        ? VarientColours().customColours[1]
                        : VarientColours().customColours[1].withOpacity(.3),
                  ],
                )
              ],
              barsSpace: 10,
              showingTooltipIndicators: [0],
            ))
          : monthlyReturns.add(BarChartGroupData(
              x: index.toInt(),
              barRods: [
                BarChartRodData(
                  borderRadius: BorderRadius.circular(5),
                  y: month['roi'],
                  width: 15,
                  colors: [
                    month['id'] == DateTime.now().month
                        ? VarientColours().customColours[2]
                        : VarientColours().customColours[2].withOpacity(.3),
                  ],
                )
              ],
              barsSpace: 10,
              showingTooltipIndicators: [0],
            ));
      index++;
    }

    currentYearGrowth.add(yearsCDT.last);

    totalMonthlyReturns.add(portfolioMonths);

    if (isSnpDataLoaded) {
      currentYearGrowth.add(currentYearSnPGrowth);
      totalMonthlyReturns.add(snpMonths);
    }

    if (yearsCDT.length > 3) {
      yearsCDT = yearsCDT.getRange(yearsCDT.length - 4, yearsCDT.length - 1).toList();
      usedYears = years.getRange(years.length - 4, years.length - 1).toList();
    }
  }
}

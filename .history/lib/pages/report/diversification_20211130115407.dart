import 'dart:ui';
import 'package:Strice/shared/GeneralObject/generalObject.dart';
import 'package:Strice/extensions/stringExt.dart';
import 'package:Strice/shared/ads/ad.dart';
import 'package:Strice/shared/ads/ad_helper.dart';
import 'package:Strice/shared/charts/charts.dart';
import 'package:Strice/shared/decoration/customDecoration.dart';
import 'package:Strice/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/units/units.dart';
import 'package:Strice/shared/update/marketUpdate.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Diversification extends StatefulWidget {
  const Diversification({Key key}) : super(key: key);

  @override
  _DiversificationState createState() => _DiversificationState();
}

class _DiversificationState extends State<Diversification> {
  @override
  void dispose() {
    // TODO: implement dispose

    _floatingBottomAd.dispose();

    super.dispose();
  }

  var themeMode = true;

  double investedValue = 0,
      topFivePercentage = 0,
      barWidth = 10,
      _height = 0.0,
      _width = 0.0,
      raito = 0,
      iconSize = 10,
      totalReturn = 0;

  int selectedIndex = 0,
      sectorSelectedIndex = 0,
      industrySelectedIndex = 0,
      selectedIndexIndustries = 0,
      recIndex = 0,
      regionSelectedIndex = 0,
      exchangeSelectedIndex = 0,
      currencySelectedIndex = 0;

  String largestAssetType = '', baseCurrency = 'USD', currencySymbol = '';

  bool isTop = true, isSector = true, isAdLoaded = false;

  BannerAd _floatingBottomAd;

  List assets, adsGenerated = [];

  Map data;

  TextStyle tableHeaderStyle, tableDataStyle, sectionHeader, disclaimerHeader, disclaimerSub, tableNameStyle;

  adsLoaded() {
    for (int i = 0; i != 3; i++) {
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

  @override
  void initState() {
    super.initState();
    raito = (window.physicalSize.height / window.physicalSize.width);

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

  _load() {
    setState(() {
      currencySymbol = MarketUpdate(baseCurrency).getCurrencySymbol()['symbol'];
      assets = data['assets'];

      // PrintFunctions().printStartEndLine(assets.length);

      investedValue = data['invested'];
      totalReturn = data['return'];

      setTopFiveAssetChartData();
      setIndustryChartData();
      setSectorChartData();
      setRegionalChartData();
      setCurrencyChartData();
      setExchangeChartData();
    });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    data = ModalRoute.of(context).settings.arguments;

    themeMode = (data['data']['data']['states']['theme']);

    _load();

    tableHeaderStyle = TextStyle(
      fontSize: 17,
      color: UserThemes(themeMode).textColorVarient,
    );
    tableDataStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w800,
      color: UserThemes(themeMode).textColor,
    );

    tableNameStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: UserThemes(themeMode).textColor,
    );

    sectionHeader = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w300,
      color: UserThemes(themeMode).textColor,
    );
    disclaimerHeader = TextStyle(
      color: UserThemes(themeMode).textColor,
      fontWeight: FontWeight.w500,
      fontSize: 13,
    );
    disclaimerSub = TextStyle(
      color: UserThemes(themeMode).textColorVarient,
      fontSize: 12,
    );

    return Container(
        color: UserThemes(themeMode).backgroundColour,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: UserThemes(themeMode).backgroundColour,
            appBar: AppBar(
                backgroundColor: UserThemes(themeMode).backgroundColour,
                elevation: 0,
                iconTheme: IconThemeData(color: UserThemes(themeMode).backColour),
                centerTitle: true,
                title: Text('Diversification',
                    style: TextStyle(
                        color: UserThemes(themeMode).textColor, fontSize: 20, fontWeight: FontWeight.w400))),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: UserThemes(themeMode).summaryColour,
                        borderRadius: BorderRadius.circular(Units().circularRadius),
                        border: Border.all(color: UserThemes(themeMode).border, width: 1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0, top: 10),
                          child: Text('TOP 5 Holdings', style: sectionHeader),
                        ),
                        DataTable(
                            columnSpacing: 10,
                            horizontalMargin: 0,
                            showBottomBorder: false,
                            headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                              return UserThemes(themeMode).border.withOpacity(.5);
                            }),
                            headingRowHeight: 30,
                            headingTextStyle: tableHeaderStyle.copyWith(
                                color: UserThemes(themeMode).textColorVarient, fontWeight: FontWeight.w400),
                            dataRowHeight: 35,
                            dividerThickness: 0,
                            dataTextStyle: TextStyle(),
                            columns: <DataColumn>[
                              DataColumn(
                                label: Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    'Asset',
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Weight',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Invesment',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Return',
                                ),
                              )
                            ],
                            rows: topFiveAssetChartData.map((asset) {
                              return DataRow(
                                  color: MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                                      if (topFiveAssetChartData.indexOf(asset).isOdd) {
                                        return UserThemes(themeMode).border.withOpacity(.5);
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  cells: [
                                    DataCell(
                                      Container(
                                        width: _width * .37,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                '${asset.name}',
                                                style: tableNameStyle,
                                                overflow: TextOverflow.fade,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
                                          Text('${((asset.value / investedValue) * 100).toStringAsFixed(2)}%',
                                              style: tableDataStyle),
                                        ],
                                      ),
                                    ),
                                    DataCell(Center(
                                        child: Row(
                                      children: [
                                        Text('$currencySymbol${asset.value.toStringAsFixed(2).addCommas()}',
                                            style: tableDataStyle),
                                      ],
                                    ))),
                                    DataCell(Center(
                                      child: Text(
                                          asset.turn.isNegative
                                              ? '-$currencySymbol${(asset.turn * -1).toStringAsFixed(2).addCommas()}'
                                              : '+$currencySymbol${asset.turn.toStringAsFixed(2).addCommas()}',
                                          style: tableDataStyle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: asset.turn.isNegative
                                                  ? UserThemes(themeMode).redVarient
                                                  : UserThemes(themeMode).greenVarient)),
                                    )),
                                  ]);
                            }).toList()),
                        Padding(
                            padding: EdgeInsets.only(bottom: 15, top: 20),
                            child: RichText(
                                // textAlign: TextAlign.center,
                                text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: 'Disclaimer:',
                                  style: TextStyle(
                                      color: UserThemes(themeMode).textColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                              TextSpan(
                                text:
                                    ' This information is for reference only and does not constitute an investment recommendation.',
                                style: TextStyle(
                                  color: UserThemes(themeMode).textColorVarient,
                                  fontSize: 11,
                                ),
                              )
                            ])))
                      ],
                    ),
                  ),
                  adsGenerated.isEmpty
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: CustomeAdWidget(isAdLoaded, adsGenerated[0]).checkBannerAdStatus(),
                        ),
                  Container(
                    decoration: CustomDecoration(themeMode, true).baseContainerDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 20, left: 10, right: 10),
                          child: Text('SECTORS', style: sectionHeader),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: CustomDecoration(themeMode, false).baseContainerDecoration,
                            child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 25),
                              child: Container(
                                width: _width,
                                height: _height * 0.03,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: sectorCDT
                                      .map((sector) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5,
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  sectorSelectedIndex = sectorCDT.indexOf(sector);
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: sectorSelectedIndex == sectorCDT.indexOf(sector)
                                                        ? VarientColours()
                                                            .customColours[sectorCDT.indexOf(sector)]
                                                            .withOpacity(.7)
                                                        : Colors.transparent),
                                                child: Center(
                                                  child: Text(
                                                    sector.name.toString().removeStr(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15.5,
                                                        color:
                                                            sectorSelectedIndex == sectorCDT.indexOf(sector)
                                                                ? UserThemes(themeMode).textColor
                                                                : VarientColours()
                                                                    .customColours[sectorCDT.indexOf(sector)]
                                                                    .withOpacity(.7)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Center(
                                    child: SizedBox(
                                  height: _height * 0.2,
                                  width: _width * 0.43,
                                  child: CustomeCharts(themeMode).customePieChart(
                                    sectorCDT,
                                    _height,
                                    _width,
                                    selectedIndex: sectorSelectedIndex,
                                    centerData: sectorCDT[sectorSelectedIndex].weight.toStringAsFixed(2),
                                  ),
                                )),
                                Center(
                                    child: SizedBox(
                                  height: _height * 0.2,
                                  width: _width * 0.44,
                                  child: CustomeCharts(themeMode).customePieChart(
                                    sectorCDT,
                                    _height,
                                    _width,
                                    selectedIndex: sectorSelectedIndex,
                                    turn: true,
                                    totalReturn: totalReturn,
                                    centerData: ((sectorCDT[sectorSelectedIndex].turn * 100) / totalReturn)
                                        .toStringAsFixed(2),
                                  ),
                                )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: DataTable(
                                  columnSpacing: 10,
                                  horizontalMargin: 5,
                                  showBottomBorder: false,
                                  headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                                    return UserThemes(themeMode).border.withOpacity(.5);
                                    ;
                                  }),
                                  headingRowHeight: 30,
                                  headingTextStyle: tableHeaderStyle,
                                  dataRowHeight: 35,
                                  dividerThickness: 0,
                                  dataTextStyle: TextStyle(),
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: Text(
                                        'Sector (${sectorCDT.length.toString()})',
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Invested',
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Return',
                                      ),
                                    ),
                                  ],
                                  rows: sectorCDT.map((s) {
                                    return DataRow(
                                        color: MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                            if (sectorCDT.indexOf(s).isOdd) {
                                              return UserThemes(themeMode).border.withOpacity(.5);
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        cells: [
                                          DataCell(
                                            Container(
                                              width: _width * .4,
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      s.name,
                                                      style: tableNameStyle,
                                                      overflow: TextOverflow.fade,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text('$currencySymbol${s.value.toStringAsFixed(2).addCommas()}',
                                                style: tableDataStyle),
                                          ),
                                          DataCell(Text(
                                              s.turn.isNegative
                                                  ? '-$currencySymbol${(s.turn * -1).toStringAsFixed(2).addCommas()}'
                                                  : '+$currencySymbol${s.turn.toStringAsFixed(2).addCommas()}',
                                              style: tableDataStyle.copyWith(
                                                  color: s.turn.isNegative
                                                      ? UserThemes(themeMode).redVarient
                                                      : UserThemes(themeMode).greenVarient,
                                                  fontWeight: FontWeight.w500))),
                                        ]);
                                  }).toList()),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
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
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text('INDUSTRIES', style: sectionHeader),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 25),
                              child: Container(
                                width: _width,
                                height: _height * 0.03,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: industryCDT
                                      .map((industry) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5,
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  industrySelectedIndex = industryCDT.indexOf(industry);
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color:
                                                        industrySelectedIndex == industryCDT.indexOf(industry)
                                                            ? VarientColours()
                                                                .customColours[industryCDT.indexOf(industry)]
                                                                .withOpacity(.7)
                                                            : Colors.transparent),
                                                child: Center(
                                                  child: Text(
                                                    industry.name.toString().removeStr(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15.5,
                                                        color: industrySelectedIndex ==
                                                                industryCDT.indexOf(industry)
                                                            ? UserThemes(themeMode).textColor
                                                            : VarientColours()
                                                                .customColours[industryCDT.indexOf(industry)]
                                                                .withOpacity(.7)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Center(
                                    child: SizedBox(
                                  height: _height * 0.2,
                                  width: _width * 0.44,
                                  child: CustomeCharts(themeMode).customePieChart(
                                    industryCDT,
                                    _height,
                                    _width,
                                    selectedIndex: industrySelectedIndex,
                                    centerData: industryCDT[industrySelectedIndex].weight.toStringAsFixed(2),
                                  ),
                                )),
                                Center(
                                    child: SizedBox(
                                  height: _height * 0.2,
                                  width: _width * 0.44,
                                  child: CustomeCharts(themeMode).customePieChart(
                                    industryCDT,
                                    _height,
                                    _width,
                                    selectedIndex: industrySelectedIndex,
                                    turn: true,
                                    totalReturn: totalReturn,
                                    centerData:
                                        ((industryCDT[industrySelectedIndex].turn * 100) / totalReturn)
                                            .toStringAsFixed(2),
                                  ),
                                )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: DataTable(
                                  columnSpacing: 10,
                                  horizontalMargin: 5,
                                  showBottomBorder: false,
                                  headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                                    return UserThemes(themeMode).border.withOpacity(.5);
                                    ;
                                  }),
                                  headingRowHeight: 30,
                                  headingTextStyle: tableHeaderStyle,
                                  dataRowHeight: 35,
                                  dividerThickness: 0,
                                  dataTextStyle: TextStyle(),
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: Text(
                                        'Industry (${industryCDT.length.toString()})',
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Invested',
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Return',
                                      ),
                                    ),
                                  ],
                                  rows: industryCDT.map((i) {
                                    return DataRow(
                                        color: MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                            if (industryCDT.indexOf(i).isOdd) {
                                              return UserThemes(themeMode).border.withOpacity(.5);
                                              ;
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        cells: [
                                          DataCell(
                                            Container(
                                              width: _width * .4,
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      i.name,
                                                      style: tableNameStyle,
                                                      overflow: TextOverflow.fade,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text('$currencySymbol${i.value.toStringAsFixed(2).addCommas()}',
                                                style: tableDataStyle),
                                          ),
                                          DataCell(Text(
                                              i.turn.isNegative
                                                  ? '-$currencySymbol${(i.turn * -1).toStringAsFixed(2).addCommas()}'
                                                  : '+$currencySymbol${i.turn.toStringAsFixed(2).addCommas()}',
                                              style: tableDataStyle.copyWith(
                                                  color: i.turn.isNegative
                                                      ? UserThemes(themeMode).redVarient
                                                      : UserThemes(themeMode).greenVarient,
                                                  fontWeight: FontWeight.w500))),
                                        ]);
                                  }).toList()),
                            ),
                          ],
                        )),
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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 5),
                              child: Text('REGIONS', style: sectionHeader),
                            ),
                            DataTable(
                                columnSpacing: 10,
                                horizontalMargin: 5,
                                showBottomBorder: false,
                                headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                                  return UserThemes(themeMode).border.withOpacity(.5);
                                  ;
                                }),
                                headingRowHeight: 30,
                                headingTextStyle: tableHeaderStyle,
                                dataRowHeight: 35,
                                dividerThickness: 0,
                                dataTextStyle: TextStyle(),
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'Region (${regionsCDT.length.toString()})',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Weight',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Invested',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Return',
                                    ),
                                  ),
                                ],
                                rows: regionsCDT.map((r) {
                                  return DataRow(
                                      color: MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                          if (regionsCDT.indexOf(r).isOdd) {
                                            return UserThemes(themeMode).border.withOpacity(.5);
                                            ;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      cells: [
                                        DataCell(
                                          Container(
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    r.name,
                                                    style: tableNameStyle,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text('${r.weight.toStringAsFixed(2).addCommas()}%',
                                              style: tableDataStyle),
                                        ),
                                        DataCell(
                                          Text('$currencySymbol${r.value.toStringAsFixed(2).addCommas()}',
                                              style: tableDataStyle),
                                        ),
                                        DataCell(Text(
                                            r.turn.isNegative
                                                ? '-$currencySymbol${(r.turn * -1).toStringAsFixed(2).addCommas()}'
                                                : '+$currencySymbol${r.turn.toStringAsFixed(2).addCommas()}',
                                            style: tableDataStyle.copyWith(
                                                color: r.turn.isNegative
                                                    ? UserThemes(themeMode).redVarient
                                                    : UserThemes(themeMode).greenVarient,
                                                fontWeight: FontWeight.w500))),
                                      ]);
                                }).toList()),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, bottom: 5),
                                child: Text('EXCHANGE', style: sectionHeader),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(
                              //     bottom: 15.0,
                              //   ),
                              //   child: RichText(
                              //       text: TextSpan(children: <TextSpan>[
                              //     TextSpan(text: 'Exchange - ', style: disclaimerHeader),
                              //     TextSpan(
                              //         text: 'Place where shares of pubic listed companies are traded',
                              //         style: disclaimerSub)
                              //   ])),
                              // ),
                              DataTable(
                                  columnSpacing: 10,
                                  horizontalMargin: 5,
                                  showBottomBorder: false,
                                  headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                                    return UserThemes(themeMode).border.withOpacity(.5);
                                    ;
                                  }),
                                  headingRowHeight: 30,
                                  headingTextStyle: tableHeaderStyle,
                                  dataRowHeight: 35,
                                  dividerThickness: 0,
                                  dataTextStyle: TextStyle(),
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: Text(
                                        'Exchange (${exchangeCDT.length.toString()})',
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Weight',
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Invested',
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Return',
                                      ),
                                    ),
                                  ],
                                  rows: exchangeCDT.map((ex) {
                                    return DataRow(
                                        color: MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                            if (exchangeCDT.indexOf(ex).isOdd) {
                                              return UserThemes(themeMode).border.withOpacity(.5);
                                              ;
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        cells: [
                                          DataCell(
                                            Container(
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      ex.name,
                                                      style: tableNameStyle,
                                                      overflow: TextOverflow.fade,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text('${ex.weight.toStringAsFixed(2).addCommas()}%',
                                                style: tableDataStyle),
                                          ),
                                          DataCell(
                                            Text('$currencySymbol${ex.value.toStringAsFixed(2).addCommas()}',
                                                style: tableDataStyle),
                                          ),
                                          DataCell(Text(
                                              ex.turn.isNegative
                                                  ? '-$currencySymbol${(ex.turn * -1).toStringAsFixed(2).addCommas()}'
                                                  : '+$currencySymbol${ex.turn.toStringAsFixed(2).addCommas()}',
                                              style: tableDataStyle.copyWith(
                                                  color: ex.turn.isNegative
                                                      ? UserThemes(themeMode).redVarient
                                                      : UserThemes(themeMode).greenVarient,
                                                  fontWeight: FontWeight.w500))),
                                        ]);
                                  }).toList()),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 5),
                              child: Text('CURRENCIES', style: sectionHeader),
                            ),
                            DataTable(
                                columnSpacing: 10,
                                horizontalMargin: 5,
                                showBottomBorder: false,
                                headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                                  return UserThemes(themeMode).border.withOpacity(.5);
                                  ;
                                }),
                                headingRowHeight: 30,
                                headingTextStyle: tableHeaderStyle,
                                dataRowHeight: 35,
                                dividerThickness: 0,
                                dataTextStyle: TextStyle(),
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'Currency (${currencyCDT.length.toString()})',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Weight',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Invested',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Return',
                                    ),
                                  ),
                                ],
                                rows: currencyCDT.map((c) {
                                  return DataRow(
                                      color: MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                          if (currencyCDT.indexOf(c).isOdd) {
                                            return UserThemes(themeMode).border.withOpacity(.5);
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      cells: [
                                        DataCell(
                                          Container(
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    c.name,
                                                    style: tableNameStyle,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text('${c.weight.toStringAsFixed(2).addCommas()}%',
                                              style: tableDataStyle),
                                        ),
                                        DataCell(
                                          Text('$currencySymbol${c.value.toStringAsFixed(2).addCommas()}',
                                              style: tableDataStyle),
                                        ),
                                        DataCell(Text(
                                            c.turn.isNegative
                                                ? '-$currencySymbol${(c.turn * -1).toStringAsFixed(2).addCommas()}'
                                                : '+$currencySymbol${c.turn.toStringAsFixed(2).addCommas()}',
                                            style: tableDataStyle.copyWith(
                                                color: c.turn.isNegative
                                                    ? UserThemes(themeMode).redVarient
                                                    : UserThemes(themeMode).greenVarient,
                                                fontWeight: FontWeight.w500))),
                                      ]);
                                }).toList()),
                          ],
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  List<GeneralObject> topFiveAssetChartData = [];
  double topAssetReturn = 0;
  setTopFiveAssetChartData() {
    topFivePercentage = 0.0;
    topAssetReturn = 0.0;
    topFiveAssetChartData.clear();

    for (var stock in assets) {
      topFiveAssetChartData.add(new GeneralObject(
          name: stock['marketData']['quote']['displayName'] == null
              ? stock['marketData']['quote']['longName']
              : stock['marketData']['quote']['displayName'],
          symbol: stock['marketData']['quote']['symbol'],
          value: (double.parse(stock['shares'].toString())) * double.parse(stock['buyPrice'].toString()),
          turn: stock['change']));
    }

    topFiveAssetChartData.sort((a, b) => a.value.compareTo(b.value));

    if (isTop == true) {
      topFiveAssetChartData = topFiveAssetChartData.reversed.toList();
    }

    topFiveAssetChartData = topFiveAssetChartData.length >= 5
        ? topFiveAssetChartData.getRange(0, 5).toList()
        : topFiveAssetChartData.getRange(0, topFiveAssetChartData.length).toList();

    for (var asset in topFiveAssetChartData) {
      topFivePercentage += (asset.value / investedValue) * 100;
      topAssetReturn += asset.turn;
    }
  }

  List<GeneralObject> industryCDT = [];
  setIndustryChartData() {
    industryCDT.clear();

    for (var stock in assets) {
      if (industryCDT.isEmpty) {
        industryCDT.add(GeneralObject(
            name: (stock['marketData']['assets'].containsKey('industry') == false)
                ? 'Others'
                : stock['marketData']['assets']['industry'],
            value: stock['Invested'].toDouble(),
            assetLength: 1,
            assetList: [stock],
            turn: stock['change'],
            weight: (stock['Invested'] / investedValue) * 100));
      } else {
        var isGeneralObjectExist = industryCDT.firstWhere(
            (region) =>
                region.name ==
                ((stock['marketData']['assets'].containsKey('industry') == false)
                    ? 'Others'
                    : stock['marketData']['assets']['industry']),
            orElse: () => null);

        if (isGeneralObjectExist == null) {
          industryCDT.add(GeneralObject(
              name: (stock['marketData']['assets'].containsKey('industry') == false)
                  ? 'Others'
                  : stock['marketData']['assets']['industry'],
              value: stock['Invested'].toDouble(),
              assetLength: 1,
              assetList: [stock],
              turn: stock['change'],
              weight: (stock['Invested'] / investedValue) * 100));
        } else {
          industryCDT.remove(isGeneralObjectExist);

          industryCDT.add(GeneralObject(
              name: isGeneralObjectExist.name,
              value: isGeneralObjectExist.value + stock['Invested'].toDouble(),
              assetLength: isGeneralObjectExist.assetLength + 1,
              assetList: isGeneralObjectExist.assetList + [stock],
              turn: isGeneralObjectExist.turn + stock['change'],
              weight: isGeneralObjectExist.weight + (stock['Invested'] / investedValue) * 100));
        }
      }
    }
  }

  List<GeneralObject> sectorCDT = [];
  setSectorChartData() {
    sectorCDT.clear();

    for (var stock in assets) {
      // PrintFunctions().printStartEndLine(stock['marketData']['assets']['sector']);
      if (sectorCDT.isEmpty) {
        // PrintFunctions().printStartEndLine(!(stock['marketData'].containsKey('assets')));

        // Map g;

        sectorCDT.add(GeneralObject(
            name: (stock['marketData']['assets'].containsKey('sector') == false)
                ? 'Others'
                : stock['marketData']['assets']['sector'],
            value: stock['Invested'].toDouble(),
            assetLength: 1,
            assetList: [stock],
            turn: stock['change'],
            weight: (stock['Invested'] / investedValue) * 100));
      } else {
        var isGeneralObjectExist = sectorCDT.firstWhere(
            (region) =>
                region.name ==
                ((stock['marketData']['assets'].containsKey('sector') == false)
                    ? 'Others'
                    : stock['marketData']['assets']['sector']),
            orElse: () => null);

        if (isGeneralObjectExist == null) {
          sectorCDT.add(GeneralObject(
              name: (stock['marketData']['assets'].containsKey('sector')) == false
                  ? 'Others'
                  : stock['marketData']['assets']['sector'],
              value: stock['Invested'].toDouble(),
              assetLength: 1,
              assetList: [stock],
              turn: stock['change'],
              weight: (stock['Invested'] / investedValue) * 100));
        } else {
          sectorCDT.remove(isGeneralObjectExist);

          sectorCDT.add(GeneralObject(
              name: isGeneralObjectExist.name,
              value: isGeneralObjectExist.value + stock['Invested'].toDouble(),
              assetLength: isGeneralObjectExist.assetLength + 1,
              assetList: isGeneralObjectExist.assetList + [stock],
              turn: isGeneralObjectExist.turn + stock['change'],
              weight: isGeneralObjectExist.weight + (stock['Invested'] / investedValue) * 100));
        }
      }
    }

    // for (var sector in sectorCDT) {
    //   var industries = industryCDT.where((industry) => industry.subSector == sector.name).toList();

    //   sector.subAssets = industries;
    // }

    // PrintFunctions().printStartEndLine(sectorCDT.first.subAssets.length);
  }

  List<GeneralObject> regionsCDT = [];
  List rGeneralObject = [];
  setRegionalChartData() {
    rGeneralObject.clear();
    regionsCDT.clear();

    for (var stock in assets) {
      if (regionsCDT.isEmpty) {
        regionsCDT.add(GeneralObject(
            name: (stock['marketData']['assets'].containsKey('country') == false)
                ? 'Others'
                : stock['marketData']['assets']['country'],
            value: stock['Invested'].toDouble(),
            assetList: [stock],
            turn: stock['change'],
            weight: (stock['Invested'] / investedValue) * 100,
            assetLength: 1));
      } else {
        var isGeneralObjectExist = regionsCDT.firstWhere(
            (region) =>
                region.name ==
                ((stock['marketData']['assets'].containsKey('country') == false)
                    ? 'Others'
                    : stock['marketData']['assets']['country']),
            orElse: () => null);

        if (isGeneralObjectExist == null) {
          regionsCDT.add(GeneralObject(
              name: (stock['marketData']['assets'].containsKey('country') == false)
                  ? 'Others'
                  : stock['marketData']['assets']['country'],
              value: stock['Invested'].toDouble(),
              turn: stock['change'],
              assetList: [stock],
              weight: (stock['Invested'] / investedValue) * 100,
              assetLength: 1));
        } else {
          rGeneralObject.clear();
          regionsCDT.remove(isGeneralObjectExist);

          // print(isGeneralObjectExist.assetList.length);

          rGeneralObject = isGeneralObjectExist.assetList;
          rGeneralObject.add(stock);

          // print(rGeneralObject.length);

          regionsCDT.add(GeneralObject(
              name: isGeneralObjectExist.name,
              value: isGeneralObjectExist.value + stock['Invested'].toDouble(),
              assetList: rGeneralObject,
              turn: isGeneralObjectExist.turn + stock['change'],
              assetLength: isGeneralObjectExist.assetLength + 1,
              weight: isGeneralObjectExist.weight + (stock['Invested'] / investedValue) * 100));
        }
      }
    }
  }

  List<GeneralObject> currencyCDT = [];
  setCurrencyChartData() {
    currencyCDT.clear();
    for (var stock in assets) {
      if (currencyCDT.isEmpty) {
        currencyCDT.add(GeneralObject(
            name: stock['marketData']['quote']['currency'],
            value: stock['Invested'].toDouble(),
            assetLength: 1,
            turn: stock['change'],
            weight: (stock['Invested'] / investedValue) * 100));
      } else {
        var isGeneralObjectExist = currencyCDT.firstWhere(
            (currency) => currency.name == stock['marketData']['quote']['currency'],
            orElse: () => null);

        if (isGeneralObjectExist == null) {
          currencyCDT.add(GeneralObject(
              name: stock['marketData']['quote']['currency'],
              value: stock['Invested'].toDouble(),
              assetLength: 1,
              turn: stock['change'],
              weight: (stock['Invested'] / investedValue) * 100));
        } else {
          currencyCDT.remove(isGeneralObjectExist);

          currencyCDT.add(GeneralObject(
              name: isGeneralObjectExist.name,
              value: isGeneralObjectExist.value + stock['Invested'].toDouble(),
              assetLength: isGeneralObjectExist.assetLength + 1,
              turn: isGeneralObjectExist.turn + stock['change'],
              weight: isGeneralObjectExist.weight + (stock['Invested'] / investedValue) * 100));
        }
      }
    }
  }

  List<GeneralObject> exchangeCDT = [];
  setExchangeChartData() {
    exchangeCDT.clear();

    for (var stock in assets) {
      if (exchangeCDT.isEmpty) {
        exchangeCDT.add(GeneralObject(
            name: stock['marketData']['quote']['exchange'],
            value: stock['Invested'].toDouble(),
            assetLength: 1,
            turn: stock['change'],
            weight: (stock['Invested'] / investedValue) * 100));
      } else {
        var isGeneralObjectExist = exchangeCDT.firstWhere(
            (region) => region.name == stock['marketData']['quote']['exchange'],
            orElse: () => null);

        if (isGeneralObjectExist == null) {
          exchangeCDT.add(GeneralObject(
              name: stock['marketData']['quote']['exchange'],
              value: stock['Invested'].toDouble(),
              assetLength: 1,
              turn: stock['change'],
              weight: (stock['Invested'] / investedValue) * 100));
        } else {
          exchangeCDT.remove(isGeneralObjectExist);

          exchangeCDT.add(GeneralObject(
              name: isGeneralObjectExist.name,
              value: isGeneralObjectExist.value + stock['Invested'].toDouble(),
              assetLength: isGeneralObjectExist.assetLength + 1,
              turn: isGeneralObjectExist.turn + stock['change'],
              weight: isGeneralObjectExist.weight + (stock['Invested'] / investedValue) * 100));
        }
      }
    }
  }

  List<BarChartGroupData> assetTypeGCDT = [];
  List<GeneralObject> assetTypeCDT = [];

  setAssetTypeChartData() {
    assetTypeGCDT.clear();
    assetTypeCDT.clear();

    assetTypeCDT = [
      GeneralObject(name: 'EQUITY', value: 0, turn: 0, assetLength: 0, weight: 0),
      GeneralObject(name: 'ETF', value: 0, turn: 0, assetLength: 0, weight: 0),
      GeneralObject(name: 'CASH', value: 0, turn: 0, assetLength: 0, weight: 0),
      GeneralObject(name: 'Cryptocurrency', value: 0, turn: 0, assetLength: 0, weight: 0),
    ];

    for (var stock in assets) {
      if (assetTypeCDT.isEmpty) {
        assetTypeCDT.add(GeneralObject(
            name: stock['marketData']['quote']['quoteType'] == null
                ? 'Others'
                : stock['marketData']['quote']['quoteType'],
            value: stock['Invested'].toDouble(),
            assetLength: 1,
            turn: stock['change'],
            weight: (stock['Invested'] / investedValue) * 100));
      } else {
        var isGeneralObjectExist = assetTypeCDT.firstWhere(
            (region) =>
                region.name ==
                ((stock['marketData']['quote']['quoteType'] == null)
                    ? 'Others'
                    : stock['marketData']['quote']['quoteType']),
            orElse: () => null);

        if (isGeneralObjectExist == null) {
          assetTypeCDT.add(GeneralObject(
              name: stock['marketData']['quote']['quoteType'] == null
                  ? 'Others'
                  : stock['marketData']['quote']['quoteType'],
              value: stock['Invested'].toDouble(),
              assetLength: 1,
              turn: stock['change'],
              weight: (stock['Invested'] / investedValue) * 100));
        } else {
          assetTypeCDT.remove(isGeneralObjectExist);

          assetTypeCDT.add(GeneralObject(
              name: isGeneralObjectExist.name,
              value: isGeneralObjectExist.value + stock['Invested'].toDouble(),
              assetLength: isGeneralObjectExist.assetLength + 1,
              turn: isGeneralObjectExist.turn + stock['change'],
              weight: isGeneralObjectExist.weight + (stock['Invested'] / investedValue) * 100));
        }
      }
    }
    assetTypeCDT.sort((a, b) {
      return a.weight.compareTo(b.weight);
    });

    largestAssetType = assetTypeCDT.last.name;

    assetTypeCDT.shuffle();

    for (var type in assetTypeCDT) {
      assetTypeGCDT.add(BarChartGroupData(
        x: assetTypeCDT.indexOf(type),
        barRods: [
          BarChartRodData(
            y: type.weight,
            colors: [VarientColours().customColours[assetTypeCDT.indexOf(type) + 5]],
            width: barWidth,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              y: 100,
              colors: [UserThemes(themeMode).backgroundColour.withOpacity(.5)],
            ),
          ),
        ],
        // showingTooltipIndicators: showTooltips,
      ));
    }

    return assetTypeGCDT;
  }
}

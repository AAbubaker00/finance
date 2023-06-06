import 'dart:ui';
import 'package:Onvest/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Onvest/shared/Custome_Widgets/loading/loading.dart';
import 'package:Onvest/shared/Custome_Widgets/restricted/restricted.dart';
import 'package:Onvest/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvest/shared/GeneralObject/generalObject.dart';
import 'package:Onvest/extensions/stringExt.dart';
import 'package:Onvest/shared/TextStyle/customTextStyles.dart';
import 'package:Onvest/shared/dataObject/data_object.dart';
import 'package:Onvest/shared/decoration/customDecoration.dart';
import 'package:Onvest/shared/themes/themes.dart';
import 'package:Onvest/shared/units/units.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Diversification extends StatefulWidget {
  final DataObject dataObject;

  const Diversification({Key key, @required this.dataObject}) : super(key: key);

  @override
  _DiversificationState createState() => _DiversificationState();
}

class _DiversificationState extends State<Diversification> {
  double investedValue = 0, topFivePercentage = 0, barWidth = 10, totalReturn = 0;

  int selectedIndex = 0,
      sectorSelectedIndex = 0,
      industrySelectedIndex = 0,
      selectedIndexIndustries = 0,
      recIndex = 0,
      regionSelectedIndex = 0,
      exchangeSelectedIndex = 0,
      currencySelectedIndex = 0;

  bool isTop = true, isSector = true, isLoaded = false, isAdLoaded = false;

  List assets, adsGenerated = [];

  Map data;

  Future<bool> _load() async {
    assets = data['holdings'];

    // PrintFunctions().printStartEndLine(assets.length);

    investedValue = data['invested'];
    totalReturn = data['return'];

    await setTopFiveAssetChartData();
    await setIndustryChartData();
    await setSectorChartData();
    await setRegionalChartData();
    await setExchangeChartData();

    isLoaded = true;
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    return FutureBuilder<bool>(
      future: isLoaded ? Future.value(true) : _load(),
      builder: (context, snapshot) {
        if (isLoaded == true) {
          return CWScaffold(
            appBarTitle: 'Diversification',
            dataObject: widget.dataObject,
            isCenter: true,
            bottomAppBarBorderColour: false,
            body: widget.dataObject.userFire.isAnonymous
                ? Restricted(
                    dataObject: widget.dataObject,
                  )
                : CWListView(
                    children: [
                      getTopFive(),
                      SizedBox(
                        height: Units().mainSpacing,
                      ),
                      getSectors(),
                      SizedBox(
                        height: Units().mainSpacing,
                      ),
                      getIndustries(),
                      SizedBox(
                        height: Units().mainSpacing,
                      ),
                      getBottom()
                    ],
                  ),
          );
        } else {
          // print('loading');
          return Loading(
            theme: widget.dataObject.theme,
          );
        }
      },
    );
  }

  getTopFive() {
    return Container(
      decoration: CustomDecoration(widget.dataObject.theme).topWidgetDecoration,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Top 5 Holdings', style: CustomTextStyles(widget.dataObject.theme).sectionHeader),
              ],
            ),
          ),
          DataTable(
              columnSpacing: 10,
              horizontalMargin: 0,
              showBottomBorder: false,
              headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                return UserThemes(widget.dataObject.theme).seperator.withOpacity(.5);
              }),
              headingRowHeight: 30,
              headingTextStyle: CustomTextStyles(widget.dataObject.theme).sectionSubTextStyle.copyWith(
                  color: UserThemes(widget.dataObject.theme).textColorVarient, fontWeight: FontWeight.w400),
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
                          return UserThemes(widget.dataObject.theme).seperator.withOpacity(.5);
                        } else {
                          return null;
                        }
                      },
                    ),
                    cells: [
                      DataCell(
                        Container(
                          width: widget.dataObject.width * .3,
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  '${asset.name.removeStr()}',
                                  style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataCell(
                        Text('${((asset.value / investedValue) * 100).toStringAsFixed(2)}%',
                            style: CustomTextStyles(widget.dataObject.theme).tableValueStyle),
                      ),
                      DataCell(Center(
                          child: Text(
                              '${widget.dataObject.userCurrencySymbol}${asset.value.toStringAsFixed(2).addCommas()}',
                              style: CustomTextStyles(widget.dataObject.theme).tableValueStyle))),
                      DataCell(Text(
                          asset.turn.isNegative
                              ? '-${widget.dataObject.userCurrencySymbol}${(asset.turn * -1).toStringAsFixed(2).addCommas()}'
                              : '+${widget.dataObject.userCurrencySymbol}${asset.turn.toStringAsFixed(2).addCommas()}',
                          style: CustomTextStyles(widget.dataObject.theme).tableValueStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: asset.turn.isNegative
                                  ? UserThemes(widget.dataObject.theme).redVarient
                                  : UserThemes(widget.dataObject.theme).greenVarient))),
                    ]);
              }).toList()),
        ],
      ),
    );
  }

  getIndustries() {
    return Container(
        decoration: CustomDecoration(widget.dataObject.theme).baseContainerDecoration,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Industries', style: CustomTextStyles(widget.dataObject.theme).sectionHeader),
                ],
              ),
            ),
            DataTable(
                columnSpacing: 10,
                horizontalMargin: 5,
                showBottomBorder: false,
                headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                  return UserThemes(widget.dataObject.theme).seperator.withOpacity(.5);
                }),
                headingRowHeight: 30,
                headingTextStyle: CustomTextStyles(widget.dataObject.theme).sectionSubTextStyle,
                dataRowHeight: 35,
                dividerThickness: 0,
                dataTextStyle: TextStyle(),
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Industry',
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
                rows: industryCDT.map((i) {
                  return DataRow(
                      color: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                          if (industryCDT.indexOf(i).isOdd) {
                            return UserThemes(widget.dataObject.theme).seperator.withOpacity(.5);
                          } else {
                            return null;
                          }
                        },
                      ),
                      cells: [
                        DataCell(
                          Container(
                            width: widget.dataObject.width * .3,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    i.name,
                                    style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        DataCell(
                          Text('${((i.value / investedValue) * 100).toStringAsFixed(2)}%',
                              style: CustomTextStyles(widget.dataObject.theme).tableValueStyle),
                        ),
                        DataCell(
                          Text(
                              '${widget.dataObject.userCurrencySymbol}${i.value.toStringAsFixed(2).addCommas()}',
                              style: CustomTextStyles(widget.dataObject.theme).tableValueStyle),
                        ),
                        DataCell(Text(
                            i.turn.isNegative
                                ? '-${widget.dataObject.userCurrencySymbol}${(i.turn * -1).toStringAsFixed(2).addCommas()}'
                                : '+${widget.dataObject.userCurrencySymbol}${i.turn.toStringAsFixed(2).addCommas()}',
                            style: CustomTextStyles(widget.dataObject.theme).tableValueStyle.copyWith(
                                color: i.turn.isNegative
                                    ? UserThemes(widget.dataObject.theme).redVarient
                                    : UserThemes(widget.dataObject.theme).greenVarient,
                                fontWeight: FontWeight.w500))),
                      ]);
                }).toList()),
          ],
        ));
  }

  getSectors() {
    return Container(
      decoration: CustomDecoration(widget.dataObject.theme).baseContainerDecoration,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Sectors', style: CustomTextStyles(widget.dataObject.theme).sectionHeader),
              ],
            ),
          ),
          DataTable(
              columnSpacing: 10,
              horizontalMargin: 5,
              showBottomBorder: false,
              headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                return UserThemes(widget.dataObject.theme).seperator.withOpacity(.5);
              }),
              headingRowHeight: 30,
              headingTextStyle: CustomTextStyles(widget.dataObject.theme).sectionSubTextStyle,
              dataRowHeight: 35,
              dividerThickness: 0,
              dataTextStyle: TextStyle(),
              columns: <DataColumn>[
                DataColumn(
                  label: Text(
                    'Sector',
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
              rows: sectorCDT.map((s) {
                return DataRow(
                    color: MaterialStateProperty.resolveWith<Color>(
                      (states) {
                        if (sectorCDT.indexOf(s).isOdd) {
                          return UserThemes(widget.dataObject.theme).seperator.withOpacity(.5);
                        } else {
                          return null;
                        }
                      },
                    ),
                    cells: [
                      DataCell(
                        Container(
                          width: widget.dataObject.width * .3,
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  s.name,
                                  style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataCell(
                        Text('${((s.value / investedValue) * 100).toStringAsFixed(2)}%',
                            style: CustomTextStyles(widget.dataObject.theme).tableValueStyle),
                      ),
                      DataCell(
                        Text(
                            '${widget.dataObject.userCurrencySymbol}${s.value.toStringAsFixed(2).addCommas()}',
                            style: CustomTextStyles(widget.dataObject.theme).tableValueStyle),
                      ),
                      DataCell(Text(
                          s.turn.isNegative
                              ? '-${widget.dataObject.userCurrencySymbol}${(s.turn * -1).toStringAsFixed(2).addCommas()}'
                              : '+${widget.dataObject.userCurrencySymbol}${s.turn.toStringAsFixed(2).addCommas()}',
                          style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle.copyWith(
                              color: s.turn.isNegative
                                  ? UserThemes(widget.dataObject.theme).redVarient
                                  : UserThemes(widget.dataObject.theme).greenVarient,
                              fontWeight: FontWeight.w500))),
                    ]);
              }).toList())
        ],
      ),
    );
  }

  getBottom() {
    return Container(
      decoration: CustomDecoration(widget.dataObject.theme).baseContainerDecoration,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Regions', style: CustomTextStyles(widget.dataObject.theme).sectionHeader),
                  ],
                ),
              ),
              DataTable(
                  columnSpacing: 10,
                  horizontalMargin: 5,
                  showBottomBorder: false,
                  headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                    return UserThemes(widget.dataObject.theme).seperator.withOpacity(.5);
                  }),
                  headingRowHeight: 30,
                  headingTextStyle: CustomTextStyles(widget.dataObject.theme).sectionSubTextStyle,
                  dataRowHeight: 35,
                  dividerThickness: 0,
                  dataTextStyle: TextStyle(),
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Region',
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
                              return UserThemes(widget.dataObject.theme).seperator.withOpacity(.5);
                              ;
                            } else {
                              return null;
                            }
                          },
                        ),
                        cells: [
                          DataCell(
                            Container(
                              width: widget.dataObject.width * .3,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      r.name,
                                      style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          DataCell(
                            Text('${r.weight.toStringAsFixed(2).addCommas()}%',
                                style: CustomTextStyles(widget.dataObject.theme).tableValueStyle),
                          ),
                          DataCell(
                            Text(
                                '${widget.dataObject.userCurrencySymbol}${r.value.toStringAsFixed(2).addCommas()}',
                                style: CustomTextStyles(widget.dataObject.theme).tableValueStyle),
                          ),
                          DataCell(Text(
                              r.turn.isNegative
                                  ? '-${widget.dataObject.userCurrencySymbol}${(r.turn * -1).toStringAsFixed(2).addCommas()}'
                                  : '+${widget.dataObject.userCurrencySymbol}${r.turn.toStringAsFixed(2).addCommas()}',
                              style: CustomTextStyles(widget.dataObject.theme).tableValueStyle.copyWith(
                                  color: r.turn.isNegative
                                      ? UserThemes(widget.dataObject.theme).redVarient
                                      : UserThemes(widget.dataObject.theme).greenVarient,
                                  fontWeight: FontWeight.w500))),
                        ]);
                  }).toList()),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Exchanges', style: CustomTextStyles(widget.dataObject.theme).sectionHeader),
                    ],
                  ),
                ),
                DataTable(
                    columnSpacing: 10,
                    horizontalMargin: 5,
                    showBottomBorder: false,
                    headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                      return UserThemes(widget.dataObject.theme).seperator.withOpacity(.5);
                    }),
                    headingRowHeight: 30,
                    headingTextStyle: CustomTextStyles(widget.dataObject.theme).sectionSubTextStyle,
                    dataRowHeight: 35,
                    dividerThickness: 0,
                    dataTextStyle: TextStyle(),
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Exchange',
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
                                return UserThemes(widget.dataObject.theme).seperator.withOpacity(.5);
                                ;
                              } else {
                                return null;
                              }
                            },
                          ),
                          cells: [
                            DataCell(
                              Container(
                                width: widget.dataObject.width * .3,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        ex.name,
                                        style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            DataCell(
                              Text('${ex.weight.toStringAsFixed(2).addCommas()}%',
                                  style: CustomTextStyles(widget.dataObject.theme).tableValueStyle),
                            ),
                            DataCell(
                              Text(
                                  '${widget.dataObject.userCurrencySymbol}${ex.value.toStringAsFixed(2).addCommas()}',
                                  style: CustomTextStyles(widget.dataObject.theme).tableValueStyle),
                            ),
                            DataCell(Text(
                                ex.turn.isNegative
                                    ? '-${widget.dataObject.userCurrencySymbol}${(ex.turn * -1).toStringAsFixed(2).addCommas()}'
                                    : '+${widget.dataObject.userCurrencySymbol}${ex.turn.toStringAsFixed(2).addCommas()}',
                                style: CustomTextStyles(widget.dataObject.theme).tableValueStyle.copyWith(
                                    color: ex.turn.isNegative
                                        ? UserThemes(widget.dataObject.theme).redVarient
                                        : UserThemes(widget.dataObject.theme).greenVarient,
                                    fontWeight: FontWeight.w500))),
                          ]);
                    }).toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<GeneralObject> topFiveAssetChartData = [];
  double topAssetReturn = 0;
  setTopFiveAssetChartData() async {
    topFivePercentage = 0.0;
    topAssetReturn = 0.0;
    topFiveAssetChartData.clear();

    for (var stock in assets) {
      topFiveAssetChartData.add(new GeneralObject(
          name: stock['marketData']['quote'].containsKey('longName')
              ? stock['marketData']['quote']['longName']
              : stock['marketData']['quote']['shortName'],
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
  setIndustryChartData() async {
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
  setSectorChartData() async {
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
  }

  List<GeneralObject> regionsCDT = [];
  List rGeneralObject = [];
  setRegionalChartData() async {
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

  List<GeneralObject> exchangeCDT = [];
  setExchangeChartData() async {
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

  setAssetTypeChartData() async {
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
              colors: [UserThemes(widget.dataObject.theme).backgroundColour.withOpacity(.5)],
            ),
          ),
        ],
        // showingTooltipIndicators: showTooltips,
      ));
    }

    return assetTypeGCDT;
  }
}

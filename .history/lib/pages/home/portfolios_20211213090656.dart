import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:Strice/extensions/stringExt.dart';
import 'package:Strice/models/user/user.dart';
import 'package:Strice/services/Network/network.dart';
import 'package:Strice/services/database/database.dart';
import 'package:Strice/services/yahooapi/yahoo_api_provider.dart';
import 'package:Strice/shared/Custome_Widgets/dialogs/custome_Dialogs.dart';
import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/calls/updateCheck.dart';
import 'package:Strice/shared/decoration/customDecoration.dart';
import 'package:Strice/shared/files/fileHandling.dart';
import 'package:Strice/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/units/units.dart';
import 'package:Strice/shared/update/marketUpdate.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:Strice/shared/ads/ad_helper.dart';

class Portfolios extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Portfolios> with WidgetsBindingObserver {
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    _floatingBottomAd.dispose();
    timer.cancel();
  }

  @override
  void didChangeMetrics() => setRatio();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    setTimer();

    _floatingBottomAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(
            onAdLoaded: (_) => setState(() => isAdLoaded = true),
            onAdFailedToLoad: (_, error) => PrintFunctions().printStartEndLine(error)),
        request: AdRequest());

    _floatingBottomAd.load();

    setRatio();
    UpdateCheck().checkUpdate(context, themeMode);
    super.initState();
  }

  setRatio() => setState(() {
        ratio = (ui.window.physicalSize.height / ui.window.physicalSize.width);
      });

  Widget checkBannerAdStatus() {
    if (isAdLoaded) {
      return Container(
        width: _floatingBottomAd.size.width.toDouble(),
        height: _floatingBottomAd.size.height.toDouble(),
        // alignment: Alignment.center,
        child: AdWidget(
          ad: _floatingBottomAd,
        ),
      );
    } else {
      return Container(
        height: 0,
      ); //Container(padding: EdgeInsets.all(10), child: CircularProgressIndicator());
    }
  }

  Timer timer;
  setTimer() => timer = Timer.periodic(Duration(seconds: 5), (timer) => _quickUpdate());

  List<Map<dynamic, dynamic>> assets = [];
  List portfolios = [], filterAssets = [], searchViewList = [], news = [];

  Map initData = {}, rates, data = {}, _selectedPortfolio;

  String userName = '', userEmail = '', userNumber = '';
  String baseCurrency = '', baseC = '';

  var themeMode = true;

  bool updateChanges = true, isSaveData = false;
  bool isUpdateCheck = false, isIconsLoaded = false;
  bool isOnline = true, offlineAlert = false;
  bool isDelete = false, isChartError = false;
  bool isAdLoaded = false;

  BannerAd _floatingBottomAd;
  AppOpenAd _appOpenAd;

  int totalAssets = 0;

  double circularRadius = 15,
      ratio,
      width,
      height,
      iconSize = 23,
      overallValue = 0,
      overallReturn = 0,
      overallReturnPercent = 0,
      overallDailyReturn = 0,
      overallDailyReturnPercent = 0,
      overallInvestment = 0;

  UserData user;

  Function _confirmPanelFunction;

  resetViewWidget() {
    searchViewList.clear();
    portfolios.forEach((portfolio) => searchViewList.add(portfolio));

    searchViewList.add({'name': 'add'});
  }

  getNews() async {
    news = await YahooApiService().getNews(filterAssets);

    // PrintFunctions().printStartEndLine[(news.length);
  }

  loadData() {
    if (updateChanges == true) {
      setState(() {
        totalAssets = 0;

        // print('change occured');
        // print(data['states']['dark']);

        // PrintFunctions().printStartEndLine(data['states']);

        userName = data['userDetails']['userName'];
        userEmail = data['userDetails']['userEmail'];
        // userNumber = data['userDetails']['userNumber'];
        portfolios = data['portfolios'];

        // print(portfolios.length);

        // filterAssets = data['filteredAssets'];
        baseC = 'USD'; //data['userDetails']['baseCurrency'];
        baseCurrency = MarketUpdate(baseC).getCurrencySymbol()['symbol'];
        initData = data['initalData'];
        rates = data['rates'];

        for (var portfolio in portfolios) {
          for (var assetType in portfolio['assets']) {
            totalAssets += assetType['items'].length;
            for (var asset in assetType['items']) {
              if (filterAssets.isEmpty) {
                filterAssets.add(asset);
              } else {
                int isAssetExist = filterAssets.indexWhere((element) => element['symbol'] == asset['symbol']);

                if (isAssetExist == -1) {
                  filterAssets.add(asset);
                }
              }
            }
          }
        }

        overallInvestment = 0;
        overallReturn = 0;
        overallValue = 0;
        overallReturnPercent = 0;

        overallDailyReturn = 0;
        overallDailyReturnPercent = 0;

        for (var portfolio in portfolios) {
          if (updateChanges || !data['offlineData']) {
            MarketUpdate(baseC).updatePortfolio(portfolio, rates: rates, filterAssets: filterAssets);
            updateChanges = false;
          }
        }

        for (var portfolio in portfolios) {
          overallValue += portfolio['portfolioValue'];
          overallInvestment += portfolio['investedValue'];
          overallReturn += portfolio['change'];

          overallDailyReturn += portfolio['dailyChange'];
        }

        overallDailyReturnPercent = (overallDailyReturn / overallInvestment) * 100;
        overallReturnPercent = (overallReturn / overallInvestment) * 100;

        if (!data['offlineData'] || isSaveData || updateChanges) {
          LocalDataSet().writePortfolios(json.encode(data));
          isSaveData = false;
        }

        updateChanges = false;
        // setSort();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    user = (Provider.of<UserData>(context));

    data = ModalRoute.of(context).settings.arguments;

    themeMode = data['states']['theme'];

    void _showRemovePortfolioPanel(Map selectedPortfolio) {
      showModalBottomSheet(
          // barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            _selectedPortfolio = selectedPortfolio;
            return _editPanel();
          });
    }

    void _showConfirmPanel() {
      showModalBottomSheet(
          // barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return _confirmPanel();
          });
    }

    _confirmPanelFunction = _showConfirmPanel;

    loadData();

    return Container(
        color: UserThemes(themeMode).backgroundColour,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: UserThemes(themeMode).backgroundColour,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: OrientationBuilder(builder: (context, orientation) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, bottom: 15, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hi, $userName', style: CustomTextStyles(themeMode).sectionSubTextStyle),
                              Text('Portfolios', style: CustomTextStyles(themeMode).pageHeaderStyle)
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  timer.cancel();
                                  Navigator.pushNamed(context, '/search', arguments: {
                                    'data': data,
                                    'portfolios': data['portfolios'],
                                  }).then((value) => setTimer());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: ClipRRect(
                                    child: Image.asset(
                                      'assets/icons/search.png',
                                      width: 30,
                                      height: 30,
                                      color: UserThemes(themeMode).iconColour,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  timer.cancel();
                                  Navigator.pushNamed(context, "/settings", arguments: data)
                                      .then((value) => setState(() {
                                            updateChanges = true;
                                          }))
                                      .then((value) => setTimer());
                                },
                                child: ClipRRect(
                                  child: Image.asset(
                                    'assets/icons/settings.png',
                                    width: 30,
                                    height: 30,
                                    color: UserThemes(themeMode).iconColour,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Ink(
                      padding: EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 5),
                      decoration: CustomDecoration(themeMode, true).baseContainerDecoration,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(bottom: 15, top: 10, left: 5),
                              child: Text('Portfolios', style: CustomTextStyles(themeMode).sectionHeader)),
                          GridView.count(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            crossAxisCount: 1,
                            mainAxisSpacing: 5,
                            childAspectRatio:
                                (ratio <= 1.6) || orientation.index == 1 ? 6.8 : ((width / height) / .115),
                            children: portfolios.map((p) {
                              return InkWell(
                                onLongPress: () async {
                                  _showRemovePortfolioPanel(p);
                                },
                                onTap: () async {
                                  for (var asset in filterAssets) {
                                    if (asset['marketData']['chartData']['max'].isEmpty) {
                                      isChartError = true;
                                    }
                                  }

                                  if (isChartError == true) {
                                    await _quickUpdate();
                                  }

                                  timer.cancel();

                                  Navigator.pushNamed(
                                          context, '/portfolio', arguments: {'portfolio': p, 'data': data})
                                      .then((value) => setState(() {
                                            setTimer();
                                            updateChanges = true;
                                          }));
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Units().circularRadius),
                                ),
                                child: Ink(
                                  decoration: CustomDecoration(themeMode, false).baseContainerDecoration,
                                  padding: EdgeInsets.all(10), //(top: 15, left: 10, right: 10, bottom: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(p['name'].toString(),
                                                  style: CustomTextStyles(themeMode).portfolioNameStyle)),
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                                p['portfolioValue'] > 1000000000
                                                    ? '$baseCurrency${NumberFormat.compact().format(p['portfolioValue'])}'
                                                    : '$baseCurrency${p['portfolioValue'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}', //${p['baseCurrency']}
                                                style: CustomTextStyles(themeMode).holdingValueStyle),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                  p['investedValue'] > 1000000000
                                                      ? '$baseCurrency${NumberFormat.compact().format(p['investedValue'])}'
                                                      : '$baseCurrency${p['investedValue'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}', //${p['baseCurrency']}
                                                  style: CustomTextStyles(themeMode).holdingSubValueStyle),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                p['change'] > 1000000000
                                                    ? '+$baseCurrency${NumberFormat.compact().format(p['change'])}'
                                                    : (double.parse(p['change'].toString())) >= 0
                                                        ? '+$baseCurrency${p['change'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(double.parse(p['change'].toString()) / double.parse(p['investedValue'].toString()) * 100).toStringAsFixed(2)}%)'
                                                        : '-$baseCurrency${(p['change'] * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(double.parse((p['change'] * -1).toString()) / double.parse(p['investedValue'].toString()) * 100).toStringAsFixed(2)}%)',
                                                style: CustomTextStyles(themeMode)
                                                    .holdingSubValueStyle
                                                    .copyWith(
                                                        color: (double.parse(p['change'].toString()) >= 0
                                                            ? UserThemes(themeMode)
                                                                .greenVarient //Colors.green
                                                            : UserThemes(themeMode).redVarient)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Units().circularRadius),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('/newPortfolio', arguments: {'data': data, 'initalData': initData});
                        },
                        child: Container(
                          decoration: CustomDecoration(themeMode, true).baseContainerDecoration,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 15, bottom: 15, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'New Portfolio',
                                  style: CustomTextStyles(themeMode).sectionHeader,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: UserThemes(themeMode).iconColour,
                                  size: Units().headerIconSize,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ));
  }

  int _selectedIndex = 1;

  getConnection() async {
    return await Network('').getConnectionStatus();
  }

  _quickUpdate() async {
    int count = 0;

    isOnline = await getConnection();

    String lastUpdate = data['lastMarketCall'];
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    Duration timeSinceLastUpdate = DateTime.parse(lastUpdate).difference(DateTime.parse(currentDate));

    for (var asset in filterAssets) {
      if (asset['marketData']['chartData']['max'].isEmpty) {
        isChartError = true;
      }
    }

    // print(isChartError);

    if (isOnline) {
      offlineAlert = false;
      if (timeSinceLastUpdate.inDays >= 3 || isChartError == true) {
        isChartError = false;

        data['lastMarketCall'] = DateFormat('yyyy-MM-dd').format(DateTime.now());

        filterAssets.forEach((asset) async {
          asset['marketData']['chartData']['max'] = await YahooApiService()
              .getYahooChartData(exchange: asset['exchange'], symbol: asset['symbol'], timePeriod: '1d');

          count++;

          if (count == filterAssets.length) {
            setState(() {
              isSaveData = true;
              updateChanges = true;
            });
          }
        });
      } else {
        filterAssets.forEach((asset) async {
          asset['marketData']['quote'] =
              await YahooApiService().getYahooQuote(exchange: asset['exchange'], symbol: asset['symbol']);

          count++;

          if (count == filterAssets.length) {
            setState(() {
              isSaveData = true;
              updateChanges = true;
            });
          }
        });
      }
    } else {
      if (offlineAlert == true) {
      } else {
        CustomeDialogs(themeMode).noConnectionDialog(context);
        setState(() {
          offlineAlert = true;
        });
      }
    }
  }

  _confirmPanel() {
    if (!mounted) return;

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ink(
            decoration: BoxDecoration(
              color: UserThemes(themeMode).summaryColour,
              borderRadius: BorderRadius.circular(Units().circularRadius),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () async {
                data['portfolios'].remove(_selectedPortfolio);

                PrintFunctions().printStartEndLine(data['portfolios'].length);

                initData['portfolios']
                    .removeWhere((portfolio) => portfolio['name'] == _selectedPortfolio['name']);

                await DatabaseService(uid: user.uid)
                    .updateUserData(portfolios: initData['portfolios'], userDetails: data['userDetails']);

                LocalDataSet().writePortfolios(json.encode(data));

                isDelete = false;
                updateChanges = true;

                Navigator.pop(context);
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      'Confirm',
                      style: TextStyle(fontSize: 20, color: UserThemes(themeMode).greenVarient),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Ink(
            decoration: BoxDecoration(
              color: UserThemes(themeMode).summaryColour,
              borderRadius: BorderRadius.circular(Units().circularRadius),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 20, color: UserThemes(themeMode).textColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _editPanel() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ink(
            decoration: BoxDecoration(
              color: UserThemes(themeMode).summaryColour,
              borderRadius: BorderRadius.circular(Units().circularRadius),
            ),
            child: Column(
              children: [
                Ink(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: UserThemes(themeMode).seperator))),
                  child: InkWell(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Units().circularRadius),
                        topRight: Radius.circular(Units().circularRadius)),
                    onTap: () {
                      Navigator.pushNamed(context, '/editPortfolio',
                          arguments: {'data': data, 'portfolio': _selectedPortfolio});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Text(
                            'Edit',
                            style: TextStyle(fontSize: 20, color: UserThemes(themeMode).textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Ink(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: UserThemes(themeMode).seperator))),
                  child: InkWell(
                    onTap: () {
                      List _selectedPortfolioAssets = [];

                      for (var assetType in _selectedPortfolio['assets']) {
                        _selectedPortfolioAssets += assetType['items'];
                      }

                      Navigator.pushNamed(context, '/diver', arguments: {
                        'assets': _selectedPortfolioAssets,
                        // 'inception': inceptionDate,
                        data: data,
                        'invested': _selectedPortfolio['investedValue'],
                        'value': _selectedPortfolio['portfolioValue'],
                        'data': {'data': data},
                        'return': _selectedPortfolio['change']
                      });

                      // Navigator.pushNamed(context, '/editPortfolio',
                      //     arguments: {'data': data, 'portfolio': _selectedPortfolio});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Text(
                            'Diversification',
                            style: CustomTextStyles(themeMode).sectionHeader,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(Units().circularRadius),
                      bottomLeft: Radius.circular(Units().circularRadius)),
                  onTap: () {
                    Navigator.pop(context);
                    _confirmPanelFunction();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Text(
                          'Remove',
                          style: TextStyle(fontSize: 20, color: UserThemes(themeMode).redVarient),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Ink(
            decoration: BoxDecoration(
              color: UserThemes(themeMode).summaryColour,
              borderRadius: BorderRadius.circular(Units().circularRadius),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(Units().circularRadius),
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 20, color: UserThemes(themeMode).textColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalizeFirst() {
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }

  String capitalizeAll() {
    return '${this.toUpperCase()}';
  }
}

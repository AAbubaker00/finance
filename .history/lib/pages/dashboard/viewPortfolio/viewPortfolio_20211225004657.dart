import 'dart:convert';
import 'dart:ui';

import 'dart:async';

import 'package:Strice/extensions/stringExt.dart';
import 'package:Strice/models/user/user.dart';
import 'package:Strice/pages/report/diversification.dart';
import 'package:Strice/pages/viewPortfolio/editPortfolio.dart';
import 'package:Strice/pages/viewPortfolio/viewHolding.dart';
import 'package:Strice/services/database/database.dart';
import 'package:Strice/shared/GeneralObject/generalObject.dart';
import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/ads/ad_helper.dart';
import 'package:Strice/shared/calculations/Inception_Date/inception_Date.dart';
import 'package:Strice/shared/charts/charts.dart';
import 'package:Strice/shared/decoration/customDecoration.dart';
import 'package:Strice/shared/files/fileHandling.dart';
import 'package:Strice/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/units/units.dart';
import 'package:Strice/shared/update/marketUpdate.dart';
import 'package:Strice/shared/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewPortfolio extends StatefulWidget {
  final BuildContext context;

  ViewPortfolio(this.context);

  @override
  _ViewPortfolioState createState() => _ViewPortfolioState();
}

class _ViewPortfolioState extends State<ViewPortfolio> with TickerProviderStateMixin, WidgetsBindingObserver {
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _floatingBottomAd.dispose();
    super.dispose();
  }

  setRatio() {
    setState(() {
      ratio = (window.physicalSize.height / window.physicalSize.width);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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

    setRatio();
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

  @override
  didChangeMetrics() => setRatio();

  BannerAd _floatingBottomAd;
  bool isAdLoaded = false;

  UserData user;

  Function _confirmPanelFunction, _editHoldingFunction;

  List<String> sortOptions = ['Investment', 'Return', 'Buy Date', 'Shares', 'A-Z'];
  List holdingsPerformances = [], holdings = [], adsGenerated = [];

  Map userDeatils = {}, data = {}, rates, editholding;

  String portfolioName = '', currencySymbol = '';
  String selectedSortOption = 'Return', inceptionDate = '';
  String baseCurrency;

  var themeMode = true;

  int selectedIndex = 0;

  bool isMainLoaded = false, isSortLoaded = false;
  bool isFinalChange = false;

  double summarySpacing = 30, change = 0.0, changePercentage = 0;
  double investedValue = 0.0, portfolioValue = 0.0;
  double _height = 0.0, _width = 0.0, ratio;

  loadMain() async {
    if (isMainLoaded == false) {
      holdings.clear();

      portfolioValue = double.parse(data['portfolio']['portfolioValue'].toString());
      investedValue = double.parse(data['portfolio']['investedValue'].toString());
      rates = data['portfolio']['forex']['rates'];

      baseCurrency = 'USD';

      currencySymbol = MarketUpdate(baseCurrency).getCurrencySymbol()['symbol'];

      portfolioValue = data['portfolio']['portfolioValue'];
      portfolioName = data['portfolio']['name'];

      for (var holdingType in data['portfolio']['assets']) {
        holdings += holdingType['items'];
      }

      change = data['portfolio']['change'];
      changePercentage = ((change / investedValue) * 100);
      userDeatils = data['userDeatils'];

      inceptionDate = InceptionDate().getInceptionDae(holdings);

      if (this.mounted) {
        setState(() => isMainLoaded = true);
      }
    }
  }

  setSort() {
    if (!mounted) return;

    if (isSortLoaded == false) {
      if (holdings.length > 2) {
        if (selectedSortOption == 'Investment') {
          holdings.sort((a, b) {
            return a['Invested'].compareTo(b['Invested']);
          });

          holdings = holdings.reversed.toList();
        } else if (selectedSortOption == 'Return') {
          holdings.sort((a, b) {
            return a['change'].compareTo(b['change']);
          });
          holdings = holdings.reversed.toList();
        } else if (selectedSortOption == 'Buy Date') {
          holdings.sort((a, b) {
            return DateTime.parse(a['buyDate']).compareTo(DateTime.parse(b['buyDate']));
          });
          holdings = holdings.reversed.toList();
        } else if (selectedSortOption == 'Shares') {
          holdings.sort((a, b) {
            return a['shares'].compareTo(b['shares']);
          });
          holdings = holdings.reversed.toList();
        } else if (selectedSortOption == 'A-Z') {
          holdings.sort((a, b) {
            return a['symbol'][0].compareTo(b['symbol'][0]);
          });
          holdings = holdings.reversed.toList();
        }
      }

      if (this.mounted) {
        setState(() {
          isSortLoaded = true;
        });
      }
    }
  }

  Future<bool> initalizeAll() async {
    await loadMain();
    // await setSort();

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    void _showEditHoldingPanel(Map selectedholding) {
      showModalBottomSheet(
// barrierColor: Colors.transparent,
          context: widget.context,
          builder: (context) {
            editholding = selectedholding;
            return _editHoldingPanel();
          });
    }

    void _showConfirmPanel() {
      showModalBottomSheet(
// barrierColor: Colors.transparent,
          context: widget.context,
          builder: (context) {
            return _confirmPanel();
          });
    }

    _editHoldingFunction = _showEditHoldingPanel;
    _confirmPanelFunction = _showConfirmPanel;

    data = ModalRoute.of(context).settings.arguments;
    user = (Provider.of<UserData>(context));
    themeMode = (data['data']['states']['theme']);

    return FutureBuilder<bool>(
        future: initalizeAll(),
        builder: (context, snapshot) {
          // if (isMainLoaded || snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
              backgroundColor: UserThemes(themeMode).backgroundColour,
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                iconTheme: IconThemeData(color: UserThemes(themeMode).iconColour),
                elevation: 0,
                backgroundColor: UserThemes(themeMode).backgroundColour,
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                    // controller: _mainController,
                    children: [
                      // adsGenerated.isEmpty
                      //     ? Container()
                      //     : Padding(
                      //         padding: cEdgeInsets.only(bottom: 10.0),
                      //         child: CustomeAdWidget(isAdLoaded, adsGenerated[0]).checkBannerAdStatus(),
                      //       ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 10,
                          bottom: 15,
                          right: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Welcome back', style: CustomTextStyles(themeMode).sectionSubTextStyle),
                                Text(portfolioName, style: CustomTextStyles(themeMode).pageHeaderStyle)
                              ],
                            ),
                            InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditPortfolio(widget.),
                                        settings: RouteSettings(arguments: data))),
                                child: ClipRRect(
                                    child: Image.asset(
                                  'assets/icons/settings.png',
                                  width: 30,
                                  height: 30,
                                  color: UserThemes(themeMode).iconColour,
                                ))),
                          ],
                        ),
                      ),

                      getSummary(),
                      // SizedBox(
                      //   height: 30,
                      // ),

                      // getDividends(),

                      SizedBox(
                        height: 20,
                      ),
                      getHoldings(),
                      SizedBox(
                        height: 20,
                      ),

                      // adsGenerated.isEmpty
                      //     ? Container()
                      //     : Padding(
                      //         padding: EdgeInsets.only(top: 5.0),
                      //         child: CustomeAdWidget(isAdLoaded, adsGenerated[1]).checkBannerAdStatus(),
                      //       ),
                      // getNews(),
                      // SizedBox(
                      //   height: 30,
                      // ),

                      getChartSummary(),
                      SizedBox(
                        height: 30,
                      )
                    ]),
              ));
          // } else {
          //   return Loading(themeMode);
          // }
        });
  }

  getChartSummary() {
    List<GeneralObject> holdingCDT = [];

    for (var holding in holdings) {
      holdingCDT.add(new GeneralObject(
          name: holding['marketData']['quote']['displayName'] == null
              ? holding['marketData']['quote']['longName']
              : holding['marketData']['quote']['displayName'],
          symbol: holding['marketData']['quote']['symbol'],
          value: (double.parse(holding['shares'].toString())) * double.parse(holding['buyPrice'].toString()),
          turn: holding['change'],
          weight: (holding['Invested'] / investedValue) * 100));
    }

    return Container(
      // padding: EdgeInsets.all(10),
      decoration: CustomDecoration(themeMode, true).baseContainerDecoration,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Units().circularRadius),
          ),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Diversification(),
                  settings: RouteSettings(arguments: {
                    'holdings': holdings,
                    'inception': inceptionDate,
                    'invested': investedValue,
                    'value': portfolioValue,
                    'data': data,
                    'return': change
                  }))),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15.0, top: 15, right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Allocations',
                  style: CustomTextStyles(themeMode).sectionHeader,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: UserThemes(themeMode).iconColour,
                  size: Units().iconSize,
                )
              ],
            ),
          ),
        ),
        Container(
          // padding: EdgeInsets.all(10),
          decoration: CustomDecoration(themeMode, false).baseContainerDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 25, top: 25, left: 10, right: 10),
                child: Container(
                  width: _width,
                  height: _height * 0.03,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: holdings
                        .map((holding) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = holdings.indexOf(holding);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: selectedIndex == holdings.indexOf(holding)
                                          ? VarientColours()
                                              .customColours[holdings.indexOf(holding)]
                                              .withOpacity(.7)
                                          : Colors.transparent),
                                  child: Center(
                                    child: Text(
                                      holding['marketData']['quote']['longName'].toString().removeStr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.5,
                                          color: selectedIndex == holdings.indexOf(holding)
                                              ? UserThemes(themeMode).textColor
                                              : VarientColours()
                                                  .customColours[holdings.indexOf(holding)]
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
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                        child: SizedBox(
                      height: _height * 0.2,
                      width: _width * 0.43,
                      child: CustomCharts(themeMode).customePieChart(
                        holdingCDT,
                        _height,
                        _width,
                        selectedIndex: selectedIndex,
                        centerData: holdingCDT[selectedIndex].weight.toStringAsFixed(2),
                      ),
                    )),
                    Center(
                        child: SizedBox(
                      height: _height * 0.2,
                      width: _width * 0.43,
                      child: CustomCharts(themeMode).customePieChart(
                        holdingCDT,
                        _height,
                        _width,
                        selectedIndex: selectedIndex,
                        turn: true,
                        totalReturn: change,
                        centerData: ((holdingCDT[selectedIndex].turn * 100) / change).toStringAsFixed(2),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  getSummary() {
    return Container(
      decoration: CustomDecoration(themeMode, false).baseContainerDecoration,
      padding: EdgeInsets.only(top: 20, bottom: 15, right: 15, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
              // top: 10
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text('VALUE', style: CustomTextStyles(themeMode).tableHeaderStyle),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$currencySymbol',
                      style: CustomTextStyles(themeMode).overallCurrencyStyle,
                    ),
                    Text(
                      '${portfolioValue.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                      style: CustomTextStyles(themeMode).overallValueStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'INVESTED',
                      style: CustomTextStyles(themeMode).tableHeaderStyle,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      (investedValue > 1000000)
                          ? '$currencySymbol${NumberFormat.compact().format(investedValue).toString()}'
                          : '$currencySymbol${investedValue.toStringAsFixed(2).addCommas()}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 19, color: UserThemes(themeMode).textColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('EARNINGS', style: CustomTextStyles(themeMode).tableHeaderStyle)),
                  SizedBox(
                    height: 5,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                        (change >= 1000000 || change <= -1000000)
                            ? (change >= 0)
                                ? '+$currencySymbol${NumberFormat.compact().format(change)} (+${(changePercentage).toStringAsFixed(2)}%)'
                                : '-$currencySymbol${(NumberFormat.compact().format((change * -1)))} (${(changePercentage).toStringAsFixed(2)}%)'
                            : (change >= 0)
                                ? '+$currencySymbol${change.toStringAsFixed(2).addCommas()} (+${(changePercentage).toStringAsFixed(2)}%)'
                                : '-$currencySymbol${(change * -1).toStringAsFixed(2).addCommas()} (${(changePercentage).toStringAsFixed(2)}%)',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: (change > 0)
                                ? UserThemes(themeMode).greenVarient
                                : UserThemes(themeMode).redVarient)),
                  ),
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }

  List<GeneralObject> holdingsTD = [];

  getReport() {
    return InkWell(
      borderRadius: BorderRadius.circular(Units().circularRadius),
      onTap: () {
        var totalShares;

        Navigator.pushNamed(context, '/report', arguments: {
          'holdings': holdings,
          'inception': inceptionDate,
          'invested': investedValue,
          'value': portfolioValue,
          'shares': totalShares,
          'data': data
        });
      },
      child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: CustomDecoration(themeMode, false).baseContainerDecoration,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Performance', style: CustomTextStyles(themeMode).sectionHeader),
              SizedBox(width: 10),
              Icon(
                Icons.arrow_forward_rounded,
                color: UserThemes(themeMode).iconColour,
                size: Units().iconSize,
              )
            ],
          )),
    );
  }

  getHoldings() {
    return Ink(
      decoration: CustomDecoration(themeMode, true).baseContainerDecoration,
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 15.0, left: 5, top: 10),
            child: Text('Investments', style: CustomTextStyles(themeMode).sectionHeader),
          ),
          Ink(
            width: _width,
            child: GridView.count(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              crossAxisCount: 1,
              mainAxisSpacing: 5,
              childAspectRatio: (ratio <= 1.6) ? 8.5 : ((_width / _height) / .115),
              children: holdings.map((holding) {
                return InkWell(
                  onLongPress: () => _editHoldingFunction(holding),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewHolding(),
                          settings: RouteSettings(arguments: {
                            'holding': holding,
                            'themeMode': themeMode,
                            'portfolioName': portfolioName,
                            'data': data,
                            'rates': rates,
                            'baseCurrency': baseCurrency,
                            'currencySymbol': currencySymbol
                          }))), //viewHoldingFunction(stock),
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Units().circularRadius),
                  ),
                  child: Investment().getInvestment(
                    holding,
                    ratio,
                    currencySymbol,
                    baseCurrency,
                    themeMode,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  _editHoldingPanel() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ink(
            decoration: CustomDecoration(themeMode, false).baseContainerDecoration,
            child: Column(
              children: [
                Ink(
                  child: InkWell(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                    onTap: () {
                      Navigator.pop(context);
                      _confirmPanelFunction();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Remove',
                            style: TextStyle(fontSize: 20, color: UserThemes(themeMode).redVarient),
                          )
                        ],
                      ),
                    ),
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
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 20, color: UserThemes(themeMode).textColor),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sortPopupMenu() => PopupMenuButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: UserThemes(themeMode).backgroundColour,
        elevation: 8,
        offset: Offset(0, 50),
        onSelected: (value) {
          selectedSortOption = sortOptions[int.parse(value)];

          isSortLoaded = false;
          setSort();
        },
        icon: Icon(
          Icons.sort,
          color: UserThemes(themeMode).iconColour,
          size: Units().iconSize,
        ),
        itemBuilder: (context) => sortOptions.map<PopupMenuItem<String>>((String option) {
          return PopupMenuItem(
            value: sortOptions.indexOf(option).toString(),
            child: Text(
              option,
              style: TextStyle(
                  color: selectedSortOption == option
                      ? UserThemes(themeMode).textColor
                      : UserThemes(themeMode).textColorVarient,
                  fontWeight: selectedSortOption == option ? FontWeight.w600 : FontWeight.w400),
            ),
          );
        }).toList(),
      );

  _confirmPanel() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ink(
            decoration: CustomDecoration(themeMode, false).baseContainerDecoration,
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () async {
                isFinalChange = true;

                for (var portfolio in data['data']['initalData']['portfolios']) {
                  if (portfolio['name'] == portfolioName) {
                    var removeholding, holdingTypeIndex;

                    for (var holdingType in portfolio['holdings']) {
                      for (var holding in holdingType['items']) {
                        if (holding['symbol'] == editholding['symbol']) {
                          holdingTypeIndex = portfolio['holdings'].indexOf(holdingType);
                          removeholding = holding;
                        }
                      }
                    }

// print(portfolio['holdings']);
                    portfolio['holdings'][holdingTypeIndex]['items'].remove(removeholding);
                  }
                }

                for (var portfolio in data['data']['portfolios']) {
                  if (portfolio['name'] == portfolioName) {
                    var removeholding, holdingTypeIndex;

                    for (var holdingType in portfolio['holdings']) {
                      for (var holding in holdingType['items']) {
                        if (holding['symbol'] == editholding['symbol']) {
                          holdingTypeIndex = portfolio['holdings'].indexOf(holdingType);
                          removeholding = holding;
                        }
                      }
                    }

                    portfolio['holdings'][holdingTypeIndex]['items'].remove(removeholding);
                  }
                }

                isMainLoaded = false;

                if (mounted) {
                  setState(() {});
                }

                _dataChanged();

                Navigator.pop(context);
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
              borderRadius: BorderRadius.circular(5),
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

  _dataChanged() async {
    await DatabaseService(uid: user.uid).updateUserData(
        portfolios: data['data']['initalData']['portfolios'], userDetails: data['data']['userDetails']);

    LocalDataSet().writePortfolios(json.encode(data['data']));
  }
}

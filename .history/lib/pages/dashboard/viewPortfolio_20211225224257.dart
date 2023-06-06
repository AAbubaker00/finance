import 'dart:convert';
import 'dart:ui';

import 'package:Strice/extensions/stringExt.dart';
import 'package:Strice/models/user/user.dart';
import 'package:Strice/pages/report/diversification.dart';
import 'package:Strice/pages/viewPortfolio/viewHolding.dart';
import 'package:Strice/pages/viewPortfolio/editPortfolio.dart';
import 'package:Strice/services/database/database.dart';
import 'package:Strice/shared/GeneralObject/generalObject.dart';
import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/ads/ad_helper.dart';
import 'package:Strice/shared/calculations/Inception_Date/inception_Date.dart';
import 'package:Strice/shared/charts/charts.dart';
import 'package:Strice/shared/dataObject/data_object.dart';
import 'package:Strice/shared/decoration/customDecoration.dart';
import 'package:Strice/shared/files/fileHandling.dart';
import 'package:Strice/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/units/units.dart';
import 'package:Strice/shared/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewPortfolio extends StatefulWidget {
  final DataObject dataObject;

  ViewPortfolio({Key key, this.dataObject}) : super(key: key);

  @override
  _ViewPortfolioState createState() => _ViewPortfolioState();
}

class _ViewPortfolioState extends State<ViewPortfolio> with WidgetsBindingObserver {
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _floatingBottomAd.dispose();
    super.dispose();
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
  }

  // @override
  // bool get wantKeepAlive => true;

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

  UserData user;

  Function _confirmPanelFunction, _editHoldingFunction;

  List holdings = [], adsGenerated = [];

  Map editholding, data;

  String portfolioName = '', inceptionDate = '';

  int selectedIndex = 0;

  bool isMainLoaded = false;
  bool isFinalChange = false;
  bool isAdLoaded = false;

  double change = 0.0, changePercentage = 0;
  double investedValue = 0.0, portfolioValue = 0.0;

  loadMain() {
    if (isMainLoaded == false) {
      holdings.clear();

      portfolioValue = double.parse(data['portfolio']['portfolioValue'].toString());
      investedValue = double.parse(data['portfolio']['investedValue'].toString());

      portfolioName = data['portfolio']['name'];

      for (var holdingType in data['portfolio']['assets']) {
        holdings += holdingType['items'];
      }

      change = data['portfolio']['change'];
      changePercentage = ((change / investedValue) * 100);

      inceptionDate = InceptionDate().getInceptionDae(holdings);

      if (this.mounted) {
        setState(() => isMainLoaded = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    void _showEditHoldingPanel(Map selectedholding) {
      showModalBottomSheet(
// barrierColor: Colors.transparent,
          context: widget.dataObject.context,
          builder: (context) {
            editholding = selectedholding;
            return _editHoldingPanel();
          });
    }

    void _showConfirmPanel() {
      showModalBottomSheet(
// barrierColor: Colors.transparent,
          context: widget.dataObject.context,
          builder: (context) {
            return _confirmPanel();
          });
    }

    _editHoldingFunction = _showEditHoldingPanel;
    _confirmPanelFunction = _showConfirmPanel;

    data = ModalRoute.of(context).settings.arguments;
    user = (Provider.of<UserData>(context));

    loadMain();

    return Scaffold(
        backgroundColor: UserThemes(widget.dataObject.themeMode).backgroundColour,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: UserThemes(widget.dataObject.themeMode).iconColour),
          elevation: 0,
          backgroundColor: UserThemes(widget.dataObject.themeMode).backgroundColour,
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
                          Text('Welcome back',
                              style: CustomTextStyles(widget.dataObject.themeMode).sectionSubTextStyle),
                          Text(portfolioName,
                              style: CustomTextStyles(widget.dataObject.themeMode).pageHeaderStyle)
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
                                  builder: (context) => EditPortfolio(dataObject: widget.dataObject),
                                  settings: RouteSettings(arguments: data))),
                          child: ClipRRect(
                              child: Image.asset(
                            'assets/icons/settings.png',
                            width: 30,
                            height: 30,
                            color: UserThemes(widget.dataObject.themeMode).iconColour,
                          ))),
                    ],
                  ),
                ),

                getSummary(),
                SizedBox(
                  height: Units().mainSpacing,
                ),
                getHoldings(),
                SizedBox(
                  height: Units().mainSpacing,
                ),
                getChartSummary(),
                SizedBox(
                  height: Units().mainSpacing,
                )
              ]),
        ));
    // } else {
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
      decoration: CustomDecoration(widget.dataObject.themeMode, true).baseContainerDecoration,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Units().circularRadius),
          ),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Diversification(
                        dataObject: widget.dataObject,
                      ),
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
                  style: CustomTextStyles(widget.dataObject.themeMode).sectionHeader,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: UserThemes(widget.dataObject.themeMode).iconColour,
                  size: Units().iconSize,
                )
              ],
            ),
          ),
        ),
        Container(
          // padding: EdgeInsets.all(10),
          decoration: CustomDecoration(widget.dataObject.themeMode, false).baseContainerDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 25, top: 25, left: 10, right: 10),
                child: Container(
                  width: widget.dataObject.width,
                  height: widget.dataObject.height * 0.03,
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
                                              ? UserThemes(widget.dataObject.themeMode).textColor
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
                      height: widget.dataObject.height * 0.2,
                      width: widget.dataObject.width * 0.43,
                      child: CustomCharts(widget.dataObject.themeMode).customePieChart(
                        holdingCDT,
                        widget.dataObject.height,
                        widget.dataObject.width,
                        selectedIndex: selectedIndex,
                        centerData: holdingCDT[selectedIndex].weight.toStringAsFixed(2),
                      ),
                    )),
                    Center(
                        child: SizedBox(
                      height: widget.dataObject.height * 0.2,
                      width: widget.dataObject.width * 0.43,
                      child: CustomCharts(widget.dataObject.themeMode).customePieChart(
                        holdingCDT,
                        widget.dataObject.height,
                        widget.dataObject.width,
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
      decoration: CustomDecoration(widget.dataObject.themeMode, false).baseContainerDecoration,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.dataObject.userCurrencySymbol}',
                      style: CustomTextStyles(widget.dataObject.themeMode).overallCurrencyStyle,
                    ),
                    Text(
                      '${portfolioValue.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                      style: CustomTextStyles(widget.dataObject.themeMode).overallValueStyle,
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
                      style: CustomTextStyles(widget.dataObject.themeMode).tableHeaderStyle,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      (investedValue > 1000000)
                          ? '${widget.dataObject.userCurrencySymbol}${NumberFormat.compact().format(investedValue).toString()}'
                          : '${widget.dataObject.userCurrencySymbol}${investedValue.toStringAsFixed(2).addCommas()}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                          color: UserThemes(widget.dataObject.themeMode).textColor),
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
                      child: Text('EARNINGS',
                          style: CustomTextStyles(widget.dataObject.themeMode).tableHeaderStyle)),
                  SizedBox(
                    height: 5,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                        (change >= 1000000 || change <= -1000000)
                            ? (change >= 0)
                                ? '+${widget.dataObject.userCurrencySymbol}${NumberFormat.compact().format(change)} (+${(changePercentage).toStringAsFixed(2)}%)'
                                : '-${widget.dataObject.userCurrencySymbol}${(NumberFormat.compact().format((change * -1)))} (${(changePercentage).toStringAsFixed(2)}%)'
                            : (change >= 0)
                                ? '+${widget.dataObject.userCurrencySymbol}${change.toStringAsFixed(2).addCommas()} (+${(changePercentage).toStringAsFixed(2)}%)'
                                : '-${widget.dataObject.userCurrencySymbol}${(change * -1).toStringAsFixed(2).addCommas()} (${(changePercentage).toStringAsFixed(2)}%)',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: (change > 0)
                                ? UserThemes(widget.dataObject.themeMode).greenVarient
                                : UserThemes(widget.dataObject.themeMode).redVarient)),
                  ),
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }

  getHoldings() {
    return Ink(
      decoration: CustomDecoration(widget.dataObject.themeMode, true).baseContainerDecoration,
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 15.0, left: 5, top: 10),
            child: Text('Investments', style: CustomTextStyles(widget.dataObject.themeMode).sectionHeader),
          ),
          Ink(
            width: widget.dataObject.width,
            child: GridView.count(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              crossAxisCount: 1,
              mainAxisSpacing: 5,
              childAspectRatio: (widget.dataObject.ratio <= 1.6)
                  ? 8.5
                  : ((widget.dataObject.width / widget.dataObject.height) / .115),
              children: holdings.map((holding) {
                return InkWell(
                  onLongPress: () => _editHoldingFunction(holding),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewHolding(
                                dataObject: widget.dataObject,
                              ),
                          settings: RouteSettings(arguments: {
                            'holding': holding,
                            'portfolioName': portfolioName,
                            'portfolio': data['portfolio']
                          }))), //viewHoldingFunction(stock),
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Units().circularRadius),
                  ),
                  child: Investment().getInvestment(
                    holding,
                    widget.dataObject.ratio,
                    widget.dataObject.userCurrencySymbol,
                    widget.dataObject.userCurrency,
                    widget.dataObject.themeMode,
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
            decoration: CustomDecoration(widget.dataObject.themeMode, false).baseContainerDecoration,
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
                            style: TextStyle(
                                fontSize: 20, color: UserThemes(widget.dataObject.themeMode).redVarient),
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
              color: UserThemes(widget.dataObject.themeMode).summaryColour,
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
                          style: TextStyle(
                              fontSize: 20, color: UserThemes(widget.dataObject.themeMode).textColor),
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

  _confirmPanel() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ink(
            decoration: CustomDecoration(widget.dataObject.themeMode, false).baseContainerDecoration,
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
                      style: TextStyle(
                          fontSize: 20, color: UserThemes(widget.dataObject.themeMode).greenVarient),
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
              color: UserThemes(widget.dataObject.themeMode).summaryColour,
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
                      style:
                          TextStyle(fontSize: 20, color: UserThemes(widget.dataObject.themeMode).textColor),
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

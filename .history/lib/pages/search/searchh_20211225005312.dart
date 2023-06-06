import 'package:Strice/models/user/user.dart';
import 'package:Strice/services/database/database.dart';
import 'package:Strice/services/yahooapi/yahoo_api_provider.dart';
import 'package:Strice/shared/Custome_Widgets/loading/loading.dart';
import 'package:Strice/shared/ads/ad_helper.dart';
import 'package:Strice/shared/printFunctions/custom_Print_Functions.dart';
import 'package:flutter/material.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:ui';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  Map data;

  Search(this.data);
  @override
  _SearchState createState() => _SearchState(data);
}

class _SearchState extends State<Search> {
  _SearchState(this.data);

  List changes = [];
  // List data = [];
  List displayedData = [];
  List modifiedPortfolios = [];
  List newPortfolio = [];

  List dataAds = [];

  Map data = {};
  Map selectedStock = {};
  Map initData = {};
  Map userDetails;

  bool isDataChange = false;
  bool isPortfolioSelected = false;
  bool isAddNewPortfolio = false;
  var themeMode = true;
  bool isLoaded = false;

  double ratio;

    TextStyle tickerSubTextStyle;
  TextStyle tickerHeadTextStyle;

  TextStyle chgeHeaderStyle;
  TextStyle chgeSubStyle;

  @override
  void dispose() {
    if (!mounted) return;
    _floatingBottomAd.dispose();

    // print('disposed');
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    ratio = (window.physicalSize.height / window.physicalSize.width);

    _floatingBottomAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(
            onAdLoaded: (_) => setState(() => isAdLoaded = true),
            onAdFailedToLoad: (_, error) => PrintFunctions().printStartEndLine(error)),
        request: AdRequest());

    _floatingBottomAd.load();

    super.initState();
  }

  BannerAd _floatingBottomAd;
  bool isAdLoaded = false;
  setData() {
    themeMode = (data['data']['states']['theme']);

    if (!isLoaded) {
      userDetails = (data['data']['userDetails']);
      isLoaded = true;
    }
    setState(() {
      modifiedPortfolios = data['portfolios'];
      isDataChange = changes.isEmpty ? false : true;

      // modifiedPortfolios.forEach((element) {
      //   if (element == null) {
      //     print('yes');
      //   }
      // });

      if (data['change'] != null) {
        newPortfolio = data['change'];
        newPortfolio.isEmpty ? isAddNewPortfolio = false : isAddNewPortfolio = true;
      }

      // print(data['userDetails']);
      // data = data['data'];

      // for (var p in data.keys) {
      //   print(p);
      // }

      // if (!newPortfolio.isEmpty) {
      //   isAddNewPortfolio = true;
      // }

      // data.forEach((key, value) {
      //   print(key);
      // });
    });
  }

  UserData user;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    user = (Provider.of<UserData>(context));

    // print(data['data']['userDetails']);

    chgeHeaderStyle =
        TextStyle(color: UserThemes(themeMode).textColorVarient, fontSize: 20, fontWeight: FontWeight.w400);
    chgeSubStyle =
        TextStyle(color: UserThemes(themeMode).textColor, fontSize: 20, fontWeight: FontWeight.w400);

    setData();

    tickerHeadTextStyle = TextStyle(
      color: UserThemes(themeMode).textColor,
    );
    tickerSubTextStyle = TextStyle(
      color: UserThemes(themeMode).iconColour,
    );

    return Container(
      color: UserThemes(themeMode).backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: UserThemes(themeMode).backgroundColour,
          appBar: AppBar(
            elevation: 0,
            titleSpacing: 0,
            leadingWidth: 50,
            backgroundColor: UserThemes(themeMode).backgroundColour,
            leading: InkWell(
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                child: Icon(
                  Icons.arrow_back,
                  color: UserThemes(themeMode).iconColour,
                ),
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(
                right: 10,
              ),
              child: Ink(
                height: 37,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: UserThemes(themeMode).primary.withOpacity(.6),
                    border: Border.all(color: UserThemes(themeMode).border.withOpacity(.3)),
                    borderRadius: BorderRadius.circular(circularRadius)),
                child: TextField(
                  style: TextStyle(fontSize: 17, color: UserThemes(themeMode).textColor),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: TextStyle(color: UserThemes(themeMode).textColorVarient),
                    isDense: true,
                    labelStyle: TextStyle(color: UserThemes(themeMode).textColorVarient),
                    hintText: "Search...",
                    suffixIcon: Icon(
                      Icons.search,
                      size: 25,
                      color: UserThemes(themeMode).iconColour,
                    ),
                  ),
                  onChanged: (txt) async {
                    txt = txt.toLowerCase();

                    displayedData = await YahooApiService().getTickerSearchResultUpdated(search: txt);

                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          body: SnappingSheet(
            grabbingHeight: 90,
            initialSnappingPosition: SnappingPosition.factor(
              positionFactor: 0.04,
              snappingCurve: Curves.easeOutExpo,
              snappingDuration: Duration(seconds: 1),
              // grabbingContentOffset: GrabbingContentOffset.top,
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: displayedData.map((s) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedStock = selectedStock;
                        });

                        Navigator.pushNamed(context, '/getAsset', arguments: {
                          'data': data,
                          'symbol': s['symbol'],
                          'exch': s['exch'],
                          'changes': changes,
                          'portfolios': isAddNewPortfolio ? newPortfolio : data['portfolios'],
                          'newPort': isAddNewPortfolio
                        }).then((value) => setState(() {}));
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(color: UserThemes(themeMode).border),
                          )),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      "${s['name']}",
                                      style: tickerHeadTextStyle,
                                    ),
                                  ),
                                  IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed: () {},
                                      icon: Icon(Icons.add, color: UserThemes(themeMode).textColorVarient))
                                ],
                              ),
                              Text("${s['symbol']}, ${s['exch']}", style: tickerSubTextStyle),
                            ],
                          )),
                    );
                  }).toList(),
                ),
              ),
            ),
            grabbing: Container(
              decoration: BoxDecoration(
                  color: UserThemes(themeMode).insideColour,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  border: Border.all(color: UserThemes(themeMode).border)),
              child: InkWell(
                onTap: () {
                  if (snapSheetController.currentSnappingPosition == null) {
                    snapSheetController.snapToPosition(SnappingPosition.factor(
                        positionFactor: 0.5,
                        snappingCurve: Curves.ease,
                        snappingDuration: Duration(milliseconds: 500)));
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                              color: UserThemes(themeMode).backgroundColour,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Selected Instruments',
                                style: TextStyle(
                                    color: UserThemes(themeMode).textColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400)),
                            InkWell(
                              onTap: () async {
                                if (isAddNewPortfolio && isDataChange) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  newPortfolio[0].remove('isSelected');

                                  newPortfolio[0]['assets'] = [
                                    {'id': 'stocks', 'items': []}
                                  ];

                                  for (var change in changes) {
                                    newPortfolio[0]['assets'][0]['items'].add({
                                      'Invested': change['Invested'],
                                      'buyDate': change['date'],
                                      'shares': change['shares'],
                                      'avgPrice': change['buyPrice'],
                                      'buyPrice': change['buyPrice'],
                                      'symbol': change['item']['quote']['symbol'],
                                      'exchange': change['item']['quote']['exchange'],
                                      'history': [
                                        {
                                          'type': 'Market Buy',
                                          'averagePrice': change['buyPrice'],
                                          'fillPrice': change['buyPrice'],
                                          'filledOn': change['date'],
                                          'filledQuantity': change['shares'],
                                          'outstandingShares': change['shares']
                                        }
                                      ]
                                    });
                                  }

                                  newPortfolio[0]['baseCurrency'] = 'USD';
                                  //data['initalData']['userDetails']['baseCurrency'];

                                  List changesToS = [];

                                  for (var change in changes) {
                                    changesToS.add({
                                      'Invested': change['Invested'],
                                      'buyDate': change['date'],
                                      'shares': change['shares'],
                                      'avgPrice': change['buyPrice'],
                                      'buyPrice': change['buyPrice'],
                                      'symbol': change['item']['quote']['symbol'],
                                      'exchange': change['item']['quote']['exchange'],
                                      'history': [
                                        {
                                          'type': 'Market Buy',
                                          'averagePrice': change['buyPrice'],
                                          'fillPrice': change['buyPrice'],
                                          'filledOn': change['date'],
                                          'filledQuantity': change['shares'],
                                          'outstandingShares': change['shares']
                                        }
                                      ]
                                    });
                                  }

                                  data['initalData']['portfolios'].add({
                                    'name': newPortfolio[0]['name'],
                                    'baseCurrency':
                                        'USD', //data['initalData']['userDetails']['baseCurrency'],
                                    'assets': [
                                      {'id': 'stocks', 'items': changesToS}
                                    ]
                                  });

                                  await DatabaseService(uid: user.uid).updateUserData(
                                      portfolios: data['initalData']['portfolios'],
                                      userDetails: data['userDetails']);

                                  data['portfolios'].add(newPortfolio[0]);

                                  for (var change in changes) {
                                    for (var portfolio in data['portfolios']) {
                                      if (change['name'] == portfolio['name']) {
                                        for (var assetType in portfolio['assets']) {
                                          for (var asset in assetType['items']) {
                                            if (asset['symbol'] == change['item']['quote']['symbol']) {
                                              asset['marketData'] = change['item'];
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/home', (Route<dynamic> route) => false,
                                      arguments: {
                                        'initalData': data['initalData'],
                                        'portfolios': data['portfolios'],
                                        'userDetails': data['initalData']['userDetails'],
                                        'filteredStocks': data['filteredStocks'],
                                        'lastUpdate': data['lastUpdate'],
                                        'offlineData': false,
                                        'rates': data['rates'],
                                        'states': data['states']
                                        // 'states': data['data']['states']
                                      });
                                } else {
                                  for (var change in changes) {
                                    var edtInitPort = data['initalData']['portfolios']
                                        .firstWhere((portfolio) => portfolio['name'] == change['name']);
                                    var edtPort = data['portfolios']
                                        .firstWhere((portfolio) => portfolio['name'] == change['name']);

                                    if (edtPort['assets'] == null) {
                                      edtPort['assets'] = [
                                        {'id': 'stocks', 'items': []}
                                      ];

                                      edtInitPort['assets'] = [
                                        {'id': 'stocks', 'items': []}
                                      ];

                                      edtPort['assets'][0]['items'].add({
                                        'Invested': change['Invested'],
                                        'buyDate': change['date'],
                                        'shares': change['shares'],
                                        'buyPrice': change['buyPrice'],
                                        'avgPrice': change['buyPrice'],
                                        'symbol': change['item']['quote']['symbol'],
                                        'exchange': change['item']['quote']['exchange'],
                                        'history': [
                                          {
                                            'type': 'Market Buy',
                                            'filledOn': change['date'],
                                            'filledQuantity': change['shares'],
                                            'fillPrice': change['purchasePrice'],
                                            'averagePrice': change['Invested'],
                                            'outstandingShares': change['shares']
                                          }
                                        ],
                                        'marketData': change['item']
                                      });

                                      edtInitPort['assets'][0]['items'].add({
                                        'Invested': change['Invested'],
                                        'buyDate': change['date'],
                                        'shares': change['shares'],
                                        'avgPrice': change['buyPrice'],
                                        'buyPrice': change['buyPrice'],
                                        'symbol': change['item']['quote']['symbol'],
                                        'exchange': change['item']['quote']['exchange'],
                                        'history': [
                                          {
                                            'type': 'Market Buy',
                                            'filledOn': change['date'],
                                            'filledQuantity': change['shares'],
                                            'fillPrice': change['buyPrice'],
                                            'averagePrice': change['Invested'],
                                            'outstandingShares': change['shares']
                                          }
                                        ],
                                      });
                                    } else {
                                      var preAsset = edtPort['assets'][0]['items'].firstWhere(
                                          (asset) => asset['symbol'] == change['item']['quote']['symbol'],
                                          orElse: () => null);
                                      var preInitAsset = edtInitPort['assets'][0]['items'].firstWhere(
                                          (asset) => asset['symbol'] == change['item']['quote']['symbol'],
                                          orElse: () => null);

                                      if (preAsset == null) {
                                        edtPort['assets'][0]['items'].add({
                                          'Invested': change['Invested'],
                                          'buyDate': change['date'],
                                          'avgPrice': change['buyPrice'],
                                          'shares': change['shares'],
                                          'buyPrice': change['buyPrice'],
                                          'symbol': change['item']['quote']['symbol'],
                                          'exchange': change['item']['quote']['exchange'],
                                          'history': [
                                            {
                                              'type': 'Market Buy',
                                              'filledOn': change['date'],
                                              'filledQuantity': change['shares'],
                                              'fillPrice': change['buyPrice'],
                                              'averagePrice': change['Invested'],
                                              'outstandingShares': change['shares']
                                            }
                                          ],
                                          'marketData': change['item']
                                        });

                                        edtInitPort['assets'][0]['items'].add({
                                          'Invested': change['Invested'],
                                          'buyDate': change['date'],
                                          'shares': change['shares'],
                                          'avgPrice': change['buyPrice'],
                                          'buyPrice': change['buyPrice'],
                                          'symbol': change['item']['quote']['symbol'],
                                          'exchange': change['item']['quote']['exchange'],
                                          'history': [
                                            {
                                              'type': 'Market Buy',
                                              'filledOn': change['date'],
                                              'filledQuantity': change['shares'],
                                              'fillPrice': change['buyPrice'],
                                              'averagePrice': change['Invested'],
                                              'outstandingShares': change['shares']
                                            }
                                          ],
                                        });
                                      } else {
                                        double outstandingShares = 0.0, avgPrice = 0.0;
                                        double numerator = 0;

                                        preAsset['Invested'] = 0;
                                        preAsset['shares'] = 0;
                                        preAsset['history'].add({
                                          'type': 'Market Buy',
                                          'filledOn': change['date'],
                                          'filledQuantity': change['shares'],
                                          'fillPrice': change['buyPrice'],
                                          'averagePrice': 0,
                                          'outstandingShares': 0,
                                        });

                                        preInitAsset['Invested'] = 0;
                                        preInitAsset['shares'] = 0;
                                        preInitAsset['history'].add({
                                          'type': 'Market Buy',
                                          'filledOn': change['date'],
                                          'filledQuantity': change['shares'],
                                          'fillPrice': change['buyPrice'],
                                          'averagePrice': 0,
                                          'outstandingShares': 0,
                                        });

                                        // print(preAsset['history'].length);

                                        preAsset['history'].sort((a, b) => DateTime.parse(a['filledOn'])
                                            .compareTo(DateTime.parse(b['filledOn'])));

                                        for (var event in preAsset['history']) {
                                          // print(event['filledOn']);

                                          if (event['type'] == 'Market Sell') {
                                            preAsset['Invested'] -=
                                                event['filledQuantity'] * event['fillPrice'];

                                            outstandingShares -= event['filledQuantity'];
                                            event['outstandingShares'] = outstandingShares;
                                          } else {
                                            preAsset['Invested'] +=
                                                event['filledQuantity'] * event['fillPrice'];

                                            outstandingShares += event['filledQuantity'];

                                            numerator += event['filledQuantity'] * event['fillPrice'];
                                            avgPrice = numerator / outstandingShares;

                                            event['outstandingShares'] = outstandingShares;
                                            event['averagePrice'] = avgPrice;
                                          }
                                        }

                                        preAsset['avgPrice'] = avgPrice;
                                        preInitAsset['avgPrice'] = avgPrice;
                                        preAsset['shares'] = outstandingShares;
                                        preInitAsset['shares'] = outstandingShares;
                                        preInitAsset['Invested'] = preAsset['Invested'];
                                        preInitAsset['history'] = preAsset['history'];
                                      }
                                    }
                                  }

                                  await DatabaseService(uid: user.uid).updateUserData(
                                      portfolios: data['initalData']['portfolios'],
                                      userDetails: data['userDetails']);

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/home', (Route<dynamic> route) => false,
                                      arguments: {
                                        'initalData': data['initalData'],
                                        'portfolios': data['portfolios'],
                                        'userDetails': data['initalData']['userDetails'],
                                        'filteredStocks': data['filteredStocks'],
                                        'lastUpdate': data['lastUpdate'],
                                        'offlineData': false,
                                        'rates': data['rates'],
                                        'states': data['states']
                                        // 'states': data['data']['states']
                                      });
                                }
                              },
                              child: Icon(
                                Icons.check_circle_outline,
                                color: isDataChange
                                    ? UserThemes(themeMode).greenVarient
                                    : UserThemes(themeMode).greenVarient.withOpacity(.3),
                                size: 50,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            sheetBelow: SnappingSheetContent(
                child: Container(
              // height: MediaQuery.of(context).size.height * 0.3,
              color: UserThemes(themeMode).insideColour,
              child: changes.isEmpty
                  ? Container(
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/icons/empty.png',
                          color: UserThemes(themeMode).iconColour.withOpacity(.2),
                          fit: BoxFit.scaleDown,
                          scale: 10,
                        ),
                      ),
                    )
                  : GridView.count(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: (ratio <= 1.6) ? 2 : 1,
                      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                      crossAxisSpacing: 5,
                      childAspectRatio: (ratio <= 1.6) ? 1.7 : 9,
                      children: changes.map((change) {
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: UserThemes(themeMode).iconColour.withOpacity(.2)))),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      change['item']['quote']['symbol'],
                                      style: chgeSubStyle.copyWith(fontSize: 20),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Icon(
                                      Icons.arrow_right_rounded,
                                      color: UserThemes(themeMode).iconColour.withOpacity(.3),
                                    ),
                                    Text(
                                      change['name'],
                                      style: chgeHeaderStyle,
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () => setState(() => changes.remove(change)),
                                  child: Icon(
                                    Icons.delete,
                                    color: UserThemes(themeMode).redVarient,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            )),
            controller: snapSheetController,
            snappingPositions: [
              SnappingPosition.factor(
                positionFactor: 0.04,
                snappingCurve: Curves.easeOutExpo,
                snappingDuration: Duration(seconds: 1),
                // grabbingContentOffset: GrabbingContentOffset.top,
              ),
              SnappingPosition.pixels(
                positionPixels: 400,
                snappingCurve: Curves.elasticOut,
                snappingDuration: Duration(milliseconds: 1750),
              ),
              // SnappingPosition.factor(
              //   positionFactor: 1.0,
              //   snappingCurve: Curves.bounceOut,
              //   snappingDuration: Duration(seconds: 1),
              //   grabbingContentOffset: GrabbingContentOffset.bottom,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

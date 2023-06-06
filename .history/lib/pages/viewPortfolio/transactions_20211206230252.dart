import 'package:Strice/extensions/stringExt.dart';
import 'package:Strice/models/user/user.dart';
import 'package:Strice/services/database/database.dart';
import 'package:Strice/shared/update/marketUpdate.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:Strice/shared/themes/themes.dart';
import 'package:provider/provider.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> with SingleTickerProviderStateMixin {
  double outstandingShares = 0.0, avgPrice = 0.0, totalReturn;
  double denominator = 0, numerator = 0, oravgP = 0, invested = 0, ratio;
  double quantity, fillPrice;

  String hintText_0 = '0', hintText_1 = '0';
  String assetCurrencySymbol = '', assetCurrency = '';
  String baseCurrency = '', currencySymbol = '';

  // bool isDatachanged = false;
  var themeMode;// = true;
  bool isMainLoaded = false;

  List portfolios, changes = [];
  List months, history = [], oriEvent;

  TextStyle headStyle, subStyle;

  Map initalData = {}, userDetails = {}, ePortfolio = {};
  Map rates = {}, data = {}, newEvent;

  UserData user;

  Function _confirmPanelFunction;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ratio = (window.physicalSize.height / window.physicalSize.width);
  }

  loadData() {
    _monthDataRest();

    setState(() {
      if (!isMainLoaded) {
        themeMode = data['themeMode'];
        rates = data['rates'];
        currencySymbol = data['currencySymbol'];
        baseCurrency = data['baseCurrency'];
        assetCurrencySymbol =
            MarketUpdate(data['holding']['marketData']['quote']['currency'].toString().capitalizeAll())
                .getCurrencySymbol()['symbol'];
        assetCurrency = data['holding']['marketData']['quote']['currency'].toString().capitalizeAll();

        initalData = data['data']['data']['initalData'];
        portfolios = data['data']['data']['portfolios'];
        ePortfolio = data['data']['portfolio'];

        outstandingShares = 0.0;
        numerator = 0.0;

        history = data['holding']['history'];
        oriEvent = data['holding']['history'];

        isMainLoaded = true;
      }

      invested = 0;
      outstandingShares = 0;
      numerator = 0;

      if (changes.isNotEmpty) {
        changes.forEach((change) => history.add(change));
      }

      history.sort((a, b) => a['filledOn'].compareTo(b['filledOn']));

      for (var event in history) {
        if (event['type'] == 'Market Sell') {
          outstandingShares -= event['filledQuantity'];
          event['outstandingShares'] = outstandingShares;
          event['averagePrice'] = oravgP;

          invested -= (event['filledQuantity'] * event['fillPrice']);
        } else {
          outstandingShares += event['filledQuantity'];

          numerator += event['filledQuantity'] * event['fillPrice'];
          oravgP = numerator / outstandingShares;

          event['outstandingShares'] = outstandingShares;
          event['averagePrice'] = oravgP;

          invested += (event['filledQuantity'] * event['fillPrice']);
        }
      }

      avgPrice = oravgP * MarketUpdate(baseCurrency).getRate(rates, assetCurrency);

      history = history.reversed.toList();
    });

    changes.clear();
  }

  _monthDataRest() {
    months = [
      {'id': "January", 'stocks': [], 'isSelected': false, 'status': false, 'index': 1},
      {'id': "February", 'stocks': [], 'isSelected': false, 'status': false, 'index': 2},
      {'id': "March", 'stocks': [], 'isSelected': false, 'status': false, 'index': 3},
      {'id': "April", 'stocks': [], 'isSelected': false, 'status': false, 'index': 4},
      {'id': "May", 'stocks': [], 'isSelected': false, 'status': false, 'index': 5},
      {'id': "June", 'stocks': [], 'isSelected': false, 'status': false, 'index': 6},
      {'id': "July", 'stocks': [], 'isSelected': false, 'status': false, 'index': 7},
      {'id': "August", 'stocks': [], 'isSelected': false, 'status': false, 'index': 8},
      {'id': "September", 'stocks': [], 'isSelected': false, 'status': false, 'index': 9},
      {'id': "October", 'stocks': [], 'isSelected': false, 'status': false, 'index': 10},
      {'id': "November", 'stocks': [], 'isSelected': false, 'status': false, 'index': 11},
      {'id': "December", 'stocks': [], 'isSelected': false, 'status': false, 'index': 12}
    ];
  }

  @override
  Widget build(BuildContext context) {
    // _height = MediaQuery.of(context).size.height;
    // _width = MediaQuery.of(context).size.width;

    void _showEditEventPanel(Map event) {
      showModalBottomSheet(
          // barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return _editEventPanel(event);
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

    data = ModalRoute.of(context).settings.arguments;
    user = (Provider.of<UserData>(context));

    themeMode = (data['data']['data']['states']['theme']);

    headStyle = TextStyle(
      color: UserThemes(themeMode).textColorVarient,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    );
    subStyle = TextStyle(color: UserThemes(themeMode).textColor, fontWeight: FontWeight.w400, fontSize: 22);

    loadData();

    return Container(
      color: UserThemes(themeMode).backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: UserThemes(themeMode).backgroundColour,
          appBar: AppBar(
              iconTheme: IconThemeData(
                color: UserThemes(themeMode).backColour, //changes your color here
              ),
              elevation: 0,
              backgroundColor: UserThemes(themeMode).backgroundColour,
              centerTitle: true,
              title: Text(
                'Orders',
                style:
                    TextStyle(color: UserThemes(themeMode).textColor, fontSize: 20, fontWeight: FontWeight.w400),
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.add,
                      color: UserThemes(themeMode).iconColour,
                      // size: 15,
                    ),
                    onPressed: () async {
                      var result = await Navigator.pushNamed(context, '/marketOrder', arguments: {
                        'changes': changes,
                        'outstandingShares': outstandingShares,
                        'themeMode': themeMode
                      });

                      if (result != null) {
                        _confirmPanelFunction();

                        setState(() {});
                      }
                    })
              ]),
          body: ListView(
            shrinkWrap: true,
            // physics: BouncingScrollPhysics(),
            // crossAxisCount: 1,
            // childAspectRatio: (ratio <= 1.6) ? 3 : 3.75,
            children: history.map((event) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 10),
                        Text(event['type'] == 'Market Buy' ? 'Market Buy' : 'Market Sell', style: headStyle),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Icon(
                            Icons.arrow_right_rounded,
                            color: UserThemes(themeMode).textColorVarient,
                          ),
                        ),
                        Text(
                            '${DateTime.parse(event['filledOn']).day.toString()} ${months[DateTime.parse(event['filledOn']).month - 1]['id']} ${DateTime.parse(event['filledOn']).year.toString()}',
                            style: headStyle),
                      ],
                    ),
                  ),
                  InkWell(
                    onLongPress: () {
                      _showEditEventPanel(event);
                    },
                    child: Ink(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: UserThemes(themeMode).summaryColour,
                          border: Border.symmetric(
                              horizontal: BorderSide(color: UserThemes(themeMode).border, width: 1))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${data['holding']['marketData']['quote']['longName']}', style: headStyle),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    '$assetCurrencySymbol${event['fillPrice'].toStringAsFixed(2)}',
                                    style: subStyle,
                                  ),
                                  Text(
                                    ' @ ',
                                    style: subStyle.copyWith(color: UserThemes(themeMode).textColorVarient),
                                  ),
                                  Text(
                                    '${event['filledQuantity']}',
                                    style: subStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text(
                                '$currencySymbol${(event['filledQuantity'] * event['fillPrice'] * MarketUpdate(baseCurrency).getRate(rates, assetCurrency)).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                style: TextStyle(
                                    color: UserThemes(themeMode).textColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w300),
                              ),
                              // Icon(
                              //   Icons.arrow_right,
                              //   color: UserThemes(themeMode).iconColour,
                              //   size: 20,
                              // ),
                            ],
                          ),

                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          // Text(
                          //     event['type'] == 'Market Buy'
                          //         ? '${data['holding']['symbol']} Buy Price'
                          //         : '${data['holding']['symbol']} Sell Price',
                          //     style: headStyle),
                          // Text(
                          //   '$assetCurrencySymbol${event['fillPrice'].toStringAsFixed(2)}',
                          //   style: subStyle.copyWith(
                          //       color: UserThemes(themeMode)
                          //           .textColor
                          //           .withOpacity(event['type'] == 'Market Buy' ? 1 : .5)),
                          // ),
                          //       ],
                          //     ),
                          //     SizedBox(height: 15),
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Text('Final Cost (+ Fees/rates)', style: headStyle),
                          // Text(
                          //   '$currencySymbol${(event['filledQuantity'] * event['fillPrice'] * MarketUpdate(baseCurrency).getRate(rates, assetCurrency)).toStringAsFixed(2)}',
                          //   style: subStyle.copyWith(
                          //       color: UserThemes(themeMode)
                          //           .textColor
                          //           .withOpacity(event['type'] == 'Market Buy' ? 1 : .5)),
                          // ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          // Column(
                          //   children: [
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         Text('Shares Aquired', style: headStyle),
                          //         Text(
                          //           event['filledQuantity'].toStringAsFixed(2),
                          //           style: subStyle.copyWith(
                          //               color: UserThemes(themeMode)
                          //                   .textColor
                          //                   .withOpacity(event['type'] == 'Market Buy' ? 1 : .5)),
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(height: 15),
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         Text('Trading Pair', style: headStyle),
                          //         Text(
                          //           '$baseCurrency/$assetCurrency',
                          //           style: subStyle.copyWith(
                          //               color: UserThemes(themeMode)
                          //                   .textColor
                          //                   .withOpacity(event['type'] == 'Market Buy' ? 1 : .5)),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.end,
                          //       children: [
                          //         Text('Total Cost', style: headStyle),
                          //         Text(
                          //           '$assetCurrencySymbol${(event['filledQuantity'] * event['fillPrice']).toStringAsFixed(2)}',
                          //           style: subStyle.copyWith(
                          //               color: UserThemes(themeMode)
                          //                   .textColor
                          //                   .withOpacity(event['type'] == 'Market Buy' ? 1 : .5)),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  _editEventPanel(Map event) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: UserThemes(themeMode).summaryColour,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    var result = await Navigator.pushNamed(context, '/marketOrder', arguments: {
                      'changes': changes,
                      'outstandingShares': outstandingShares,
                      'event': event,
                      'themeMode': themeMode
                    });

                    if (result != null) {
                      history.remove(event);
                      Navigator.of(context).pop();

                      _confirmPanelFunction();

                      setState(() {});
                    } else {
                      print('///////////////////////////////////');
                      print(result);
                      print('///////////////////////////////////');
                    }
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text('Edit',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: UserThemes(themeMode).textColor)),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: UserThemes(themeMode).border,
                ),
                InkWell(
                  onTap: () async {
                    if (history.length > 1) {
                      setState(() => history.remove(event));
                      Navigator.of(context).pop();
                      _confirmPanelFunction();
                    }
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
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
          Container(
            decoration: BoxDecoration(
              color: UserThemes(themeMode).summaryColour,
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
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

  _confirmPanel() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ink(
            decoration: BoxDecoration(
              color: UserThemes(themeMode).summaryColour,
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () async {
                for (var portfolio in data['data']['data']['initalData']['portfolios']) {
                  if (portfolio['name'] == data['pName']) {
                    for (var assetType in portfolio['assets']) {
                      for (var stock in assetType['items']) {
                        if (stock['symbol'] == data['holding']['symbol']) {
                          stock['history'] = history;
                          stock['avgPrice'] = oravgP;
                          stock['shares'] = outstandingShares;
                          stock['Invested'] = invested;
                        }
                      }
                    }
                  }
                }
                for (var assetType in data['data']['portfolio']['assets'])
                  for (var stock in assetType['items']) {
                    if (stock['symbol'] == data['holding']['symbol']) {
                      stock['Invested'] = invested;
                      stock['history'] = history;
                      stock['avgPrice'] = oravgP;
                      stock['shares'] = outstandingShares;
                    }
                  }

                changes.clear();

                await DatabaseService(uid: user.uid).updateUserData(
                    portfolios: data['data']['data']['initalData']['portfolios'],
                    userDetails: data['data']['data']['userDetails']);

                setState(() {});
                // Initialize(
                //     upDisplayData: portfolios,
                //     upInitalData: initalData,
                //     context: context,
                //     isDatachanged: true);

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
                setState(() {
                  history = oriEvent;
                });
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

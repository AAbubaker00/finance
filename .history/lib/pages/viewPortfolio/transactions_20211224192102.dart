import 'package:Strice/extensions/stringExt.dart';
import 'package:Strice/models/user/user.dart';
import 'package:Strice/services/database/database.dart';
import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/dataObject/data_object.dart';
import 'package:Strice/shared/decoration/customDecoration.dart';
import 'package:Strice/shared/units/units.dart';
import 'package:Strice/shared/update/marketUpdate.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:Strice/shared/themes/themes.dart';
import 'package:provider/provider.dart';

class Transactions extends StatefulWidget {
  final DataObject dataObject;

  const Transactions({Key key, @required this.dataObject}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> with SingleTickerProviderStateMixin {
  double outstandingShares = 0.0, avgPrice = 0.0, totalReturn;
  double denominator = 0, numerator = 0, oravgP = 0, invested = 0;
  double quantity, fillPrice;

  String hintText_0 = '0', hintText_1 = '0';
  String assetCurrencySymbol = '', assetCurrency = '';

  // bool isDatachanged = false;
  bool isMainLoaded = false;

  List changes = [];
  List months, history = [], oriEvent;

  TextStyle headStyle, subStyle;

  Map ePortfolio = {};
  Map data = {}, newEvent, holding;

  UserData user;

  Function _confirmPanelFunction;

  loadData() {
    _monthDataRest();

    setState(() {
      if (!isMainLoaded) {
        assetCurrency = data['holding']['marketData']['quote']['currency'].toString().capitalizeAll();

        ePortfolio = data['portfolio'];

        outstandingShares = 0.0;
        numerator = 0.0;

        history = data['holding']['history'];

        holding = data['holding'];

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

      avgPrice = oravgP *
          MarketUpdate(widget.dataObject.userCurrency).getRate(widget.dataObject.rates, assetCurrency);

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
    loadData();

    headStyle = TextStyle(
      color: UserThemes(widget.dataObject.themeMode).textColorVarient,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    );
    subStyle = TextStyle(
        color: UserThemes(widget.dataObject.themeMode).textColor, fontWeight: FontWeight.w400, fontSize: 22);

    return Container(
      color: UserThemes(widget.dataObject.themeMode).backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: UserThemes(widget.dataObject.themeMode).backgroundColour,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: UserThemes(widget.dataObject.themeMode).backColour, //changes your color here
            ),
            elevation: 0,
            backgroundColor: UserThemes(widget.dataObject.themeMode).backgroundColour,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
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
                          Text(
                            '${holding['marketData']['quote']['longName'].toString().removeStr()}',
                            style: CustomTextStyles(widget.dataObject.themeMode).portfolioNameStyle.copyWith(
                                color: UserThemes(widget.dataObject.themeMode).textColorVarient,
                                fontSize: 17),
                          ),
                          Text(
                            'Transactions',
                            style: CustomTextStyles(widget.dataObject.themeMode)
                                .sectionHeader
                                .copyWith(fontWeight: FontWeight.w500, fontSize: 40),
                          )
                        ],
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.add,
                            size: Units().headerIconSize,
                            color: UserThemes(widget.dataObject.themeMode).iconColour,
                            // size: 15,
                          ),
                          onPressed: () async {
                            var result = await Navigator.pushNamed(context, '/marketOrder', arguments: {
                              'changes': changes,
                              'outstandingShares': outstandingShares,
                              'widget.dataObject.themeMode': widget.dataObject.themeMode
                            });

                            if (result != null) {
                              _confirmPanelFunction();

                              setState(() {});
                            }
                          })
                    ],
                  ),
                ),
                Column(
                  children: history.map((event) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 5),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Text(event['type'] == 'Market Buy' ? 'Market Buy' : 'Market Sell',
                                  style: CustomTextStyles(widget.dataObject.themeMode).holdingSubValueStyle),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Icon(
                                  Icons.arrow_right_rounded,
                                  color: UserThemes(widget.dataObject.themeMode).textColorVarient,
                                ),
                              ),
                              Text(
                                  '${DateTime.parse(event['filledOn']).day.toString()} ${months[DateTime.parse(event['filledOn']).month - 1]['id']} ${DateTime.parse(event['filledOn']).year.toString()}',
                                  style: headStyle),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {

                            Navigator.push(context, MaterialPageRoute(builder: ))

                            var result = await Navigator.pushNamed(context, '/marketOrder', arguments: {
                              'changes': changes,
                              'outstandingShares': outstandingShares,
                              'event': event,
                              'widget.dataObject.themeMode': widget.dataObject.themeMode
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
                          }, //_showEditEventPanel(event),
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Units().circularRadius),
                          ),
                          child: Ink(
                            padding: EdgeInsets.all(20),
                            decoration:
                                CustomDecoration(widget.dataObject.themeMode, false).baseContainerDecoration,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    '${data['holding']['marketData']['quote']['longName'].toString().removeStr()}',
                                    style: CustomTextStyles(widget.dataObject.themeMode).sectionHeader),
                                Text(
                                  '${widget.dataObject.userCurrencySymbol}${(event['filledQuantity'] * event['fillPrice'] * MarketUpdate(widget.dataObject.userCurrency).getRate(widget.dataObject.rates, assetCurrency)).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                  style: CustomTextStyles(widget.dataObject.themeMode).sectionHeader,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _editEventPanel(Map event) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: UserThemes(widget.dataObject.themeMode).summaryColour,
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
                      'widget.dataObject.themeMode': widget.dataObject.themeMode
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
                                color: UserThemes(widget.dataObject.themeMode).textColor)),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: UserThemes(widget.dataObject.themeMode).border,
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
          Container(
            decoration: BoxDecoration(
              color: UserThemes(widget.dataObject.themeMode).summaryColour,
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
            decoration: BoxDecoration(
              color: UserThemes(widget.dataObject.themeMode).summaryColour,
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
}

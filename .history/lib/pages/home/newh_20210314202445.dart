import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/models/user/user.dart';
import 'package:finance/pages/Initilize.dart';
import 'package:finance/services/forex/forexConversion.dart';
import 'package:finance/services/yahooapi/yahoo_api_provider.dart';
import 'package:finance/shared/fileHandling.dart';
import 'package:finance/shared/loading.dart';
import 'package:finance/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:finance/extensions/stringExt.dart';
import 'package:finance/models/user/user.dart';
import 'package:finance/pages/Initilize.dart';
import 'package:finance/services/database/database.dart';
import 'package:finance/shared/fileHandling.dart';
import 'package:finance/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:finance/shared/themes.dart';
import 'package:provider/provider.dart';

class Homes extends StatefulWidget {
  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  Map prStates = {
    'states': {'dark': true, 'private': false}
  };
  Map initData = {}, rates;
  Map<String, dynamic> masterAccount = {};
  Map data = {};

  List<Map<dynamic, dynamic>> stocks = [];
  List portfolios = [];

  double portfolioCount = 0;
  double stockCount = 0;
  double sharesCount = 0;
  double investedValue = 0;
  double portfolioValue = 0;
  double settingSpacing = 17;
  double ratio;

  String userName;
  String userEmail;
  String userNumber;
  String baseCurrency = '';
  String currencySymbol = '';
  String baseC = '';
  String name;
  String description;

  bool isDarkMode = false;
  bool updateChanges = false;
  bool isSaveData = false;
  bool isPrivate = false;
  bool updating = false;
  bool isDark = true;
  bool isLoaded = false;

  UserData user;

  TextStyle assetHeaderStyle;
  TextStyle setOptionStyle;

  @override
  void initState() {
    super.initState();

    ratio = (window.physicalSize.height / window.physicalSize.width);
  }

  QuerySnapshot querySnapshot;

  loadData() async {
    var states = await OfflineDataset().readStates();
    var ofData = await OfflineDataset().readPortfolios();

    if (states == '') {
      OfflineDataset().writeStates(json.encode(prStates));
    } else {
      var statesJson = json.decode(states);
      prStates = statesJson;
    }

    if (ofData != '') {
      // if (querySnapshot == null) {
      //   return MainLoading();
      // } else {
      var t = await Initialize().getInitalData(querySnapshot: querySnapshot).fData;

      print(t);

      // }
    } else {
      var odJson = json.decode(ofData);

      setState(() {
        isDark = true; //(odJson['states']['dark']);
        portfolios = odJson['portfolios'];
        userName = odJson['userDetails']['userName'];
        userEmail = odJson['userDetails']['userEmail'];
        userNumber = odJson['userDetails']['userNumber'];
        baseC = odJson['userDetails']['baseCurrency'];
        initData = odJson['initalData'];
        rates = odJson['rates'];

        for (var portfolio in portfolios) {
          baseCurrency = Update(baseC).getCurrencySymbol()['symbol'];

          if (updateChanges) {
            Update(baseC).updatePortfolio(portfolio, rates: rates);
            updateChanges = false;
          }

          portfolio['investedValue'] = 0.0;
          portfolio['portfolioValue'] = 0.0;
          portfolio['change'] = 0.0;

          for (var stock in portfolio['stocks']) {
            // print('${stock['symbol']} : ${stock['value']}');
            portfolio['investedValue'] += stock['Invested'];
            portfolio['portfolioValue'] += stock['value'];
            portfolio['change'] += double.parse(stock['change'].toString());
          }
        }
      });

      isLoaded = true;
    }

    assetHeaderStyle = TextStyle(color: DarkTheme(isDark).textColorVarient, fontWeight: FontWeight.w600);
    setOptionStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: DarkTheme(isDark).textColor,
    );

    if (updateChanges) {
      OfflineDataset().writePortfolios(json.encode(data));
      isSaveData = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    void _showRemovePortfolioPanel(Map selectedPortfolio) {
      showModalBottomSheet(
          barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return _removePortfolio(selectedPortfolio);
          });
    }

    querySnapshot = Provider.of<QuerySnapshot>(context);
    user = (Provider.of<UserData>(context));

    if (isLoaded == true) {
      return Container(
          color: DarkTheme(isDark).backgroundColour,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              // resizeToAvoidBottomPadding: true,
              resizeToAvoidBottomInset: true,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight * 0.7),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: DarkTheme(isDark).backgroundColour,
                  title: Text(
                    userName.capitalizeAll(),
                    style: TextStyle(color: DarkTheme(isDark).textColor.withOpacity(.8)),
                  ),
                  centerTitle: true,
                  leading: Container(
                    child: InkWell(
                      onTap: () async {
                        Navigator.pushNamed(context, "/settings", arguments: data)
                            .then((value) => setState(() {
                                  updateChanges = true;
                                }));
                      },

                      // onPressed: () => Navigator.pushNamed(context, '/settings', arguments: data),
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/icons/settings.png',
                          color: DarkTheme(isDark).iconColour,
                          // height: _height * 0.1,
                          // width: _width * 0.1,
                          fit: BoxFit.scaleDown,
                          scale: 17,
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () async {
                        var result = await Navigator.pushNamed(context, '/search', arguments: {
                          'data': data,
                          'portfolios': data['portfolios'],
                        });

                        if (result != null) {
                          setState(() {
                            updateChanges = true;
                            isSaveData = true;
                          });
                        }
                      },
                      icon: ClipRRect(
                        child: Image.asset(
                          'assets/icons/search.png',
                          color: DarkTheme(isDark).iconColour,
                          // height: _height * 0.1,
                          // width: _width * 0.1,
                          fit: BoxFit.fill,
                          scale: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: ListView(
                  padding: EdgeInsets.only(top: 10),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: (ratio <= 1.6) ? 3 : 2,
                      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: (ratio <= 1.6) ? 1.7 : 1.3,
                      children: portfolios.map((p) {
                        // print(p['portfolioName']);
                        return Ink(
                          decoration: BoxDecoration(
                              color: DarkTheme(isDark).insideColour,
                              border: Border.all(color: DarkTheme(isDark).iconColour.withOpacity(.2)),
                              borderRadius: BorderRadius.circular(5)),
                          child: InkWell(
                            onLongPress: () {
                              _showRemovePortfolioPanel(p);
                            },
                            onTap: () async {
                              Navigator.pushNamed(context, '/portfolio',
                                  arguments: {'portfolio': p, 'data': data}).then((value) => setState(() {}));
                            },
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            p['name'].toString().capitalizeAll(),
                                            style: setOptionStyle.copyWith(
                                              color: DarkTheme(isDark).textColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.arrow_right_rounded,
                                          color: DarkTheme(isDark).iconColour.withOpacity(.3),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('$baseCurrency ',
                                            style: TextStyle(
                                                color: DarkTheme(isDark).textColor,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w400)),
                                        Text(
                                            p['portfolioValue'] > 1000000
                                                ? NumberFormat.compact().format(p['portfolioValue'])
                                                : '${p['portfolioValue'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}', //${p['baseCurrency']}
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: DarkTheme(isDark).textColor,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('INVESTED', style: assetHeaderStyle),
                                            Text(
                                                p['investedValue'] > 1000
                                                    ? '$baseCurrency${NumberFormat.compact().format(p['investedValue'])}'
                                                    : '$baseCurrency${p['investedValue'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}', //${p['baseCurrency']}
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: DarkTheme(isDark).textColor,
                                                    fontWeight: FontWeight.w400)),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text('RETURN', style: assetHeaderStyle),
                                            Text(
                                                p['change'] > 1000
                                                    ? '$baseCurrency${NumberFormat.compact().format(p['change'])}'
                                                    : '$baseCurrency${p['change'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: (double.parse(p['change'].toString()) > 0
                                                        ? DarkTheme(isDark).greenVarient //Colors.green
                                                        : DarkTheme(isDark).redVarient))),
                                            Text(
                                                (double.parse(p['investedValue'].toString()) == 0.0)
                                                    ? '0'
                                                    : '${(double.parse(p['change'].toString()) / double.parse(p['investedValue'].toString()) * 100).toStringAsFixed(2)}%',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: (double.parse(p['change'].toString()) > 0
                                                        ? DarkTheme(isDark).greenVarient //Colors.green
                                                        : DarkTheme(isDark).redVarient)))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      InkWell(
                        onTap: () async {
                          await Update(baseC).updateValues(portfolios, context, data);

                          setState(() {
                            updating = true;
                          });
                        },
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/icons/update.png',
                            color: DarkTheme(isDark).iconColour,
                            fit: BoxFit.fill,
                            scale: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: InkWell(
                            onTap: () async {
                              Navigator.of(context).pushNamed('/newPortfolio',
                                  arguments: {'data': data, 'initalData': initData});
                            },
                            child: Icon(
                              Icons.dashboard_customize,
                              color: DarkTheme(isDark).iconColour,
                              size: 23,
                            )
                            //Text('ADD', style: TextStyle(color: DarkTheme(isDark).goldVarient),),
                            ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ));
    } else {
      loadData();

      return MainLoading();
    }
  }

  _removePortfolio(Map selectedPortfolio) {
    return Container(
      decoration: BoxDecoration(
          color: DarkTheme(isDark).insideColour,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: FlatButton(
          onPressed: () async {
            portfolios.remove(selectedPortfolio);

            // print(initData);

            initData['portfolios']
                .removeWhere((portfolio) => portfolio['name'] == selectedPortfolio['portfolioName']);

            // print(initData);

            setState(() {});

            await DatabaseService(uid: user.uid)
                .updateUserData(portfolios: initData['portfolios'], userDetails: data['userDetails']);
          },
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete, color: DarkTheme(isDark).redVarient),
                Text(
                  'Remove',
                  style: TextStyle(fontSize: 20, color: DarkTheme(isDark).redVarient),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

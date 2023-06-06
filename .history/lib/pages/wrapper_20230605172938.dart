import 'dart:async';
import 'dart:core';

import 'package:valuid/models/account/account.dart';
import 'package:valuid/models/portfolio/portfolio.dart';
import 'package:valuid/models/quote/quote.dart';
import 'package:valuid/models/user/user.dart';
import 'package:valuid/pages/calender/calender.dart';
import 'package:valuid/pages/login_register/login.dart';
import 'package:valuid/pages/login_register/verify.dart';
import 'package:valuid/pages/search/search.dart';
import 'package:valuid/pages/viewPortfolio/viewPortfolio.dart';
import 'package:valuid/services/database/database.dart';
import 'package:valuid/services/forex/forex_conversion.dart';
import 'package:valuid/services/marketbeat/marketbeat.dart';
import 'package:valuid/shared/Custome_Widgets/botomSheet/custome_Bottom_Sheet.dart';
import 'package:valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:valuid/shared/custom_scaffold/custom_navigator.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/pageLoaders/noPortfolio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/pages/settings/settings.dart' as s;
import 'package:collection/collection.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  Future<bool> initalise() async {
    try {
      dataObject.account = AccountObject.fromMap(doc['account']);
      dataObject.userCurrencySymbol =
          ForexConversion(baseCurrency: doc['account']['currency']).getCurrencySymbol()['symbol'];

      dataObject.userCurrency =
          ForexConversion(baseCurrency: doc['account']['currency']).getCurrencySymbol()['short'];

      if ((dataObject.oldDoc == null ||
              !DeepCollectionEquality().equals(doc['portfolios'], dataObject.oldDoc['portfolios'])) &&
          doc['portfolios'].length > 0) {
        dataObject.portfolios = PortfolioObject().listPortfolioObjectFromMap(doc);

        if (dataObject.portfolios.length > 0) {
          for (var portfolio in dataObject.portfolios) {
            portfolio.value = 0;
            portfolio.invested = 0;
            portfolio.change = 0;
            portfolio.changePercent = 0;

            if (portfolio.holdings.isNotEmpty) {
              List<QuoteObject> b = await Marketbeat().getMarketbeatQuoteList(portfolio.holdings);

              portfolio.holdings = QuoteObject().combineToList(portfolio.holdings, b);

              for (var holding in portfolio.holdings) {
                double conversion = ForexConversion(baseCurrency: dataObject.account.currency)
                    .getRate(await DatabaseService().getRates(), holding.currency);

                holding.regularMarketPrice *= conversion;
                holding.regularMarketChange *= conversion;

                holding.change =
                    (holding.regularMarketPrice - (holding.purchasePrice * conversion)) * holding.quantity;
                holding.changePercent = (holding.change / holding.purchasePrice) * 100;
                holding.invested = holding.purchasePrice * holding.quantity * conversion;
                holding.value = holding.change + holding.invested;

                portfolio.value += holding.value;
                portfolio.invested += holding.invested;
                portfolio.change += holding.change;
                portfolio.changePercent = (portfolio.change / portfolio.invested) * 100;
              }
            }
          }

          dataObject.onPortfolio = dataObject.portfolios.first;
          setSort(dataObject: dataObject);

          dataObject.oldDoc = doc;
        }
      }
    } catch (e) {
      PrintFunctions().printError('initalise: $e');
    }

    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    timer = Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctxt) {
        return Login();
      }));
    });
  }

  late DataObject dataObject = DataObject();
  late DocumentSnapshot doc;
  var _auth = FirebaseAuth.instance;
  late Timer timer;

  @override
  Widget build(BuildContext context) {
    UserObject user = (Provider.of<UserObject>(context));

    dataObject.context = context;
    dataObject.width = MediaQuery.of(context).size.width;
    dataObject.height = MediaQuery.of(context).size.height;
    dataObject.user = _auth.currentUser!;

    if (user == null) {
      if (!timer.isActive) {
        startTimer();
      }

      return Loading();
    } else {
      timer.cancel();

      try {
        if (_auth.currentUser!.emailVerified) {
          return StreamProvider<DocumentSnapshot?>.value(
              initialData: null,
              value: DatabaseService(uid: _auth.currentUser!.uid).userPortfolioData,
              builder: (context, snapshot) {
                doc = Provider.of<DocumentSnapshot>(context);

                if (doc.data() != null) {
                  return FutureBuilder<bool>(
                    future: initalise(),
                    builder: (context, snapshot) {
                      if (snapshot.data == true) {
                        return Container(
                          color: backgroundColour,
                          child: CustomScaffold(
                            dataObject: dataObject,
                            onItemTap: (index) {},
                            children: [
                              dataObject.portfolios.length == 0
                                  ? EmptyList(dataObject: dataObject)
                                  : ViewPortfolio(dataObject: dataObject),
                              Calender(dataObject: dataObject),
                              Search(dataObject: dataObject),
                              // StreamProvider<QuerySnapshot>.value(
                              //     initialData: null,
                              //     value: DatabaseService().feed,
                              //     builder: (context, snapshot) {
                              //       return Community(
                              //         dataObject: dataObject,
                              //       );
                              //     }),
                              s.Settings(dataObject: dataObject)
                            ],
                            scaffold: Scaffold(
                              backgroundColor: backgroundColour,
                              resizeToAvoidBottomInset: true,
                              bottomNavigationBar: BottomNavigationBar(
                                  elevation: 0,
                                  iconSize: 1, // ADD THIS
                                  backgroundColor: Colors.transparent,
                                  selectedFontSize: 0, // ADD THIS
                                  unselectedFontSize: 0,
                                  showSelectedLabels: false,
                                  showUnselectedLabels: false,
                                  type: BottomNavigationBarType.fixed,
                                  selectedItemColor: blueVarient,
                                  unselectedItemColor: textColorVarient,
                                  onTap: (value) {},
                                  items: [
                                    BottomNavigationBarItem(icon: Container(), label: 'Home'),
                                    BottomNavigationBarItem(icon: Container(), label: 'Calender'),
                                    BottomNavigationBarItem(icon: Container(), label: 'Search'),
                                    // BottomNavigationBarItem(icon: Container(), label: 'News'),
                                    BottomNavigationBarItem(icon: Container(), label: 'More'),
                                  ]),
                            ),
                          ),
                        );
                      } else {
                        return Loading();
                      }
                    },
                  );
                } else {
                  return Loading();
                }
              });
        } else {
          return VerifyScreen();
        }
      } catch (e) {
        print(e.toString());
        print('object');
      }

      return Loading();
    }
  }
}

import 'dart:async';
import 'package:Valuid/pages/community/social.dart';
import 'package:Valuid/pages/home/dashboard.dart';
import 'package:Valuid/pages/search/search.dart';
import 'package:Valuid/pages/calender/calender.dart';
import 'package:Valuid/services/Network/network.dart';
import 'package:Valuid/services/database/database.dart';
import 'package:Valuid/shared/custom_scaffold/custom_navigator.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/dividends/dividends.dart';
import 'package:Valuid/shared/earnings/earnings.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/update/initialise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final Map data;

  const Home({Key key, this.data}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    _marketPriceUpdateStreamController = new StreamController.broadcast();

    timer = Timer.periodic(Duration(seconds: 10), (timer) => _quickUpdate());

    // loadData();
  }

  Timer timer;

  StreamController<List> _marketPriceUpdateStreamController;

  bool isOnline = true;

  DataObject dataObject;

  loadData() {
    dataObject = DataObject.fromMap(widget.data);
    dataObject.context = context;

    dataObject.userFire = _auth.currentUser;

    dataObject.userCurrencySymbol =
        Initialise(baseCurrency: dataObject.databaseData['profile_data']['baseCurrency'])
            .getCurrencySymbol()['symbol'];

    dataObject.userCurrency =
        Initialise(baseCurrency: dataObject.databaseData['profile_data']['baseCurrency'])
            .getCurrencySymbol()['short'];

    for (var dividend in widget.data['dividends']) {
      dataObject.dividends.add(Dividends.fromMap(dividend));
    }

    for (var earning in widget.data['earnings']) {
      dataObject.earnings.add(Earnings.fromMap(earning));
    }

    dataObject.theme = false;

    updatePrice(dataObject);
  }

  @override
  Widget build(BuildContext context) {
    dataObject.width = MediaQuery.of(context).size.width;
    dataObject.height = MediaQuery.of(context).size.height;

    // PrintFunctions().printStartEndLine(dataObject.height);

    // PrintFpdasunctions().printStartEndLine(CustomTextStyles(dataObject.theme, context).appBarTitleStyle.fontSize);

    return Container(
      color: backgroundColour,
      child: CustomScaffold(
        dataObject: dataObject,
        onItemTap: (index) {},
        children: [
          StreamBuilder(
              stream: _marketPriceUpdateStreamController.stream,
              builder: (context, AsyncSnapshot<dynamic> asyncSnapshot) => Dashboard(
                    dataObject: dataObject,
                  )),
          Calender(
            dataObject: dataObject,
          ),
          StreamProvider<QuerySnapshot>.value(
              initialData: null,
              value: DatabaseService().feed,
              builder: (context, snapshot) {
                return Community(
                  dataObject: dataObject,
                );
              }),
          // Search(
          //   dataObject: dataObject,
          // ),
          Search(
            dataObject: dataObject,
          ),
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
                BottomNavigationBarItem(label: 'Home', icon: Container()),
                BottomNavigationBarItem(icon: Container(), label: 'Calender'),
                BottomNavigationBarItem(icon: Container(), label: 'News'),
                BottomNavigationBarItem(icon: Container(), label: 'Search'),
              ]),
        ),
      ),
    );
  }

  getConnection() async {
    return await Network('').getConnectionStatus();
  }

  _quickUpdate() async {
    try {
      if ((DateTime.now().weekday != 6 && DateTime.now().weekday != 7) ||
          dataObject.lastCalenderUpdate == '') {
        int count = 0;

        isOnline = await getConnection();

        if (dataObject.offlineUpdate == true && isOnline == true) {
          dataObject.offlineUpdate = false;

          final _auth = FirebaseAuth.instance;
          User user = _auth.currentUser;

          await DatabaseService(uid: user.uid).updateChange(dataObject);
        }

        if (isOnline) {
          ([]..addAll(dataObject.stocks)).forEach((holding) async {
            if (holding['typeId'] == 'stocks') {
              // Map data = await YahooApiService()
              //     .getYahooQuote(exchange: holding['exchange'], symbol: holding['symbol']);

              // if (data != null && data.isNotEmpty && data != {}) {
              //   holding['marketData']['quote'] = data;
              // }

              count++;
            }

            if (count == ([]..addAll(dataObject.stocks)).length) {
              updatePrice(dataObject);

              _marketPriceUpdateStreamController.add([true]);
            }
          });
        } else {}
      }
    } catch (e) {}
  }
}

updatePrice(DataObject dataObject) {
  for (var portfolio in dataObject.portfolios) {
    for (var assetType in portfolio['assets']) {
      if (assetType['id'] == 'stocks') {
        for (var asset in assetType['items']) {
          if (dataObject.stocks.isEmpty) {
            dataObject.stocks.add(asset);
          } else {
            int isAssetExist =
                dataObject.stocks.indexWhere((element) => element['symbol'] == asset['symbol']);

            if (isAssetExist == -1) {
              dataObject.stocks.add(asset);
            }
          }
        }
      }
    }
  }
}

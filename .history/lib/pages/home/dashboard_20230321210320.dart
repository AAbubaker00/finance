import 'dart:async';

import 'package:Valuid/models/account/account.dart';
import 'package:Valuid/models/portfolio/portfolio.dart';
import 'package:Valuid/models/quote/quote.dart';
import 'package:Valuid/pages/settings/settings.dart' as s;
import 'package:Valuid/services/Network/network.dart';
import 'package:Valuid/services/database/database.dart';
import 'package:Valuid/services/forex/forexConversion.dart';
import 'package:Valuid/shared/Custome_Widgets/cards/portfolioList.dart';
import 'package:Valuid/shared/Custome_Widgets/loading/dashboardShimmer.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/pageLoaders/offline.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/yahooapi/yahoo_api_provider.dart';
import 'package:collection/collection.dart';

class Dashboard extends StatefulWidget {
  final DataObject dataObject;

  Dashboard({Key key, this.dataObject}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void dispose() {
    updateFrequency.cancel();
    super.dispose();
  }

  getMarketQuotes() async {
    updateState = true;
    isOnline = true;

    try {
      for (var pObject in widget.dataObject.portfolios) {
        List<QuoteObject> h = [];
        pObject.value = 0;
        pObject.invested = 0;
        pObject.change = 0;
        pObject.changePercent = 0;

        for (var holding in pObject.holdings) {
          holding = QuoteObject().combineTo(holding,
              await YahooApiService().getYahooQuote(symbol: holding.symbol, exchange: holding.exchange));

          double conversion = ForexConversion(baseCurrency: doc['account']['currency'])
              .getRate(await DatabaseService().getRates(), holding.currency);

          holding.regularMarketPrice *= conversion;
          holding.regularMarketChange *= conversion;

          holding.change =
              (holding.regularMarketPrice - (holding.purchasePrice * conversion)) * holding.quantity;
          holding.changePercent = (holding.change / holding.purchasePrice) * 100;
          holding.invested = holding.purchasePrice * holding.quantity * conversion;
          holding.value = holding.change + holding.invested;

          pObject.value += holding.value;
          pObject.invested += holding.invested;
          pObject.change += holding.change;

          h.add(holding);
        }

        pObject..holdings.clear();
        pObject.holdings = h;
      }
    } catch (e) {
      print(e.toString());
    }

    for (var portfolio in widget.dataObject.portfolios) {
      portfolio.changePercent = (portfolio.change / portfolio.invested) * 100;
    }

    print('updated');
    setState(() {});

    updateState = false;
    widget.dataObject.oldDoc = doc;
    priceUpdateStream.add([true]);
  }

  Future<bool> initalise() async {
    if (await Network().getConnectionStatus()) {
      widget.dataObject.account = AccountObject.fromMap(doc['account']);
      widget.dataObject.userCurrencySymbol =
          ForexConversion(baseCurrency: doc['account']['currency']).getCurrencySymbol()['symbol'];

      widget.dataObject.userCurrency =
          ForexConversion(baseCurrency: doc['account']['currency']).getCurrencySymbol()['short'];

      if (widget.dataObject.oldDoc == null ||
          !DeepCollectionEquality().equals(doc['portfolios'], widget.dataObject.oldDoc['portfolios'])) {
        widget.dataObject.portfolios = PortfolioObject().listPortfolioObjectFromMap(doc);

        await getMarketQuotes();
      }
    } else {
      isOnline = false;
      setState(() {});
    }

    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();

    priceUpdateStream = new StreamController.broadcast();

    updateFrequency = Timer.periodic(Duration(seconds: 10), (timer) async {
      await Network().getConnectionStatus()
          ? updateState == false
              ? await getMarketQuotes()
              : print('waiting')
          : setState(() => isOnline = false);
    });
  }

  DocumentSnapshot doc;
  Timer updateFrequency;
  StreamController<List> priceUpdateStream;
  bool updateState = false, isOnline = true;

  @override
  Widget build(BuildContext context) {
    doc = Provider.of<DocumentSnapshot>(context);

    return FutureBuilder<bool>(
      future: doc == null ? Future.value(false) : initalise(),
      builder: (context, snapshot) {
        return CWScaffold(
            scaffoldBgColour: ScaffoldBgColourOptions.LIGHT,
            bottomAppBarBorderColour: false,
            appBarTitleWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Image.asset(
                      'assets/icons/profile.png',
                      width: iconSize,
                      height: iconSize,
                      color: iconColour,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        widget.dataObject.user.email,
                        style: CustomTextStyles(widget.dataObject.context).portfolioNameStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(buttonRadius),
                    highlightColor: Colors.transparent,
                    onTap: () async => await Navigator.push(
                        context,
                        CustomPageRouteSlideTransition(
                            direction: AxisDirection.left, child: s.Settings(dataObject: widget.dataObject))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'assets/icons/menu.png',
                        width: iconSize,
                        height: iconSize,
                        color: iconColour,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: snapshot.data == true
                ? isOnline
                    ? StreamBuilder(
                        stream: priceUpdateStream.stream,
                        builder: (context, snapshot) => ListView(
                          padding: EdgeInsets.only(top: 5, bottom: 10, left: 15, right: 15),
                          children: [
                            PortfolioList(
                              dataObject: widget.dataObject,
                            )
                          ],
                        ),
                      )
                    : Offline()
                : DashboardShimmer());
      },
    );
  }
}

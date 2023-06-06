import 'dart:async';

import 'package:Valuid/models/account/account.dart';
import 'package:Valuid/models/portfolio/portfolio.dart';
import 'package:Valuid/models/quote/quote.dart';
import 'package:Valuid/pages/settings/settings.dart' as s;
import 'package:Valuid/pages/viewPortfolio/viewPortfolio.dart';
import 'package:Valuid/services/database/database.dart';
import 'package:Valuid/services/forex/forexConversion.dart';
import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:Valuid/shared/Custome_Widgets/cards/portfolioCard.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/yahooapi/yahoo_api_provider.dart';
import 'create.dart';
import 'package:collection/collection.dart';

class Dashboard extends StatefulWidget {
  final DataObject dataObject;

  Dashboard({Key key, this.dataObject}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  getMarketQuotes() async {
    updateState = true
    try {
      for (var pObject in widget.dataObject.portfolios) {
        List<QuoteObject> h = [];

        for (var holding in pObject.holdings) {
          holding = QuoteObject().combineTo(holding,
              await YahooApiService().getYahooQuote(symbol: holding.symbol, exchange: holding.exchange));

          double conversion = ForexConversion(baseCurrency: doc['account']['currency'])
              .getRate(await DatabaseService().getRates(), holding.currency);

          holding.regularMarketPrice *= conversion;
          holding.regularMarketChange *= conversion;
          holding.purchasePrice *= conversion;

          holding.change = (holding.regularMarketPrice - holding.purchasePrice) * holding.quantity;
          holding.changePercent = (holding.change / holding.purchasePrice) * 100;
          holding.invested = holding.purchasePrice * holding.quantity;
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
      print('here');
      print(e.toString());
    }

    for (var portfolio in widget.dataObject.portfolios) {
      portfolio.changePercent = (portfolio.change / portfolio.invested) * 100;
    }

    priceUpdateStream.add([true]);
  }

  Future<bool> initalise() async {
    widget.dataObject.account = AccountObject.fromMap(doc['account']);
    widget.dataObject.userCurrencySymbol =
        ForexConversion(baseCurrency: doc['account']['currency']).getCurrencySymbol()['symbol'];

    widget.dataObject.userCurrency =
        ForexConversion(baseCurrency: doc['account']['currency']).getCurrencySymbol()['short'];

    if (widget.dataObject.oldDoc == null ||
        !DeepCollectionEquality().equals(doc['portfolios'], widget.dataObject.oldDoc['portfolios'])) {
      widget.dataObject.portfolios = PortfolioObject().listPortfolioObjectFromMap(doc);

      widget.dataObject.oldDoc = doc;
      await getMarketQuotes();

      setState(() {
        print('updated');
      });
    }

    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();

    priceUpdateStream = new StreamController.broadcast();
  }

  void startTimer() => updateFrequency = Timer.periodic(Duration(seconds: 10), (timer) async {
        updateState == false? await getMarketQuotes() : print('waiting');
      });

  DocumentSnapshot doc;
  Timer updateFrequency;
  StreamController<List> priceUpdateStream;
  bool updateState = false;

  @override
  Widget build(BuildContext context) {
    doc = Provider.of<DocumentSnapshot>(context);

    return FutureBuilder<bool>(
      future: doc == null ? Future.value(false) : initalise(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return CWScaffold(
            dataObject: widget.dataObject,
            scaffoldBgColour: ScaffoldBgColourOptions.LIGHT,
            bottomAppBarBorderColour: true,
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
            body: StreamBuilder(
              stream: priceUpdateStream.stream,
              builder: (context, snapshot) => ListView(
                padding: EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
                        child: Text('Your portfolios',
                            style: CustomTextStyles(widget.dataObject.context).portfolioNameStyle),
                      ),
                      Column(
                        children: List.generate(
                                widget.dataObject.portfolios.length + 1,
                                (index) => index == widget.dataObject.portfolios.length
                                    ? Container()
                                    : widget.dataObject.portfolios[index])
                            .map<Widget>((portfolio) => portfolio.runtimeType == Container
                                ? CWApplyButton(
                                    isLinearGradient: true,
                                    isBgColurOn: false,
                                    customColour: blueVarient,
                                    customTextColour: summaryColour,
                                    customTextStyle: CustomTextStyles(widget.dataObject.context)
                                        .appBarTitleStyle
                                        .copyWith(
                                            letterSpacing: 1,
                                            color: summaryColour,
                                            fontWeight: FontWeight.w600),
                                    function: () => Navigator.push(
                                        context,
                                        CustomPageRouteSlideTransition(
                                          direction: AxisDirection.left,
                                          child: CreatePortfolio(
                                            dataObject: widget.dataObject,
                                          ),
                                        )),
                                    btnText: 'ADD PORTFOLIO',
                                    verticalPadding: 20,
                                    addBorder: false,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: InkWell(
                                        borderRadius: BorderRadius.circular(circularRadius),
                                        onTap: () async {
                                          widget.dataObject.onPortfolio = portfolio;
                                          Navigator.push(
                                              context,
                                              CustomPageRouteSlideTransition(
                                                  direction: AxisDirection.left,
                                                  child: ViewPortfolio(dataObject: widget.dataObject)));
                                        },
                                        child: PortfolioCard(
                                          index: widget.dataObject.portfolios.indexOf(portfolio),
                                          dataObject: widget.dataObject,
                                          portfolio: portfolio,
                                        )),
                                  ))
                            .toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

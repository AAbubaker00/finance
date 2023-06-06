import 'package:Valuid/models/account/account.dart';
import 'package:Valuid/models/portfolio/portfolio.dart';
import 'package:Valuid/models/quote/quote.dart';
import 'package:Valuid/pages/settings/settings.dart' as s;
import 'package:Valuid/pages/viewPortfolio/viewPortfolio.dart';
import 'package:Valuid/services/database/database.dart';
import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:Valuid/shared/Custome_Widgets/portfolioCard/portfolioCard.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:Valuid/shared/update/initialise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/yahooapi/yahoo_api_provider.dart';
import 'newPortfolio.dart';

class Dashboard extends StatefulWidget {
  final DataObject dataObject;

  Dashboard({Key key, this.dataObject}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ScrollController mainScrolController = ScrollController();

  final _auth = FirebaseAuth.instance;

  DocumentSnapshot doc;

  Future<bool> initalise() async {
    widget.dataObject.account = AccountObject.fromMap(doc['account']);
    widget.dataObject.portfolios.clear();

    widget.dataObject.userCurrencySymbol =
        Initialise(baseCurrency: doc['account']['currency']).getCurrencySymbol()['symbol'];

        print(doc['portfolios'][0]['goal'].runtimeType);

    try {
      widget.dataObject.userCurrency =
          Initialise(baseCurrency: doc['account']['currency']).getCurrencySymbol()['short'];


      while (widget.dataObject.portfolios.length != doc['portfolios'].length) {
        for (var portfolio in doc['portfolios']) {

          for (var holding in portfolio['holdings']) {
            QuoteObject hObject = await YahooApiService()
                .getYahooQuote(symbol: holding['symbol'], exchange: holding['exchange']);

            hObject.quantity = (holding['quantity'] as int).toDouble();
            hObject.purchasePrice = holding['purchasePrice'];

            double conversion = Initialise(baseCurrency: doc['account']['currency'])
                .getRate(await DatabaseService().getRates(), hObject.currency);

            hObject.regularMarketPrice *= conversion;
            hObject.regularMarketChange *= conversion;
            hObject.purchasePrice *= conversion;

            hObject.change = hObject.regularMarketPrice - hObject.purchasePrice;
            hObject.changePercent = (hObject.change / hObject.purchasePrice) * 100;
            hObject.invested = hObject.purchasePrice * hObject.quantity;
            hObject.value = pObject.invested += hObject.invested;

            pObject.value += hObject.value;
            pObject.invested += hObject.invested;
            pObject.change += hObject.change;
            pObject.holdings.add(hObject);
          }

          widget.dataObject.portfolios.add(pObject);
        }

        for (var portfolio in widget.dataObject.portfolios) {
          portfolio.changePercent = (portfolio.change / portfolio.invested) * 100;
        }
      }
    } catch (e) {
      print(e.toString());
    }

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    doc = Provider.of<DocumentSnapshot>(context);

    print('object');

    return FutureBuilder<bool>(
      future: doc == null ? Future.value(false) : initalise(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return CWScaffold(
            dataObject: widget.dataObject,
            scaffoldBgColour: scaffoldBgColourOptions.LIGHT,
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
                      // color: iconColour,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        _auth.currentUser.email,
                        style: CustomTextStyles(widget.dataObject.context)
                            .holdingValueStyle
                            .copyWith(fontWeight: FontWeight.w500),
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
            body: ListView(
              controller: mainScrolController,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
                  child: Column(
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
                                    dataObject: widget.dataObject,
                                    isBgColurOn: false,
                                    customColour: blueVarient.withOpacity(.8),
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
                                          child: NewPortfolio(
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
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

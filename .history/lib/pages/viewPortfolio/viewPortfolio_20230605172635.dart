import 'dart:async';

import 'package:valuid/models/quote/quote.dart';
import 'package:valuid/pages/home/info.dart';
import 'package:valuid/pages/viewPortfolio/allocations.dart';
import 'package:valuid/pages/viewPortfolio/holdingsSection.dart';
import 'package:valuid/services/Network/network.dart';
import 'package:valuid/services/database/database.dart';
import 'package:valuid/services/forex/forex_conversion.dart';
import 'package:valuid/services/marketbeat/marketbeat.dart';
import 'package:valuid/services/yahooapi/yahoo_api_provider.dart';
import 'package:valuid/shared/Custome_Widgets/botomSheet/custome_Bottom_Sheet.dart';
import 'package:valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/ads/ad_helper.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/pageLoaders/offline.dart';
import 'package:valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import '../../shared/Custome_Widgets/loading/loading.dart';

class ViewPortfolio extends StatefulWidget {
  final DataObject dataObject;

  ViewPortfolio({Key key, this.dataObject}) : super(key: key);

  @override
  _ViewPortfolioState createState() => _ViewPortfolioState();
}

class _ViewPortfolioState extends State<ViewPortfolio> {
  Widget checkBannerAdStatus() {
    if (isAdLoaded) {
      return Container(
        padding: const EdgeInsets.only(top: 10),
        child: Center(
          child: Container(
            width: floatingBottomAd.size.width.toDouble(),
            height: floatingBottomAd.size.height.toDouble(),
            alignment: Alignment.center,
            child: AdWidget(
              ad: floatingBottomAd,
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  @override
  void dispose() {
    updateFrequency.cancel();
    super.dispose();
  }

  getMarketQuotes() async {
    updateState = true;

    try {
      if (selectedTab == 'Investments') {
        if (await Network().getConnectionStatus()) {
          isOnline = true;

          widget.dataObject.onPortfolio!.value = 0;
          widget.dataObject.onPortfolio!.invested = 0;
          widget.dataObject.onPortfolio.change = 0;
          widget.dataObject.onPortfolio.changePercent = 0;

          if (widget.dataObject.onPortfolio.holdings.length > 0) {
            List<QuoteObject> b =
                await Marketbeat().getMarketbeatQuoteList(widget.dataObject.onPortfolio.holdings);

            widget.dataObject.onPortfolio.holdings =
                QuoteObject().combineToList(widget.dataObject.onPortfolio.holdings, b);

            for (var holding in widget.dataObject.onPortfolio.holdings) {
              double conversion = ForexConversion(baseCurrency: widget.dataObject.account.currency)
                  .getRate(await DatabaseService().getRates(), holding.currency);

              holding.regularMarketPrice *= conversion;
              holding.regularMarketChange *= conversion;

              holding.change =
                  (holding.regularMarketPrice - (holding.purchasePrice * conversion)) * holding.quantity;
              holding.changePercent = (holding.change / holding.purchasePrice) * 100;
              holding.invested = holding.purchasePrice * holding.quantity * conversion;
              holding.value = holding.change + holding.invested;

              widget.dataObject.onPortfolio.value += holding.value;
              widget.dataObject.onPortfolio.invested += holding.invested;
              widget.dataObject.onPortfolio.change += holding.change;
              widget.dataObject.onPortfolio.changePercent =
                  (widget.dataObject.onPortfolio.change / widget.dataObject.onPortfolio.invested) * 100;
            }
          }

          setSort(dataObject: widget.dataObject);
        } else {
          isOnline = false;
        }
      }
    } catch (e) {
      PrintFunctions().printError(e.toString());
    }

    updateState = false;
    widget.dataObject.isLoaded = true;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    floatingBottomAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(
            onAdLoaded: (_) => setState(() => isAdLoaded = true),
            onAdFailedToLoad: (_, error) => PrintFunctions().printStartEndLine(error)),
        request: AdRequest());

    floatingBottomAd.load();

    updateFrequency = Timer.periodic(Duration(seconds: 10), (timer) {
      updateState == false
          ? widget.dataObject.isLoaded
              ? getMarketQuotes()
              : print('waiting2')
          : print('waiting');
    });
  }

  late Timer updateFrequency;
  bool updateState = false, isOnline = true, isAdLoaded = false;

  List tabs = ['Summary', 'Investments', 'Allocations', 'Projection'];

  String selectedTab = 'Summary';

  late BannerAd floatingBottomAd;

  @override
  Widget build(BuildContext context) {
    if (widget.dataObject.isLoaded && isOnline) {
      return CWScaffold(
          scaffoldBgColour: BgTheme.LIGHT,
          bottomAppBarBorderColour: false,
          isCenter: false,
          appBarTitleWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () => viewPortfoliosBottomSheet(dataObject: widget.dataObject, setState: setState),
                    customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(circularRadius)),
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            widget.dataObject.portfolios.length > 0 ? widget.dataObject.onPortfolio.name : '',
                            style: CustomTextStyles(context).appBarTitleStyle,
                          ),
                          Icon(Icons.keyboard_arrow_down_rounded)
                        ]))),
                InkWell(
                  borderRadius: BorderRadius.circular(buttonRadius),
                  highlightColor: Colors.transparent,
                  onTap: () async => await Navigator.push(
                          context,
                          CustomPageRouteSlideTransition(
                              direction: AxisDirection.left,
                              child: PortfolioInfo(dataObject: widget.dataObject)))
                      .then((feedback) {
                    if (feedback != null && mounted) {
                      setState(() {});
                    }
                  }),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      child: Image.asset('assets/icons/edit.png',
                          width: iconSize, height: iconSize, color: iconColour),
                    ),
                  ),
                )
              ],
            ),
          ),
          preferredSizeValue: 1.7,
          appBarBottomWidget: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Column(children: [
              Container(
                // decoration: BoxDecoration(border: Border(bottom: BorderSide(color: seperator, width: .7))),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: tabs
                          .map<Widget>((tab) => IntrinsicWidth(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: tabs.first == tab ? 15 : 0, right: tabs.last == tab ? 15 : 30),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () => setState(() => selectedTab = tab),
                                    child: Column(
                                      children: [
                                        Text(
                                          tab,
                                          style: CustomTextStyles(context).portfolioNameStyle.copyWith(
                                              color: selectedTab == tab ? blueVarient : textColorVarient),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10.0),
                                          child: Container(
                                              height: 4.8,
                                              decoration: BoxDecoration(
                                                  color:
                                                      selectedTab == tab ? blueVarient : Colors.transparent,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(circularRadius),
                                                      topRight: Radius.circular(circularRadius))),
                                              child: Container()),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomDivider(height: 0, thickness: .7))
            ]),
          ),
          body: getPage());
    } else if (isOnline == false) {
      return Offline();
    } else {
      return Loading();
    }
  }

  Widget getPage() {
    switch (selectedTab) {
      case 'Summary':
        return getSummary();
        break;
      case 'Investments':
        return HoldingsSection(dataObject: widget.dataObject);
        break;
      case 'Allocations':
        return Allocations(dataObject: widget.dataObject);
        break;
      default:
        return Center(
            child: Text('Upcoming..', style: CustomTextStyles(context, value: 20).portfolioNameStyle));
        break;
    }
  }

  getSummary() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text('VALUE',
              style: CustomTextStyles(context).deleteTextStyle.copyWith(fontWeight: FontWeight.w400)),
          SizedBox(height: 5),
          Text(
              widget.dataObject.onPortfolio.value > 1000000000
                  ? '${widget.dataObject.userCurrencySymbol}${NumberFormat.compact().format(widget.dataObject.onPortfolio.value)}'
                  : '${widget.dataObject.userCurrencySymbol}${widget.dataObject.onPortfolio.value.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
              style: CustomTextStyles(context).calenderDateTextStyle),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('INVESTED',
                        style:
                            CustomTextStyles(context).deleteTextStyle.copyWith(fontWeight: FontWeight.w400)),
                    SizedBox(height: 5),
                    Text(
                        (widget.dataObject.onPortfolio.invested > 1000000)
                            ? '${widget.dataObject.userCurrencySymbol}${NumberFormat.compact().format(widget.dataObject.onPortfolio.invested).toString()}'
                            : '${widget.dataObject.userCurrencySymbol}${widget.dataObject.onPortfolio.invested.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                        style: CustomTextStyles(context, value: 20)
                            .portfolioNameStyle
                            .copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('EARNINGS',
                        style:
                            CustomTextStyles(context).deleteTextStyle.copyWith(fontWeight: FontWeight.w400)),
                    SizedBox(height: 5),
                    Text(
                        (widget.dataObject.onPortfolio.change >= 0)
                            ? '+${widget.dataObject.userCurrencySymbol}${widget.dataObject.onPortfolio.change.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${((widget.dataObject.onPortfolio.change / widget.dataObject.onPortfolio.invested) * 100).toStringAsFixed(2)}%)'
                            : '-${widget.dataObject.userCurrencySymbol}${(widget.dataObject.onPortfolio.change * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${((widget.dataObject.onPortfolio.change / widget.dataObject.onPortfolio.invested) * 100).toStringAsFixed(2)}%)',
                        style: CustomTextStyles(context, value: 20).portfolioNameStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: (widget.dataObject.onPortfolio.change > 0) ? greenVarient : redVarient)),
                  ],
                )
              ],
            ),
          ),
          checkBannerAdStatus(),
        ],
      ),
    );
  }
}

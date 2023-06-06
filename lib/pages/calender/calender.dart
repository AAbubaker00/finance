import 'package:valuid/models/quote/quote.dart';
import 'package:valuid/services/marketbeat/marketbeat.dart';
import 'package:valuid/services/yahooapi/yahoo_api_provider.dart';
import 'package:valuid/shared/Custome_Widgets/cards/eventList.dart';
import 'package:valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/ads/ad_helper.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/dateFormat/customeDateFormatter.dart';
import 'package:valuid/shared/dividends/dividends.dart';
import 'package:valuid/shared/earnings/earnings.dart';
import 'package:valuid/shared/files/fileHandler.dart';
import 'package:valuid/shared/pageLoaders/noEvents.dart';
import 'package:valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import 'dart:convert';

class Calender extends StatefulWidget {
  final DataObject dataObject;

  const Calender({required this.dataObject});

  @override
  _Calender createState() => _Calender();
}

class _Calender extends State<Calender> {
  Widget checkBannerAdStatus() {
    if (isAdLoaded) {
      return Container(
        color: summaryColour,
        padding: const EdgeInsets.only(top: 10),
        child: Center(
          child: Container(
            width: floatingBottomAd.size.width.toDouble(),
            height: floatingBottomAd.size.height.toDouble(),
            alignment: Alignment.center,
            child: AdWidget(ad: floatingBottomAd),
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

    selectedMonth = months[DateTime.now().month - 1];

    if (widget.dataObject.dividends.isNotEmpty && widget.dataObject.earnings.isNotEmpty) {
      setMonthsEvents();
    }
  }

  checkStored() async {
    try {
      var localCalenderEvents = await LocalDataSet().getCalenderEvents();
      if (localCalenderEvents != '') {
        Map jsonlocalCalenderEvents = json.decode(localCalenderEvents.toString());

        widget.dataObject.lastCalenderUpdate = jsonlocalCalenderEvents['lastCalenderUpdate'];
        widget.dataObject.dividends = Dividends().getMapToDividendList(jsonlocalCalenderEvents['dividends']);
        widget.dataObject.earnings = Earnings().getMapToEarningsList(jsonlocalCalenderEvents['earnings']);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> init() async {
    await checkStored();

    if (widget.dataObject.lastCalenderUpdate == '' ||
        DateTime.parse(widget.dataObject.lastCalenderUpdate).difference(DateTime.now()).inDays >= 5) {
      await getDividends();
      await getEarning();

      widget.dataObject.lastCalenderUpdate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      await LocalDataSet().updateLocalData(widget.dataObject);
    }

    setMonthsEvents();
    return Future.value(true);
  }

  Map selectedMonth = {};

  late BannerAd floatingBottomAd;
  bool isAdLoaded = false;

  List months = CustomDateFormatter().eventMonths;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: widget.dataObject.dividends.isEmpty && widget.dataObject.earnings.isEmpty
          ? init()
          : Future.value(true),
      builder: (context, snapshot) {
        if (snapshot.data == true ||
            widget.dataObject.dividends.isNotEmpty ||
            widget.dataObject.earnings.isNotEmpty) {
          return CWScaffold(
            bottomAppBarBorderColour: true,
            appBarTitleWidget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      selectedMonth =
                          months[selectedMonth['index'] == 1 ? 11 : months.indexOf(selectedMonth) - 1];

                      setState(() {});
                    },
                    customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(circularRadius)),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        Icons.chevron_left,
                        size: calenderIconSize,
                        color: iconColour,
                      ),
                    ),
                  ),
                  Text(
                    '${selectedMonth['id']}',
                    style: CustomTextStyles(widget.dataObject.context)
                        .appBarTitleStyle
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      selectedMonth =
                          months[selectedMonth['index'] == 12 ? 0 : months.indexOf(selectedMonth) + 1];

                      setState(() {});
                    },
                    customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(circularRadius)),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        Icons.chevron_right,
                        size: calenderIconSize,
                        color: iconColour,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            scaffoldBgColour: BgTheme.LIGHT,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: selectedMonth['events'].isEmpty
                    ? [NoEvents(selectedMonth)]
                    : [
                        checkBannerAdStatus(),
                        EventList(selectedMonth),
                      ]),
          );
        } else {
          return Loading();
        }
      },
    );
  }

  setMonthsEvents() {
    for (var month in months) {
      month['events'] = [];
    }

    for (var dividend in widget.dataObject.dividends) {
      var eventMonthPaymentDate = months
          .firstWhere((month) => month['index'] == DateTime.parse(dividend.date).month, orElse: () => null);

      eventMonthPaymentDate['events'].add(dividend);
      eventMonthPaymentDate['divTotal']++;

      var eventMonthExDate = months
          .firstWhere((month) => month['index'] == DateTime.parse(dividend.exDate).month, orElse: () => null);

      if (eventMonthPaymentDate != null && eventMonthExDate != null) {
        var exDividend = Dividends();

        exDividend.date = dividend.date;
        exDividend.exDate = dividend.exDate;

        exDividend.yield = dividend.yield;

        exDividend.amount = dividend.amount;
        exDividend.currency = dividend.currency;
        exDividend.dividendType = 'ex';
        exDividend.record = dividend.record;
        exDividend.symbol = dividend.symbol;
        exDividend.exchange = dividend.exchange;
        exDividend.name = dividend.name;
        exDividend.announced = dividend.announced;

        eventMonthExDate['events'].add(exDividend);
        eventMonthExDate['exTotal']++;
      }
    }

    for (var earning in widget.dataObject.earnings) {
      var eventMonthEarning = months
          .firstWhere((month) => month['index'] == DateTime.parse(earning!.date).month, orElse: () => null);

      if (eventMonthEarning != null) {
        eventMonthEarning['events'].add(earning);
        eventMonthEarning['earnTotal']++;
      }
    }

    for (var month in months) {
      month['groupedEvents'] = [];

      for (var event in month['events']) {
        var groupedEventDate = month['groupedEvents'].firstWhere(
            (grouped) =>
                DateTime.parse(grouped['date']) ==
                DateTime.parse((event.runtimeType == Dividends && event.dividendType == 'ex')
                    ? event.exDate
                    : event.date),
            orElse: () => null);

        if (groupedEventDate == null) {
          month['groupedEvents'].add({
            'date':
                (event.runtimeType == Dividends && event.dividendType == 'ex') ? event.exDate : event.date,
            'events': [event],
            'isNext': false,
          });
        } else {
          groupedEventDate['events'].add(event);
        }
      }
    }

    for (var month in months) {
      month['groupedEvents'].sort((a, b) => DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])));
    }
  }

  getDividends() async {
    List<QuoteObject> dividendHolding = [];

    for (var portfolio in widget.dataObject.portfolios) {
      for (var holding in portfolio.holdings) {
        if (holding.dividendSupport) {
          if (dividendHolding.indexWhere((h) => h.name == holding.name) == -1) {
            dividendHolding.add(holding);
          }
        }
      }
    }

    if (dividendHolding.length > 0)
      widget.dataObject.dividends = await Marketbeat().getDividends(holdings: dividendHolding);
  }

  getEarning() async {
    List<QuoteObject> allHoldings = [];

    for (var portfolio in widget.dataObject.portfolios) {
      for (var holding in portfolio.holdings) {
        var exist = allHoldings.indexWhere((h) => h.name == holding.name);

        if (exist == -1) allHoldings.add(holding);
      }
    }

    if (allHoldings.length > 0)
      widget.dataObject.earnings = (await YahooApiService().getYahooCalenderEvents(allHoldings))!;
  }
}

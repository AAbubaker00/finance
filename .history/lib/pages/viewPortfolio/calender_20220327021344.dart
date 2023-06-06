import 'dart:ui';
import 'package:Onvesting/services/marketbeat/marketbeat.dart';
import 'package:Onvesting/services/yahooapi/yahoo_api_provider.dart';
import 'package:Onvesting/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Onvesting/shared/Custome_Widgets/loading/loading.dart';
import 'package:Onvesting/shared/Custome_Widgets/restricted/restricted.dart';
import 'package:Onvesting/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvesting/shared/TextStyle/customTextStyles.dart';
import 'package:Onvesting/shared/ads/ad.dart';
import 'package:Onvesting/shared/ads/ad_helper.dart';
import 'package:Onvesting/shared/dataObject/data_object.dart';
import 'package:Onvesting/shared/dateFormat/customeDateFormatter.dart';
import 'package:Onvesting/shared/decoration/customDecoration.dart';
import 'package:Onvesting/shared/dividends/dividends.dart';
import 'package:Onvesting/shared/earnings/earnings.dart';
import 'package:Onvesting/shared/files/fileHandler.dart';
import 'package:Onvesting/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Onvesting/shared/shimmerLayouts/shimmerCalender.dart';
import 'package:Onvesting/shared/themes/themes.dart';
import 'package:Onvesting/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

class Calender extends StatefulWidget {
  final DataObject dataObject;

  const Calender({Key key, this.dataObject}) : super(key: key);

  @override
  _Calender createState() => _Calender();
}

class _Calender extends State<Calender> {
  @override
  @override
  void initState() {
    super.initState();

    months = CustomDateFormatter().eventMonths;

    selectedMonth = months[DateTime.now().month - 1];
  }

  Future<bool> init() async {
    monthReset();

    // print(widget.dataObject.lastCalenderUpdate);

    if (widget.dataObject.earnings.isEmpty ||
        widget.dataObject.dividends.isEmpty ||
        DateTime.parse(widget.dataObject.lastCalenderUpdate).difference(DateTime.now()).inDays >= 7 ||
        widget.dataObject.lastCalenderUpdate == '') {
      print('hgere');

      await getDividends();
      await getEarning();

      widget.dataObject.lastCalenderUpdate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      await LocalDataSet().updateLocalData(widget.dataObject);
    }

    setMonthsEvents();

    isLoaded = true;

    return Future.value(true);
  }

  Map selectedMonth = {};

  bool isLoaded = false;

  List months;

  @override
  Widget build(BuildContext context) {
    void viewMonths() {
      showModalBottomSheet(
        context: widget.dataObject.context,
        isScrollControlled: true,
        builder: (context) => StatefulBuilder(builder: (context, viewMonthSetState) {
          return Ink(
            decoration: BoxDecoration(
                color: UserThemes(widget.dataObject.theme).backgroundColour,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Units().circularRadius * 2),
                    topRight: Radius.circular(Units().circularRadius * 2))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 5),
                  child: Container(
                      width: 70,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: UserThemes(widget.dataObject.theme).textColorVarient,
                          borderRadius: BorderRadius.circular(Units().circularRadius)),
                      child: Row(
                        children: [],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Ink(
                    height: widget.dataObject.height * 0.4,
                    // decoration: CustomDecoration(widget.dataObject.theme, true).bottomsheetDecoration.copyWith(
                    //     border: Border.all(color: Colors.transparent),
                    //     color: UserThemes(widget.dataObject.theme).backgroundColour),
                    child: ListView(
                      shrinkWrap: true,
                      children: months.map<Widget>((month) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() => selectedMonth = month);
                                viewMonthSetState(() {});
                              },
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(Units().circularRadius)),
                              ),
                              child: Ink(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(Units().circularRadius)),
                                ),
                                child: Column(
                                  children: [
                                    Text(month['id'].toString(),
                                        style: CustomTextStyles(widget.dataObject.theme)
                                            .holdingValueStyle
                                            .copyWith(
                                                color: month == selectedMonth
                                                    ? UserThemes(widget.dataObject.theme).textColor
                                                    : UserThemes(widget.dataObject.theme).textColorVarient)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          month['exTotal'] == 0
                                              ? Container()
                                              : Padding(
                                                  padding: EdgeInsets.only(right: 10.0),
                                                  child: CircleAvatar(
                                                    backgroundColor: UserThemes(widget.dataObject.theme)
                                                        .purpleVarient
                                                        .withOpacity(month['exTotal'] == 0 ? .0 : .8),
                                                    radius: 4,
                                                  ),
                                                ),
                                          month['divTotal'] == 0
                                              ? Container()
                                              : Padding(
                                                  padding: EdgeInsets.only(right: 10.0),
                                                  child: CircleAvatar(
                                                    backgroundColor: UserThemes(widget.dataObject.theme)
                                                        .goldVarient
                                                        .withOpacity(month['divTotal'] == 0 ? .0 : .8),
                                                    radius: 4,
                                                  ),
                                                ),
                                          month['earnTotal'] == 0
                                              ? Container()
                                              : CircleAvatar(
                                                  backgroundColor: UserThemes(widget.dataObject.theme)
                                                      .blueVarient
                                                      .withOpacity(month['earnTotal'] == 0 ? .0 : .8),
                                                  radius: 4,
                                                ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Divider(
                                  thickness: .8,
                                  color: UserThemes(widget.dataObject.theme).seperator.withOpacity(.2)),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(widget.dataObject.context),
                  customBorder:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(Units().circularRadius)),
                  child: Ink(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                        color: UserThemes(widget.dataObject.theme).summaryColour,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Units().circularRadius * 2),
                            topRight: Radius.circular(Units().circularRadius * 2))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CANCEL',
                          style: CustomTextStyles(widget.dataObject.theme).holdingValueStyle,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      );
    }

    return FutureBuilder<bool>(
      future: isLoaded
          ? Future.value(true)
          : widget.dataObject.userFire.isAnonymous
              ? Future(() {
                  isLoaded = true;
                  return Future.value(true);
                })
              : init(),
      builder: (context, snapshot) {
        // if (isLoaded) {
          return CWScaffold(
            dataObject: widget.dataObject,
            bottomAppBarBorderColour: false,
            appBarTitleWidget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    selectedMonth =
                        months[selectedMonth['index'] == 1 ? 11 : months.indexOf(selectedMonth) - 1];

                    setState(() {});
                  },
                  customBorder:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(Units().circularRadius)),
                  child: Icon(
                    Icons.chevron_left,
                    size: Units().calenderIconSize,
                    color: UserThemes(widget.dataObject.theme).iconColour,
                  ),
                ),
                InkWell(
                  onTap: () => viewMonths(),
                  customBorder:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(Units().circularRadius)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '${selectedMonth['id']} ${DateTime.now().year}',
                      style: CustomTextStyles(widget.dataObject.theme).calenderTitleTextStyle,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    selectedMonth =
                        months[selectedMonth['index'] == 12 ? 0 : months.indexOf(selectedMonth) + 1];

                    setState(() {});
                  },
                  customBorder:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(Units().circularRadius)),
                  child: Icon(
                    Icons.chevron_right,
                    size: Units().calenderIconSize,
                    color: UserThemes(widget.dataObject.theme).iconColour,
                  ),
                ),
              ],
            ),
            body: widget.dataObject.userFire.isAnonymous
                ? Restricted(dataObject: widget.dataObject)
                : isLoaded == false? Column(
                  main
                  children: [
                    Loading(theme: true,),
                  ],
                ) : CWListView(
                    centerWidget: selectedMonth['events'].isEmpty
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                  child: Image.asset(
                                'assets/icons/empty.png',
                                width: 40,
                                height: 40,
                                color: UserThemes(widget.dataObject.theme).textColorVarient,
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${selectedMonth['id']} - No Events Listed',
                                style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                              )
                            ],
                          ))
                        : null,
                    children: List.generate(selectedMonth['groupedEvents'].length + 1,
                            (index) => index == 0 ? Container() : selectedMonth['groupedEvents'][index - 1])
                        .map<Widget>((groupedEvent) {
                      return groupedEvent.runtimeType == Container
                          ? Container(
                              padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                              decoration:
                                  CustomDecoration(widget.dataObject.theme, false).topWidgetDecoration,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Updated on: ${CustomDateFormatter().formatDateStyle(DateTime.parse(widget.dataObject.lastCalenderUpdate).toString())}',
                                    style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                                  ),
                                  InkWell(
                                      onTap: () => setState(() {
                                            widget.dataObject.lastCalenderUpdate = '';
                                            isLoaded = false;
                                          }),
                                      child: Icon(
                                        Icons.refresh,
                                        size: Units().iconSize,
                                        color: UserThemes(widget.dataObject.theme).iconColour,
                                      ))
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '${CustomDateFormatter().weekdaysFull[(DateTime.parse(groupedEvent['date']).weekday - 1)].toString()} - ${CustomDateFormatter().formatDateStyle(DateTime.parse(groupedEvent['date']).toString())}',
                                          style:
                                              CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.symmetric(
                                          horizontal: BorderSide(
                                              color: UserThemes(widget.dataObject.theme).seperator,
                                              width: 1)),
                                      color: UserThemes(widget.dataObject.theme).summaryColour),
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                  child: Column(
                                    children: groupedEvent['events']
                                        .map<Widget>((event) => Column(children: [
                                              getEventType(event),
                                              groupedEvent['events'].last == event
                                                  ? Container()
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5.0, right: 5, top: 15, bottom: 15),
                                                      child: Divider(
                                                        thickness: .8,
                                                        color: UserThemes(widget.dataObject.theme).seperator,
                                                      ),
                                                    )
                                            ]))
                                        .toList(),
                                  ),
                                ),
                              ],
                            );
                    }).toList(),
                  ),
          );
        // } else {
        //   return Loading(theme: true,);
        // }
      },
    );
  }

  List divMonths = [];

  monthReset() {
    for (var month in months) {
      month['events'] = [];
    }
  }

  Widget getEventType(dynamic event) {
    // print(event);
    if (event.runtimeType == Earnings) {
      return EarningsWidget(
        dataObject: widget.dataObject,
        earnigns: event,
      );
    } else if (event.runtimeType == Dividends || event.runtimeType == ExDividends) {
      return DividendsWidget(
        dataObject: widget.dataObject,
        dividend: event,
      );
    } else {
      return Text('0');
    }
  }

  setMonthsEvents() {
    for (var dividend in widget.dataObject.dividends) {
      var eventMonthExDate = months
          .firstWhere((month) => month['index'] == DateTime.parse(dividend.exDate).month, orElse: () => null);
      var eventMonthPaymentDate = months
          .firstWhere((month) => month['index'] == DateTime.parse(dividend.date).month, orElse: () => null);

      if (eventMonthPaymentDate != null && eventMonthExDate != null) {
        var exDividend = ExDividends();

        exDividend.date = dividend.exDate;
        exDividend.yield = dividend.yield;
        exDividend.amount = dividend.amount;
        exDividend.dividendType = 'ex';
        exDividend.symbol = dividend.symbol;
        exDividend.exchange = dividend.exchange;
        exDividend.name = dividend.name;

        eventMonthExDate['events'].add(exDividend);
        eventMonthPaymentDate['events'].add(dividend);

        eventMonthPaymentDate['divTotal']++;
        eventMonthExDate['exTotal']++;
      }
    }

    for (var earning in widget.dataObject.earnings) {
      var eventMonthEarning = months
          .firstWhere((month) => month['index'] == DateTime.parse(earning.date).month, orElse: () => null);

      if (eventMonthEarning != null) {
        eventMonthEarning['events'].add(earning);
        eventMonthEarning['earnTotal']++;
      }
    }

    for (var month in months) {
      month['groupedEvents'] = [];

      for (var event in month['events']) {
        var groupedEventDate = month['groupedEvents'].firstWhere(
            (grouped) => DateTime.parse(grouped['date']) == DateTime.parse(event.date),
            orElse: () => null);

        if (groupedEventDate == null) {
          month['groupedEvents'].add({
            'date': event.date,
            'events': [event]
          });
        } else {
          groupedEventDate['events'].add(event);
        }
      }
    }

    selectedMonth['events'].sort((a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
  }

  getDividends() async {
    widget.dataObject.dividends = await Marketbeat().getDividends(widget.dataObject.holdings
        .where((holding) => ((holding['marketData']['quote'].containsKey('trailingAnnualDividendYield') &&
                holding['marketData']['quote']['trailingAnnualDividendYield'] != 0) ||
            (holding['marketData']['quote'].containsKey('trailingAnnualDividendRate') &&
                holding['marketData']['quote']['trailingAnnualDividendRate'] != 0) ||
            (holding['marketData']['quote'].containsKey('dividendDate') &&
                holding['marketData']['quote']['dividendDate'] != '')))
        .toList());
    // .then((value) async => await LocalDataSet().updateLocalData(widget.dataObject));
    // print(widget.dataObject.dividends);

    // LocalDataSet().updateLocalData(widget.dataObject);
  }

  getEarning() async {
    widget.dataObject.earnings = await YahooApiService().getYahooCalenderEvents(widget.dataObject.holdings);
    print(widget.dataObject.earnings.length);
  }
}

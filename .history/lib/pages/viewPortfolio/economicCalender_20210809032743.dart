import 'package:Strice/services/financialmodelingprep/FinancialModelingPrep.dart';
import 'package:Strice/shared/update/update.dart';
import 'package:flutter/material.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/Custome_Widgets/loading/loading.dart';
import 'dart:ui';
import 'package:Strice/extensions/stringExt.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class FinancialCalender extends StatefulWidget {
  FinancialCalender({Key key}) : super(key: key);

  @override
  _FinancialCalender createState() => _FinancialCalender();
}

class _FinancialCalender extends State<FinancialCalender> {
  ScrollController _mainController = ScrollController();
  ScrollController _subController = ScrollController();

  Map data = {};
  String baseCurrency, currencySymbol;

  List<Map> months = [
    {'id': "January", 'dividends': [], 'isSelected': false, 'status': false, 'index': 1, 'totalPayment': 0},
    {'id': "February", 'dividends': [], 'isSelected': false, 'status': false, 'index': 2, 'totalPayment': 0},
    {'id': "March", 'dividends': [], 'isSelected': false, 'status': false, 'index': 3, 'totalPayment': 0},
    {'id': "April", 'dividends': [], 'isSelected': false, 'status': false, 'index': 4, 'totalPayment': 0},
    {'id': "May", 'dividends': [], 'isSelected': false, 'status': false, 'index': 5, 'totalPayment': 0},
    {'id': "June", 'dividends': [], 'isSelected': false, 'status': false, 'index': 6, 'totalPayment': 0},
    {'id': "July", 'dividends': [], 'isSelected': false, 'status': false, 'index': 7, 'totalPayment': 0},
    {'id': "August", 'dividends': [], 'isSelected': false, 'status': false, 'index': 8, 'totalPayment': 0},
    {'id': "September", 'dividends': [], 'isSelected': false, 'status': false, 'index': 9, 'totalPayment': 0},
    {'id': "October", 'dividends': [], 'isSelected': false, 'status': false, 'index': 10, 'totalPayment': 0},
    {'id': "November", 'dividends': [], 'isSelected': false, 'status': false, 'index': 11, 'totalPayment': 0},
    {'id': "December", 'dividends': [], 'isSelected': false, 'status': false, 'index': 12, 'totalPayment': 0}
  ];
  List events = [
    {
      "paymentDate": "2020-09-02",
      "label": "September 02, 20",
      "totalPayment": 0.02,
      "symbol": "BOL.PA",
      'name': 'dsdadads',
      'shares': 100
    },
    {
      "paymentDate": "2020-08-20",
      "label": "September 02, 20",
      "totalPayment": 0.02,
      "symbol": "BOL.PA",
      'name': 'dsdadads',
      'shares': 202
    },
    {
      "paymentDate": "2020-05-12",
      "label": "September 02, 20",
      "totalPayment": 0.02,
      "symbol": "BOL.PA",
      'name': 'dsdadads',
      'shares': 63
    },
    {
      "paymentDate": "2020-07-22",
      "label": "September 02, 20",
      "totalPayment": 0.02,
      "symbol": "BOL.PA",
      'name': 'dsdadads',
      'shares': 22
    },
    {
      "paymentDate": "2020-01-17",
      "label": "September 01, 20",
      "totalPayment": 0.47,
      "symbol": "WKL.AS",
      'name': 'dsdadads',
      'shares': 2333
    },
    {
      "paymentDate": "2020-02-07",
      "label": "September 01, 20",
      "totalPayment": 0.47,
      "symbol": "WKL.AS",
      'name': 'dsdadads',
      'shares': 243
    },
    {
      "paymentDate": "2020-03-19",
      "label": "September 01, 20",
      "totalPayment": 0.002809,
      "symbol": "ITUB",
      'name': 'dsdadads',
      'shares': 33
    },
    {
      "paymentDate": "2020-09-06",
      "label": "September 01, 20",
      "totalPayment": 0.05,
      "symbol": "FEI",
      'name': 'dsdadads',
      'shares': 238
    }
  ];
  List weekdays = ['Monday', 'Tuesday', 'Wenesday', 'Thursday', 'Firday', 'Saturday', 'Sunday'];

  double ratio;

  bool isLoaded = false;

  String isDark = 'Midnight Blue';

  TextStyle headStyle, subStyle;

  @override
  void dispose() {
    if (!mounted) return;
    super.dispose();
  }

  ScrollController _mainScrollController = ScrollController();
  ScrollController _subScrollController = ScrollController();

  double _removableWidgetSize = 200;
  bool _isStickyOnTop = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ratio = (window.physicalSize.height / window.physicalSize.width);
    _mainScrollController.addListener(() {
      if (_mainScrollController.offset >= _removableWidgetSize && !_isStickyOnTop) {
        _isStickyOnTop = true;
        setState(() {});
      } else if (_mainScrollController.offset < _removableWidgetSize && _isStickyOnTop) {
        _isStickyOnTop = false;
        setState(() {});
      }
    });
  }

  initializeData() {
    baseCurrency = 'USD'; //data['portfolio']['baseCurrency'];

    // print(baseCurrency);

    currencySymbol = Update(baseCurrency).getCurrencySymbol()['symbol'];
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    // isDark = (data['data']['data']['states']['states']['dark']);
    initializeData();
    getDividendsBeta();

    headStyle = TextStyle(
      color: DarkTheme(isDark).textColorVarient,
      fontSize: 15,
      fontWeight: FontWeight.w400,
    );
    subStyle = TextStyle(color: DarkTheme(isDark).textColor, fontWeight: FontWeight.w600, fontSize: 20);

    return Container(
      color: DarkTheme(isDark).summaryColour,
      child: SafeArea(
          child: Scaffold(
              backgroundColor: DarkTheme(isDark).backgroundColour,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight * 0.8),
                child: AppBar(
                  iconTheme: IconThemeData(
                    color: DarkTheme(isDark).backColour, //change your color here
                  ),
                  elevation: 0,
                  backgroundColor: DarkTheme(isDark).summaryColour,
                  centerTitle: true,
                  title: Text('Dividends', style: TextStyle(color: DarkTheme(isDark).textColorVarient)),
                ),
              ),
              body: CustomScrollView(
                  slivers: months
                      .map((month) => SliverStickyHeader(
                            header: Container(
                              height: 60.0,
                              color: DarkTheme(isDark).backgroundColour,
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text(
                                    '${month['id']} ${DateTime.now().year}',
                                    style: TextStyle(color: DarkTheme(isDark).textColor, fontSize: 20),
                                  ),

                                  Text('Dividends: ${month['dividends'].length.toString()} totalPayment: ${month['totalPay']}', style: TextStyle(color: DarkTheme(isDark).textColorVarient),),
                                ],
                              ),
                            ),
                            sliver: SliverList(
                                delegate: SliverChildListDelegate.fixed(month['dividends']
                                    .map<Widget>((dividend) => Ink(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 10.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(right: 10.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        weekdays[DateTime.parse(dividend['paymentDate'])
                                                                    .weekday -
                                                                1]
                                                            .toString()
                                                            .capitalizeAll()
                                                            .replaceRange(
                                                                3,
                                                                weekdays[DateTime.parse(
                                                                                dividend['paymentDate'])
                                                                            .weekday -
                                                                        1]
                                                                    .toString()
                                                                    .length,
                                                                ''),
                                                        style: TextStyle(
                                                            color: DarkTheme(isDark).textColorVarient),
                                                      ),
                                                      Text(
                                                        DateTime.parse(dividend['paymentDate'])
                                                            .day
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: DarkTheme(isDark).textColor, fontSize: 25),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: InkWell(
                                                    customBorder: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                    onTap: () {},
                                                    child: Ink(
                                                      decoration: BoxDecoration(
                                                          color: DarkTheme(isDark).summaryColour,
                                                          borderRadius: BorderRadius.circular(5)),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(10.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons.monetization_on,
                                                                      color: DarkTheme(isDark).goldVarient,
                                                                      size: 20,
                                                                    ),
                                                                    SizedBox(width: 5),
                                                                    Text(
                                                                      'Dividend',
                                                                      style: TextStyle(
                                                                        color: DarkTheme(isDark).goldVarient,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.symmetric(
                                                                      vertical: 5.0),
                                                                  child: Text(dividend['symbol'],
                                                                      style: TextStyle(
                                                                          color: DarkTheme(isDark).textColor,
                                                                          fontSize: 20)),
                                                                ),
                                                                Text(dividend['name'],
                                                                    style: TextStyle(
                                                                        color: DarkTheme(isDark)
                                                                            .textColorVarient))
                                                              ],
                                                            ),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      currencySymbol,
                                                                      style: TextStyle(
                                                                          color:
                                                                              DarkTheme(isDark).goldVarient,
                                                                          fontSize: 20),
                                                                    ),
                                                                    Text(
                                                                        (dividend['totalPayment'] *
                                                                                dividend['shares'])
                                                                            .toStringAsFixed(2),
                                                                        style: TextStyle(
                                                                            color:
                                                                                DarkTheme(isDark).goldVarient,
                                                                            fontSize: 25)),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  '${dividend['shares']} x ${dividend['totalPayment']}',
                                                                  style: TextStyle(
                                                                      color:
                                                                          DarkTheme(isDark).textColorVarient),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ))
                                    .toList())),
                          ))
                      .toList()
                  // SliverStickyHeader(
                  //   header: Container(
                  //     height: 60.0,
                  //     color: Colors.lightBlue,
                  //     padding: EdgeInsets.symmetric(horizontal: 16.0),
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       'Header #0',
                  //       style: const TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  //   sliver: SliverList(
                  //     delegate: SliverChildBuilderDelegate(
                  //       (context, i) => ListTile(
                  //         leading: CircleAvatar(
                  //           child: Text('0'),
                  //         ),
                  //         title: Text('List tile #$i'),
                  //       ),
                  //       childCount: 100,
                  //     ),
                  //   ),
                  // ),

                  ))),
    );
  }

  Container _getStickyWidget() {
    return Container(
      alignment: Alignment.center,
      height: 80,
      color: Colors.green,
      child: Text(
        'sticky sub header'.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  List divMonths = [];

  getDividendsBeta() {
    for (Map dividend in events) {
      var month = months.firstWhere(
          (month) => months[DateTime.parse(dividend['paymentDate']).month - 1]['id'] == month['id']);

      month['dividends'].add(dividend);
      month['totalPayment'] += dividend['totalPayment'];
    }
  }

  Future<bool> getDividends() async {
    events = await FinancialModelingPrep().getDividends(data['dividends']);
    divMonths.clear();

    // print(events);
    List removeIndex = [];

    for (var event in events) {
      event.forEach((key, value) {
        if (value == null) {
          removeIndex.add(events.indexOf(event));
        }
      });
    }

    // print(removeIndex.length);
    // print(events.length);

    for (var index in removeIndex) {
      events.removeWhere((element) => events.indexOf(element) == index);
    }

    // print(events.length);

    try {
      for (var event in events) {
        if (divMonths.isEmpty) {
          divMonths.add({
            'month': months[DateTime.parse(event['paymentDate']).month - 1]['id'],
            'payment': event['totalPayment'],
            'dividends': [event],
            'index': months[DateTime.parse(event['paymentDate']).month - 1]['index']
          });
        } else {
          var isMonthExist = divMonths.firstWhere(
              (d) => d['month'] == months[DateTime.parse(event['paymentDate']).month - 1]['id'],
              orElse: () => null);

          if (isMonthExist == null) {
            divMonths.add({
              'month': months[DateTime.parse(event['paymentDate']).month - 1]['id'],
              'payment': event['totalPayment'],
              'dividends': [event],
              'index': months[DateTime.parse(event['paymentDate']).month - 1]['index']
            });
          } else {
            isMonthExist['payment'] += event['totalPayment'];
            isMonthExist['dividends'].add(event);
          }
        }
      }
    } catch (e) {
      print(e);
    }

    divMonths.sort((a, b) => a['index'].compareTo(b['index']));

    divMonths.forEach((div) => div['dividends']
        .sort((a, b) => DateTime.parse(a['paymentDate']).compareTo(DateTime.parse(b['paymentDate']))));

    return Future.value(true);
  }
}

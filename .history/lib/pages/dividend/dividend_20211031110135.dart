import 'package:flutter/material.dart';
import 'package:Strice/services/financialmodelingprep/FinancialModelingPrep.dart';
import 'package:Strice/shared/update/marketUpdate.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/Custome_Widgets/loading/loading.dart';
import 'dart:ui';
import 'package:Strice/extensions/stringExt.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class Dividends extends StatefulWidget {
  Dividends({Key key}) : super(key: key);

  @override
  _DividendsState createState() => _DividendsState();
}

class _DividendsState extends State<Dividends> {
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
      "paymentDate": "2020-09-22",
      "label": "September 02, 20",
      "totalPayment": 0.02,
      "symbol": "BOL.PA",
      'name': 'dsdadads',
      'shares': 100
    },
    {
      "paymentDate": "2020-09-12",
      "label": "September 02, 20",
      "totalPayment": 0.02,
      "symbol": "BOL.PA",
      'name': 'dsdadads',
      'shares': 100
    },
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
      "paymentDate": "2020-07-12",
      "label": "September 02, 20",
      "totalPayment": 0.02,
      "symbol": "BOL.PA",
      'name': 'dsdadads',
      'shares': 63
    },
    {
      "paymentDate": "2020-12-12",
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

  var isDark = false;

  TextStyle headStyle, subStyle;

  get status => 'CLOSED';

  @override
  void dispose() {
    if (!mounted) return;
    super.dispose();
  }

  ScrollController _mainScrollController = ScrollController();
  ScrollController _subScrollController = ScrollController();

  double _removableWidgetSize = 200;
  bool _isStickyOnTop = false;

  Map data = {};
  String baseCurrency, currencySymbol;

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

    currencySymbol = MarketUpdate(baseCurrency).getCurrencySymbol()['symbol'];
  }

  List divMonths = [];

  getDividendsBeta() {
    for (Map dividend in events) {
      var month = months.firstWhere(
          (month) => months[DateTime.parse(dividend['paymentDate']).month - 1]['id'] == month['id']);

      month['dividends'].add(dividend);
      month['totalPayment'] += dividend['totalPayment'] * dividend['shares'];
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeData();
    getDividendsBeta();

     headStyle = TextStyle(
      color: UserThemes(isDark).textColorVarient,
      fontSize: 15,
      fontWeight: FontWeight.w400,
    );
    subStyle = TextStyle(color: UserThemes(isDark).textColor, fontWeight: FontWeight.w600, fontSize: 20);
  
return Container(
      color: UserThemes(isDark).backgroundColour,
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: UserThemes(isDark).iconColour),
                centerTitle: true,
                elevation: 0,
                backgroundColor: UserThemes(isDark).backgroundColour,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dividends', style: TextStyle(color: UserThemes(isDark).textColor, fontSize: 20)),
                    Icon(Icons.settings, color: UserThemes(isDark).iconColour)
                  ],
                ),
              ),
              backgroundColor: UserThemes(isDark).backgroundColour,
              resizeToAvoidBottomInset: true,
              body: ListView(
                children: [
                  CustomScrollView(
                      // reverse: true,
                      //  shrinkWrap: true,
                      slivers: months
                          // .where(
                          //         (month) => month['totalPayemnt'] != 0 && month['index'] >= DateTime.now().month))
                          .map((month) => SliverStickyHeader(
                                header: Container(
                                  height: 60.0,
                                  color: UserThemes(isDark).backgroundColour,
                                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    
                                    children: [
                                      Text(
                                        '${month['id']}, ${DateTime.now().year}  ',
                                        style: TextStyle(
                                            color: month['totalPayment'] == 0 ||
                                                    month['index'] < DateTime.now().month
                                                ? UserThemes(isDark).textColorVarient
                                                : UserThemes(isDark).textColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),

                                      Flexible(
                                        child: DottedLine(
                                          direction: Axis.horizontal,
                                          lineLength: double.infinity,
                                          lineThickness: 1.0,
                                          dashLength: 4.0,
                                          dashColor: UserThemes(isDark).border,
                                          dashRadius: 0.0,
                                          dashGapLength: 4.0,
                                          dashGapColor: Colors.transparent,
                                          dashGapRadius: 0.0,
                                        ),
                                      ),

                                      Text(
                                        '$currencySymbol${month['totalPayment']}',
                                        style: TextStyle(
                                            color: month['totalPayment'] == 0 ||
                                                    month['index'] < DateTime.now().month
                                                ? UserThemes(isDark).textColorVarient
                                                : UserThemes(isDark).textColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25),
                                      ),

                                      // Text('Total: ${month['totalPayment']}', style: TextStyle(color: UserThemes(isDark).textColorVarient, fontSize: 17),),
                                    ],
                                  ),
                                ),
                                sliver: SliverList(
                                    delegate: SliverChildListDelegate.fixed(month['dividends']
                                        .map<Widget>((dividend) => Ink(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                                              color: UserThemes(isDark).textColorVarient),
                                                        ),
                                                        Text(
                                                          DateTime.parse(dividend['paymentDate'])
                                                              .day
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: UserThemes(isDark).textColor, fontSize: 25),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          ' Ex-Date 12, Jun, 2021   ',
                                                          style: TextStyle(
                                                              color: UserThemes(isDark).textColorVarient,
                                                              fontStyle: FontStyle.italic),
                                                        ),
                                                        InkWell(
                                                          customBorder: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(5),
                                                          ),
                                                          onTap: () {},
                                                          child: Card(
                                                            elevation: 0,

                                                            color: UserThemes(isDark).summaryColour,
                                                            // decoration: BoxDecoration(
                                                            //   borderRadius: BorderRadius.circular(5),
                                                            //   // border: Border.all(color: UserThemes(isDark).border),
                                                            // ),
                                                            child: Padding(
                                                              padding: EdgeInsets.all(10.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.monetization_on,
                                                                            color:
                                                                                UserThemes(isDark).goldVarient,
                                                                            size: 20,
                                                                          ),
                                                                          SizedBox(width: 5),
                                                                          Text(
                                                                            'Dividend',
                                                                            style: TextStyle(
                                                                              color:
                                                                                  UserThemes(isDark).goldVarient,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            vertical: 5.0),
                                                                        child: Text(dividend['symbol'],
                                                                            style: TextStyle(
                                                                                color:
                                                                                    UserThemes(isDark).textColor,
                                                                                fontSize: 20)),
                                                                      ),
                                                                      Text(dividend['name'],
                                                                          style: TextStyle(
                                                                              color: UserThemes(isDark)
                                                                                  .textColorVarient,
                                                                              fontStyle: FontStyle.italic))
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
                                                                                color: UserThemes(isDark)
                                                                                    .goldVarient,
                                                                                fontSize: 20),
                                                                          ),
                                                                          Text(
                                                                              (dividend['totalPayment'] *
                                                                                      dividend['shares'])
                                                                                  .toStringAsFixed(2),
                                                                              style: TextStyle(
                                                                                  color: UserThemes(isDark)
                                                                                      .goldVarient,
                                                                                  fontSize: 25)),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        '${dividend['shares']} x $currencySymbol${dividend['totalPayment']}',
                                                                        style: TextStyle(
                                                                            color: UserThemes(isDark)
                                                                                .textColorVarient,
                                                                            fontStyle: FontStyle.italic),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ))
                                        .toList())),
                              ))
                          .toList()),
                ],
              ))),
    );
  
  }
}

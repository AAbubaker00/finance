import 'package:Strice/pages/viewPortfolio/viewDividend.dart';
import 'package:Strice/services/financialmodelingprep/FinancialModelingPrep.dart';
import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/decoration/customDecoration.dart';
import 'package:Strice/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Strice/shared/units/units.dart';
import 'package:Strice/shared/update/marketUpdate.dart';
import 'package:flutter/material.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/Custome_Widgets/loading/loading.dart';
import 'dart:ui';
import 'package:Strice/extensions/stringExt.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class Dividends extends StatefulWidget {
  Dividends({Key key}) : super(key: key);

  @override
  _Dividends createState() => _Dividends();
}

class _Dividends extends State<Dividends> {
  Map data = {};
  String baseCurrency, currencySymbol;

  List<Map> months = [
    {
      'id': "January",
      'dividends': [],
      'isSelected': false,
      'status': false,
      'index': 1,
      'totalPayment': 0,
      'events': 0
    },
    {
      'id': "February",
      'dividends': [],
      'isSelected': false,
      'status': false,
      'index': 2,
      'totalPayment': 0,
      'events': 0
    },
    {
      'id': "March",
      'dividends': [],
      'isSelected': false,
      'status': false,
      'index': 3,
      'totalPayment': 0,
      'events': 0
    },
    {
      'id': "April",
      'dividends': [],
      'isSelected': false,
      'status': false,
      'index': 4,
      'totalPayment': 0,
      'events': 0
    },
    {
      'id': "May",
      'dividends': [],
      'isSelected': false,
      'status': false,
      'index': 5,
      'totalPayment': 0,
      'events': 0
    },
    {
      'id': "June",
      'dividends': [],
      'isSelected': false,
      'status': false,
      'index': 6,
      'totalPayment': 0,
      'events': 0
    },
    {
      'id': "July",
      'dividends': [],
      'isSelected': false,
      'status': false,
      'index': 7,
      'totalPayment': 0,
      'events': 0
    },
    {
      'id': "August",
      'dividends': [],
      'isSelected': false,
      'status': false,
      'index': 8,
      'totalPayment': 0,
      'events': 0
    },
    {
      'id': "September",
      'dividends': [],
      'isSelected': false,
      'status': false,
      'index': 9,
      'totalPayment': 0,
      'events': 0
    },
    {
      'id': "October",
      'dividends': [],
      'isSelected': false,
      'status': false,
      'index': 10,
      'totalPayment': 0,
      'events': 0
    },
    {
      'id': "November",
      'dividends': [],
      'isSelected': false,
      'status': false,
      'index': 11,
      'totalPayment': 0,
      'events': 0
    },
    {
      'id': "December",
      'dividends': [],
      'isSelected': false,
      'status': false,
      'index': 12,
      'totalPayment': 0,
      'events': 0
    }
  ];
  List events = [
    {
      "paymentDate": "2020-11-22",
      "label": "September 02, 20",
      "totalPayment": 0.02,
      "symbol": "BOL.PA",
      'name': 'dsdadads',
      'shares': 100
    },
    {
      "paymentDate": "2020-11-12",
      "label": "September 02, 20",
      "totalPayment": 0.02,
      "symbol": "BOL.PA",
      'name': 'dsdadads',
      'shares': 100
    },
    {
      "paymentDate": "2020-08-02",
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
      "paymentDate": "2020-01-12",
      "label": "September 02, 20",
      "totalPayment": 0.02,
      "symbol": "BOL.PA",
      'name': 'dsdadads',
      'shares': 63
    },
    {
      "paymentDate": "2020-01-12",
      "label": "September 02, 20",
      "totalPayment": 0.02,
      "symbol": "BOL.PA",
      'name': 'dsdadads',
      'shares': 63
    },
    {
      "paymentDate": "2020-08-12",
      "label": "September 02, 20",
      "totalPayment": 0.02,
      "symbol": "BOL.PA",
      'name': 'dsdadads',
      'shares': 63
    },
    {
      "paymentDate": "2020-12-22",
      "label": "September 02, 20",
      "totalPayment": 0.02,
      "symbol": "BOL.PA",
      'name': 'dsdadads',
      'shares': 22
    },
    {
      "paymentDate": "2020-12-17",
      "label": "September 01, 20",
      "totalPayment": 0.47,
      "symbol": "WKL.AS",
      'name': 'dsdadads',
      'shares': 2333
    },
    {
      "paymentDate": "2020-12-07",
      "label": "September 01, 20",
      "totalPayment": 0.47,
      "symbol": "WKL.AS",
      'name': 'dsdadads',
      'shares': 243
    },
    {
      "paymentDate": "2020-10-19",
      "label": "September 01, 20",
      "totalPayment": 0.002809,
      "symbol": "ITUB",
      'name': 'dsdadads',
      'shares': 33
    },
    {
      "paymentDate": "2020-10-06",
      "label": "September 01, 20",
      "totalPayment": 0.05,
      "symbol": "FEI",
      'name': 'dsdadads',
      'shares': 238
    }
  ];
  List weekdays = ['Monday', 'Tuesday', 'Wenesday', 'Thursday', 'Firday', 'Saturday', 'Sunday'];
  List<String> sortOptions = ['Investment', 'Return', 'Buy Date', 'Shares', 'A-Z'];
  get status => 'CLOSED';

  @override
  void dispose() {
    if (!mounted) return;
    super.dispose();
  }

  Map selectedMonth = {};


  String selectedPortfolio = '', inceptionDate = '';

  double ratio;

  bool isLoaded = false;

  var themeMode = true;


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

    selectedMonth = months[DateTime.now().month - 1];

  }

  initializeData() {
    baseCurrency = 'USD'; //data['portfolio']['baseCurrency'];

    // print(baseCurrency);

    currencySymbol = MarketUpdate(baseCurrency).getCurrencySymbol()['symbol'];
  }

  @override
  Widget build(BuildContext context) {
    // data = ModalRoute.of(context).settings.arguments;
    // print(data['states']);
    // themeMode = (data['states']['theme']);

    initializeData();
    getDividendsBeta();

    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics: BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding:
                EdgeInsets.only(left: 10, bottom: 15, right: 10, top: Size.fromHeight(kToolbarHeight).height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("What's coming?", style: CustomTextStyles(themeMode).sectionSubTextStyle),
                Text('Calender', style: CustomTextStyles(themeMode).pageHeaderStyle)
              ],
            ),
          ),
          Column(
            children: months.where((month) => month['dividends'].length >= 1).toList().map((month) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: Units().mainSpacing,
                ),
                child: Container(
                  decoration: CustomDecoration(themeMode, true).baseContainerDecoration,
                  padding: EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 10, left: 5),
                          child: Text(month['id'], style: CustomTextStyles(themeMode).sectionHeader)),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: month['dividends'].map<Widget>((dividend) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 5),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 10),
                                      Text('Dividend',
                                          style: CustomTextStyles(themeMode).holdingSubValueStyle),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Icon(
                                          Icons.arrow_right_rounded,
                                          color: UserThemes(themeMode).textColorVarient,
                                        ),
                                      ),
                                      Text(
                                          '${DateTime.parse(dividend['paymentDate']).day.toString()} ${months[DateTime.parse(dividend['paymentDate']).month - 1]['id']} ${DateTime.parse(dividend['paymentDate']).year.toString()}',
                                          style: CustomTextStyles(themeMode).feedDateStyle),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Units().circularRadius),
                                  ),
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewDividend(dividend),
                                      )),
                                  child: Ink(
                                    padding: EdgeInsets.all(20),
                                    decoration: CustomDecoration(themeMode, false).baseContainerDecoration,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(dividend['name'],
                                            style: CustomTextStyles(themeMode).sectionHeader),
                                        Text(
                                            '+$currencySymbol${(dividend['totalPayment'] * dividend['shares']).toStringAsFixed(2)}',
                                            style: CustomTextStyles(themeMode).sectionHeader)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          )
        ]),
      ),
    );
  }

  Widget _monthsPopUpMenu() => PopupMenuButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: UserThemes(themeMode).backgroundColour,
        elevation: 8,
        offset: Offset(0, 30),
        onSelected: (value) {
          print(value);
          // selectedSortOption = sortOptions[int.parse(value)];

          String s;

          selectedMonth = months[(int.parse(value))];

          setState(() {});

          // isSortLoaded = false;
          // setSort();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedMonth['id'],
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w400, color: UserThemes(themeMode).textColor),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.expand_more,
              color: UserThemes(themeMode).iconColour,
              size: 20,
            ),
          ],
        ),
        itemBuilder: (context) => (months.where((month) => month['index'] >= DateTime.now().month).toList())
            .map<PopupMenuItem>((month) => PopupMenuItem(
                  value: months.indexOf(month).toString(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        month['id'],
                        style: TextStyle(
                            color: selectedMonth == month
                                ? UserThemes(themeMode).textColor
                                : UserThemes(themeMode).textColorVarient,
                            fontWeight: selectedMonth == month ? FontWeight.w600 : FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: UserThemes(themeMode).summaryColour,
                          child: Text(
                            month['events'].toString(),
                            style: TextStyle(
                                fontSize: 12,
                                color: UserThemes(themeMode).goldVarient,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
            .toList(),
      );

  Widget _sortPopupMenu() => PopupMenuButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: UserThemes(themeMode).backgroundColour,
        elevation: 8,
        offset: Offset(0, 30),
        onSelected: (value) {
          selectedPortfolio = sortOptions[int.parse(value)];

          setState(() {});

          // isSortLoaded = false;
          // setSort();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedPortfolio,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w400, color: UserThemes(themeMode).textColor),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.expand_more,
              color: UserThemes(themeMode).iconColour,
              size: 20,
            ),
          ],
        ),
        itemBuilder: (context) => sortOptions.map<PopupMenuItem<String>>((String option) {
          return PopupMenuItem(
            value: sortOptions.indexOf(option).toString(),
            child: Text(
              option,
              style: TextStyle(
                  color: selectedPortfolio == option
                      ? UserThemes(themeMode).textColor
                      : UserThemes(themeMode).textColorVarient,
                  fontWeight: selectedPortfolio == option ? FontWeight.w600 : FontWeight.w400),
            ),
          );
        }).toList(),
      );

  List divMonths = [];

  getDividendsBeta() {
    divMonths.clear();

    for (var month in months) {
      month['dividends'] = [];
    }

    for (Map dividend in events) {
      var month = months.firstWhere(
          (month) => months[DateTime.parse(dividend['paymentDate']).month - 1]['id'] == month['id'],
          orElse: () => null);

      // month['events']++;
      // month['dividends'] = [dividend];

      if (month['dividends'] == null) {
        month['events']++;
        month['dividends'] = [dividend];
      } else {
        month['dividends'].add(dividend);
      }
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

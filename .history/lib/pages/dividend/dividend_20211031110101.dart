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
    
    return Container(
    );
  }
}
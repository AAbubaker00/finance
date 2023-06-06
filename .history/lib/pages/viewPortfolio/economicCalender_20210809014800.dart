import 'package:Strice/services/financialmodelingprep/FinancialModelingPrep.dart';
import 'package:flutter/material.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/Custome_Widgets/loading/loading.dart';
import 'dart:ui';

class FinancialCalender extends StatefulWidget {
  FinancialCalender({Key key}) : super(key: key);

  @override
  _FinancialCalender createState() => _FinancialCalender();
}

class _FinancialCalender extends State<FinancialCalender> {
  ScrollController _mainController = ScrollController();
  ScrollController _subController = ScrollController();

  Map data = {};

  List months = [
    {'id': "January", 'stocks': [], 'isSelected': false, 'status': false, 'index': 1},
    {'id': "February", 'stocks': [], 'isSelected': false, 'status': false, 'index': 2},
    {'id': "March", 'stocks': [], 'isSelected': false, 'status': false, 'index': 3},
    {'id': "April", 'stocks': [], 'isSelected': false, 'status': false, 'index': 4},
    {'id': "May", 'stocks': [], 'isSelected': false, 'status': false, 'index': 5},
    {'id': "June", 'stocks': [], 'isSelected': false, 'status': false, 'index': 6},
    {'id': "July", 'stocks': [], 'isSelected': false, 'status': false, 'index': 7},
    {'id': "August", 'stocks': [], 'isSelected': false, 'status': false, 'index': 8},
    {'id': "September", 'stocks': [], 'isSelected': false, 'status': false, 'index': 9},
    {'id': "October", 'stocks': [], 'isSelected': false, 'status': false, 'index': 10},
    {'id': "November", 'stocks': [], 'isSelected': false, 'status': false, 'index': 11},
    {'id': "December", 'stocks': [], 'isSelected': false, 'status': false, 'index': 12}
  ];
  List events = [
    {"paymentDate": "2020-09-02", "label": "September 02, 20", "totalPayment": 0.02, "symbol": "BOL.PA"},
    {"paymentDate": "2020-08-02", "label": "September 02, 20", "totalPayment": 0.02, "symbol": "BOL.PA"},
    {"paymentDate": "2020-05-02", "label": "September 02, 20", "totalPayment": 0.02, "symbol": "BOL.PA"},
    {"paymentDate": "2020-07-02", "label": "September 02, 20", "totalPayment": 0.02, "symbol": "BOL.PA"},
    {"paymentDate": "2020-01-01", "label": "September 01, 20", "totalPayment": 0.47, "symbol": "WKL.AS"},
    {"paymentDate": "2020-02-01", "label": "September 01, 20", "totalPayment": 0.47, "symbol": "WKL.AS"},
    {"paymentDate": "2020-03-01", "label": "September 01, 20", "totalPayment": 0.002809, "symbol": "ITUB"},
    {"paymentDate": "2020-09-01", "label": "September 01, 20", "totalPayment": 0.05, "symbol": "FEI"}
  ];

  double ratio;

  bool isLoaded = false;

  String isDark = 'Midnight Blue';


  String baseCurrency = '\$';

  TextStyle headStyle, subStyle;

  @override
  void dispose() {
    if (!mounted) return;
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ratio = (window.physicalSize.height / window.physicalSize.width);
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    // isDark = (data['data']['data']['states']['states']['dark']);

    headStyle = TextStyle(
      color: DarkTheme(isDark).textColorVarient,
      fontSize: 15,
      fontWeight: FontWeight.w400,
    );
    subStyle = TextStyle(color: DarkTheme(isDark).textColor, fontWeight: FontWeight.w600, fontSize: 20);

    return FutureBuilder<bool>(
      future: Future.value(true), //getDividends(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
                body: ListView(
                  padding: EdgeInsets.only(bottom: 10),
                  controller: _mainController,
                  children: divMonths.map((month) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                month['month'],
                                style: TextStyle(
                                    color: DarkTheme(isDark).textColor.withOpacity(.9),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '$baseCurrency${month['payment'].toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: DarkTheme(isDark).textColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        GridView.count(
                          controller: _subController,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          crossAxisCount: (ratio <= 1.6) ? 3 : 1,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          mainAxisSpacing: 10,
                          childAspectRatio: (ratio <= 1.6) ? 1.7 : 3,
                          children: month['dividends'].map<Widget>((event) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Dividend', style: subStyle),
                                    // Icon(Icons.arrow_forward_iosc,
                                    //     color: DarkTheme(isDark).textColorVarient.withOpacity(.9), size: 10),
                                    // SizedBox(
                                    //   width: 5,
                                    // ),
                                    Text(
                                      '${DateTime.parse(event['paymentDate']).day.toString()} ${months[DateTime.parse(event['paymentDate']).month - 1]['id']} ${DateTime.parse(event['paymentDate']).year.toString()}',
                                      style: headStyle.copyWith(
                                          fontSize: 17, color: DarkTheme(isDark).textColor.withOpacity(.6)),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {},
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Ink(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: DarkTheme(isDark).summaryColour,
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                          color: DarkTheme(isDark).border,
                                        )),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Symbol',
                                                  style: headStyle,
                                                ),
                                                Text(
                                                  event['symbol'],
                                                  style: subStyle.copyWith(
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 15),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Final Cost',
                                                  style: headStyle,
                                                ),
                                                Text(
                                                  '$baseCurrency${event['totalPayment'].toStringAsFixed(2)}',
                                                  style: subStyle.copyWith(
                                                      color: DarkTheme(isDark).goldVarient, fontSize: 25),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Dividends',
                                                  style: headStyle,
                                                ),
                                                Text(
                                                  event['adjDividend'].toString(),
                                                  style: subStyle,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 15),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Trading Pair',
                                                  style: headStyle,
                                                ),
                                                Text(
                                                  'USD',
                                                  style: subStyle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Shares Aquired',
                                                  style: headStyle,
                                                ),
                                                Text(
                                                  event['shares'].toString(),
                                                  style: subStyle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        } else {
          return Loading(isDark);
        }
      },
    );
  }

  List divMonths = [];

  getDividendsBeta(){
    for(Map dividend in events){
      var month = months.where((mmonth) => months[DateTime.parse(dividend['paymentDate']).month+1]['id'] == )
    }
  }



  Future<bool> getDividends() async {
    events = await FinancialModelingPrep().getDividends(data['stocks']);
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

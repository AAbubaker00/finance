import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';
import 'package:finance/sections/charts.dart';
import 'package:multi_sort/multi_sort.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

class ViewPortfolio extends StatefulWidget {
  @override
  _ViewPortfolioState createState() => _ViewPortfolioState();
}

class _ViewPortfolioState extends State<ViewPortfolio>
    with SingleTickerProviderStateMixin {
  List<Map> months = [
    {
      'id': "January",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "February",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "March",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "April",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "May",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "June",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "July",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "August",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "September",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "October",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "November",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "December",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    }
  ];
  List upcomingDividendStocks = [];
  List cagrData = [];
  List stocks = [];

  ScrollController _scrollViewController = ScrollController();
  ScrollController _divScrollViewController = ScrollController();

  ScrollController scrollController;

  TabController _tabController;

  String portfolioName = '';

  int totalStocks = 0;
  int totalSectors = 0;

  double yearlyGain = 0.0;
  double totalGain = 0.0;

  double investedValue = 0.0;
  double portfolioValue = 0.0;
  double totalShares = 0.0;
  double change = 0.0;
  double _fromTop;

  bool isSelectedMonth = false;
  bool isSectorSort = false;
  bool isPriceSort = false;
  bool isBuyDateSort = false;
  bool isNameSort = false;
  bool isValueSort = false;
  bool isInitialize = false;

  Map selectedMonth = {};
  Map upComingDividends = {};
  Map data = {};

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    // _tabController.addListener(() {
    //   print(_tabController.index.toString());
    // });

    double aspectRatio =
        (window.physicalSize.height / window.physicalSize.width);

    // print(aspectRatio);
    // print(window.physicalSize.height);
    // print(window.physicalSize.width);

    if (aspectRatio >= 1.7) {
      _fromTop = 220;
    } else if (aspectRatio <= 1.6) {
      _fromTop = 630;
    }
  }

  setData() {
    try {
      setState(() {
        for (var stock in stocks) {
          totalShares += double.parse(stock['shares'].toString());
        }

        stocks = data['stocks'];
        portfolioName = data['portfolioName'];
        investedValue = data['investedValue'];
        portfolioValue = data['portfolioValue'];
        totalShares = data['totalShares'];
        change = data['change'];
        cagrData = data['cagarData'];
        // print(stocks);
      });

      setCAGRChart();
      if (!isInitialize) {
        isInitialize = true;
        setSectors();

        print('loaded');
      }
    } catch (e) {}
  }

  String selectedSortOption = '';

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    data = data['portfolio'];
    setData();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 25.0),
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.sort,
                        color: Colors.white,
                      ),
                      elevation: 0,
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      onChanged: (String option) {
                        setState(() {
                          print(option.toString());
                        });
                      },
                      items: <String>[
                        'Buy Date',
                        'Sector',
                        'Name',
                        'Value',
                        'Edit'
                      ].map<DropdownMenuItem<String>>((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                    ),
                  )
                ],
                backgroundColor: Colors.red,
                expandedHeight: 420.0,
                floating: true,
                pinned: true,
                title: Text(portfolioName),
                flexibleSpace:
                    FlexibleSpaceBar(centerTitle: true, background: _summary()),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: "Securities"),
                      Tab(text: "Dividends"),
                      Tab(text: "Analysis"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              _holding(),
              _dividends(),
              _analysis(),
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }

/* -------------------------------------------------------------------------- */
/*                           Section: Dividend Data                           */
/* -------------------------------------------------------------------------- */

  _monthDataRest({Map month}) {
    month['stocks'].clear();
    month['totalPayment'] = 0.0;
  }

  _dividends() {
    for (var month in months) {
      _monthDataRest(month: month);

      for (var stock in stocks) {
        try {
          String exSectorivMonth =
              stock['marketData']['calanderEvents']['dividendDate']['fmt'];
          DateTime parexSectorivDate = DateTime.parse(exSectorivMonth);
          // print(parexSectorivDate.month);
          // print(
          //     stock['marketData']['defaultKeyStatistics']['lastDividendValue']['raw']);

          if ((months.indexOf(month) + 1) < DateTime.now().month) {
            month['upcoming'] = 'no';
          }

          if (parexSectorivDate.month == (months.indexOf(month) + 1)) {
            month['status'] = 'active';

            month['stocks'].add(stock);

            month['totalPayment'] =
                double.parse(month['totalPayment'].toString()) +
                    (double.parse(stock['marketData']['defaultKeyStatistics']
                                ['lastDividendValue']['raw']
                            .toString()) *
                        double.parse(stock['shares'].toString()));

            // print(month['totalPayment']);

            if (upComingDividends.isEmpty &&
                (months.indexOf(month) + 1) >= DateTime.now().month) {
              upComingDividends = (month);
              upcomingDividendStocks = month['stocks'];
              // print(month);
            }

            // print(month);
          }
        } catch (e) {}
      }
    }

    return ListView(
      controller: _divScrollViewController,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            height: MediaQuery.of(context).copyWith().size.height * 0.28,
            width: MediaQuery.of(context).copyWith().size.width,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25)),
                child: GridView.count(
                  padding: EdgeInsets.all(5),
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                  children: months.map((month) {
                    return InkWell(
                      onTap: () {
                        selectedMonth = month;
                        isSelectedMonth = true;
                        // print(month);
                      },
                      child: Container(
                        // margin: EdgeInsets.all(3),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: (month['upcoming'].toString() == 'yes')
                                ? Colors.white
                                : Colors.grey[200],
                            // borderRadius: BorderRadius.circular(1)
                            // border: Border(
                            //     bottom: BorderSide(
                            //         color: (month['status'] == 'active')
                            //             ? Colors.red
                            //             : Colors.transparent))
                          ),
                          child: Stack(
                            children: [
                              Center(child: Text(month['id'])),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  Icons.brightness_1,
                                  color: (month['status'] == 'active')
                                      ? Colors.red
                                      : Colors.transparent,
                                  size: 5,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ))),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Next Dividends'),
              Text('Month Total: ${upComingDividends['totalPayment']}')
            ],
          ),
        ),
        ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: 1000), // **THIS is the important part**
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              // print("$index saddsad");
              return Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: DecoratedBox(
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${upcomingDividendStocks[index]['marketData']['quote']['symbol']}'),
                          Text(
                              '${upcomingDividendStocks[index]['marketData']['quote']['longName']}'),
                          Text(
                              '${DateTime.parse(upcomingDividendStocks[index]['marketData']['calanderEvents']['dividendDate']['fmt']).day} ${months[(DateTime.parse(upcomingDividendStocks[index]['marketData']['calanderEvents']['dividendDate']['fmt']).month) - 1]['id']} ${DateTime.parse(upcomingDividendStocks[index]['marketData']['calanderEvents']['dividendDate']['fmt']).year}'),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                              '${upcomingDividendStocks[index]['shares']}@${upcomingDividendStocks[index]['marketData']['defaultKeyStatistics']['lastDividendValue']['raw']}'),
                          // Text('Total Payment'),
                          Text(
                              '${(double.parse(upcomingDividendStocks[index]['marketData']['defaultKeyStatistics']['lastDividendValue']['raw'].toString()) * double.parse(upcomingDividendStocks[index]['shares'].toString()))}'),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: upcomingDividendStocks.length,
          ),
        ),
      ],
    );
  }

/* -------------------------------------------------------------------------- */
/*    Section: Summary Data; portfolio value, total gain, invested and cagr   */
/* -------------------------------------------------------------------------- */

  _summary() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 50),
        height: MediaQuery.of(context).copyWith().size.height * 0.5,
        width: MediaQuery.of(context).copyWith().size.width * 0.9,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(''),
              Row(
                children: [
                  Text('£'),
                  Text(
                    portfolioValue.toStringAsFixed(2).replaceAllMapped(
                        new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},'),
                    style: TextStyle(fontSize: 50),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('INVESTED'),
                      Text(
                        (investedValue > 999999)
                            ? NumberFormat.compact().format(investedValue)
                            : investedValue.toStringAsFixed(2).replaceAllMapped(
                                new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => '${m[1]},'),
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('RETURN'),
                      Text(
                        '${change.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}  (${(((portfolioValue - investedValue) / investedValue) * 100).toStringAsFixed(2)}%)',
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  )
                ],
              ),
              ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: 150,
                      minWidth: MediaQuery.of(context).size.width * 0.9),
                  child: SizedBox(child: setCAGRChart()))
            ],
          ),
        ),
      ),
    );
  }

/* -------------------------------------------------------------------------- */
/*                              Section: Holdings                             */
/* -------------------------------------------------------------------------- */
  List<Colors> sectorColors = [
    Colors.red,
    
  ];

  _holding() {
    return Container(
      child: ListView(
          children: sectors.map((sctr) {
        return Container(
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
            child: ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(sctr['name']), Text(sctr['value'].toString())],
              ),
              children: sctr['stocks'].map<Widget>((stk) {
                return Text('${stk['symbol']}');
              }).toList(),
            ),
          ),
        );
      }).toList()),
    );

    // return Container(
    //     child: GridView.count(
    //   padding: EdgeInsets.only(top: 10),
    //   crossAxisCount: 1,
    //   mainAxisSpacing: 10,
    //   childAspectRatio: 5,
    //   children: stocks.map((s) {
    //     return InkWell(
    //       child: Container(
    //         width: MediaQuery.of(context).size.width * 0.77,
    //         child: DecoratedBox(
    //           decoration: BoxDecoration(
    //               color: Colors.grey[300],
    //               border: Border(
    //                 left: BorderSide(
    //                     color: (double.parse(s['change'].toString()) > 0
    //                         ? Colors.green
    //                         : Colors.red),
    //                     width: 3),
    //               )),
    //           child: Row(
    //             children: [
    //               Flexible(
    //                 child: Container(
    //                   margin: EdgeInsets.only(left: 10),
    //                   color: Colors.grey[300],
    //                   width: MediaQuery.of(context).size.width * 0.2,
    //                   child: DecoratedBox(
    //                     decoration: BoxDecoration(),
    //                     child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text(s['symbol']),
    //                           Text(s['marketData']['quote']['longName']),
    //                           Text(
    //                               '${double.parse(s['buyPrice'].toString())} @ ${s['shares']}')
    //                         ]),
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 padding: EdgeInsets.only(left: 10, right: 10),
    //                 color: Colors.white,
    //                 width: MediaQuery.of(context).size.width * 0.77,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(''),
    //                     Column(
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       crossAxisAlignment: CrossAxisAlignment.end,
    //                       children: [
    //                         Text(
    //                           "${(double.parse(s['marketData']['quote']['regularMarketPrice'].toString()) * double.parse(s['shares'].toString())).toStringAsFixed(2)}",
    //                           style: TextStyle(
    //                               color: ((double.parse(s['marketData']['quote']
    //                                                       ['regularMarketPrice']
    //                                                   .toString()) -
    //                                               double.parse(s['buyPrice']
    //                                                   .toString())) /
    //                                           double.parse(
    //                                               s['buyPrice'].toString()) *
    //                                           100) >
    //                                       0
    //                                   ? Colors.green
    //                                   : Colors.red),
    //                         ),
    //                         Row(
    //                           children: [
    //                             Text(
    //                               '${s['change']}  (${((double.parse((s['marketData']['quote']['regularMarketPrice']).toString()) - double.parse(s['buyPrice'].toString())) / double.parse(s['buyPrice'].toString()) * 100).toStringAsFixed(2)} %)',
    //                               style: TextStyle(
    //                                   color: ((double.parse(s['marketData']
    //                                                               ['quote'][
    //                                                           'regularMarketPrice']
    //                                                       .toString()) -
    //                                                   double.parse(s['buyPrice']
    //                                                       .toString())) /
    //                                               double.parse(s['buyPrice']
    //                                                   .toString()) *
    //                                               100) >
    //                                           0
    //                                       ? Colors.green
    //                                       : Colors.red),
    //                             )
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   }).toList(),
    // ));
  }

  _analysis() {
    return Container(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(25)),
              child: DefaultTabController(
                length: 2,
                child: SizedBox(
                  height: 330,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        tabs: [
                          Tab(
                            child: Text(
                              "Stock Allocations",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Sector Allocations",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: TabBarView(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight: 270,
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.8),
                                  child: SizedBox(
                                    child: stocksChart(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 1000),
                            child: SizedBox(
                              height: 250,
                              child: sectorChart(),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(''),
                    Text('()'),
                    Text('daily change'),
                  ],
                ),
                Column(
                  children: [
                    Text(''),
                    Text('()'),
                    Text('Yearly Change'),
                  ],
                ),
                Column(
                  children: [
                    Text(''),
                    Text('()'),
                    Text('Total Change'),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Text('Net Assets Return'),
                        Text(portfolioValue.toString())
                      ], //value of whole account
                    ),
                    Column(
                      children: [
                        Text('Number Of holdings'),
                        Text(stocks.length.toString())
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('Base Currency'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('P/E Ratio'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                  ],
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Text('Inital Assets Value'),
                        Text((investedValue.toStringAsFixed(2))),
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('Shares Outstanding'),
                        Text(totalShares.toString())
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('Launch Date'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('P/B Ratio'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                  ],
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Text('Largest Sector Holding'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('Largest Asset Holding'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('Total Dividends Paid'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  /*   Makes the sectors invested in and allocates the stocks associated with   */
  /* -------------------------------------------------------------------------- */

  List<Map<String, dynamic>> sectors = [];
  List<Map> sectorStocks = [];
  Map sector = {};
  double sectorValue = 0.0;
  double sInvestedValue = 0.0;

  setSectors() {
    for (var stock in stocks) {
      // print(sInvestedValue);
      sectorStocks.add(stock);

      if (sectors.isEmpty) {
        sInvestedValue = double.parse(stock['shares'].toString()) *
            double.parse(stock['buyPrice'].toString());

        // print(sInvestedValue);

        sectors.add({
          'name': stock['marketData']['assets']['sector'],
          'value': sInvestedValue,
          'stocks': stockFilter(
              sectorStocks, stock['marketData']['assets']['sector'].toString())
        });
      } else {
        Map exSector = sectors.firstWhere(
            (s) => stock['marketData']['assets']['sector'] == s['name'],
            orElse: () => null);

        if (exSector == null) {
          //new sector
          sInvestedValue = double.parse(stock['shares'].toString()) *
              double.parse(stock['buyPrice'].toString());

          sectors.add({
            'name': stock['marketData']['assets']['sector'],
            'value': sInvestedValue,
            'stocks': stockFilter(sectorStocks,
                stock['marketData']['assets']['sector'].toString())
          });

          // print(sInvestedValue);
        } else {
          //pre existing sector

          sInvestedValue = double.parse(exSector['value'].toString()) +
              (double.parse(stock['shares'].toString()) *
                  double.parse(stock['buyPrice'].toString()));

          // exSector['stocks'].add(stock);
          // exSector['value'] = sInvestedValue;

          sectors.remove(exSector);

          sectors.add({
            'name': stock['marketData']['assets']['sector'],
            'value': sInvestedValue,
            'stocks': stockFilter(sectorStocks,
                stock['marketData']['assets']['sector'].toString())
          });
          // print(exSector['value']);
        }
      }
    }
  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  setCAGRChart() {
    // print(cagrData);

    List<FlSpot> cagrDataTable = [];
    double interval = 0.0;
    double index = 0.0;

    for (var plot in cagrData) {
      cagrDataTable
          .add(FlSpot(index, double.parse(plot['value'].toStringAsFixed(2))));
      index++;

      if (interval == 0.0) {
        interval = double.parse(plot['value'].toString());
      } else {
        interval = (interval > double.parse(plot['value'].toString()))
            ? interval
            : double.parse(plot['value'].toString());
      }
    }

    interval = interval / 4;

    // print(interval);
    return LineChart(LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(showTitles: false, reservedSize: 10),
        leftTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          reservedSize: 28,
          interval: interval,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      lineBarsData: [
        LineChartBarData(
          spots: cagrDataTable,
          isCurved: true,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors,
          ),
        ),
      ],
    ));
  }

  /* -------------------------------------------------------------------------- */
  /*          Section: Filter; filters stocks into the required sectors         */
  /* -------------------------------------------------------------------------- */

  List<Map<dynamic, dynamic>> stockFilter(
      List<Map<dynamic, dynamic>> stocks, String sector) {
    List<Map<dynamic, dynamic>> filteredStocks = [];

    for (var s in stocks) {
      if (s['marketData']['assets']['sector'] == sector) {
        filteredStocks.add(s);
      }
    }
    return filteredStocks;
  }

  /* -------------------------------------------------------------------------- */
  /*               Sector: Creates dataTable for the Sector chart               */
  /* -------------------------------------------------------------------------- */

  sectorChart() {
    List<Sectors> sectorChartDataTable = [];

    for (var sector in sectors) {
      // print(sector['value']);
      sectorChartDataTable.add(new Sectors(
          name: sector['name'].toString(),
          value: double.parse(sector['value'].toString())));
    }

    return charts.BarChart(
      [
        charts.Series<Sectors, String>(
            id: 'Sectors',
            domainFn: (Sectors s, _) => s.name,
            measureFn: (Sectors s, _) => s.value,
            data: sectorChartDataTable,
            labelAccessorFn: (Sectors s, _) =>
                '${((s.value / investedValue) * 100).toStringAsFixed(2)} %')
      ],
      animate: true,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      domainAxis: new charts.OrdinalAxisSpec(),
      primaryMeasureAxis:
          new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    );
  }

  /* -------------------------------------------------------------------------- */
  /*                 Section: Creats datatable for stocks chart                 */
  /* -------------------------------------------------------------------------- */

  stocksChart() {
    List<Stocks> stockChartDataTable = [];

    for (var stock in stocks) {
      stockChartDataTable.add(new Stocks(
          name: stock['marketData']['quote']['symbol'],
          value: (double.parse(stock['shares'].toString())) *
              double.parse(stock['buyPrice'].toString())));
    }

    List<charts.Color> co = [
      charts.MaterialPalette.blue.shadeDefault.darker,
      charts.MaterialPalette.red.shadeDefault.darker,
      charts.MaterialPalette.green.shadeDefault.darker,
      charts.MaterialPalette.pink.shadeDefault.darker,
      charts.MaterialPalette.gray.shadeDefault.darker,
      charts.MaterialPalette.yellow.shadeDefault.darker,
      charts.MaterialPalette.lime.shadeDefault.darker,
      charts.MaterialPalette.deepOrange.shadeDefault.darker,
      charts.MaterialPalette.cyan.shadeDefault.darker,
      charts.MaterialPalette.indigo.shadeDefault.darker,
      charts.MaterialPalette.purple.shadeDefault.darker,
      charts.MaterialPalette.teal.shadeDefault.darker,
      charts.MaterialPalette.blue.shadeDefault.lighter,
      charts.MaterialPalette.red.shadeDefault.lighter,
      charts.MaterialPalette.green.shadeDefault.lighter,
      charts.MaterialPalette.pink.shadeDefault.lighter,
      charts.MaterialPalette.gray.shadeDefault.lighter,
      charts.MaterialPalette.yellow.shadeDefault.lighter,
      charts.MaterialPalette.lime.shadeDefault.lighter,
      charts.MaterialPalette.deepOrange.shadeDefault.lighter,
      charts.MaterialPalette.cyan.shadeDefault.lighter,
      charts.MaterialPalette.indigo.shadeDefault.lighter,
      charts.MaterialPalette.purple.shadeDefault.lighter,
      charts.MaterialPalette.teal.shadeDefault.lighter,
    ];

    return Stack(
      children: [
        charts.PieChart(
          [
            new charts.Series<Stocks, String>(
                id: 'Stocks',
                domainFn: (Stocks s, _) => s.name,
                measureFn: (Stocks s, _) => s.value,
                data: stockChartDataTable,
                labelAccessorFn: (Stocks s, _) =>
                    '${s.name}\n${((s.value / investedValue) * 100).toStringAsFixed(2)}%',
                colorFn: (_, index) => co[index])
          ],
          animate: true,
          behaviors: [],
          defaultRenderer: new charts.ArcRendererConfig(arcWidth: 30,
              // startAngle: pi,
              // arcLength: pi,
              arcRendererDecorators: [
                new charts.ArcLabelDecorator(
                    outsideLabelStyleSpec: charts.TextStyleSpec(fontSize: 15),
                    labelPosition: charts.ArcLabelPosition.outside)
              ]),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Investments"), Text("${stocks.length}")],
          ),
        ),
      ],
    );
  }
}

class Stocks {
  final String name;
  final double value;

  Stocks({this.name, this.value});
}

class Sectors {
  final String name;
  final double value;

  Sectors({this.name, this.value});
}

extension StringExtension on String {
  String capitalizeFirst() {
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }

  String capitalizeAll() {
    return '${this.toUpperCase()}';
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.red,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

import 'package:finance/sections/charts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:multi_sort/multi_sort.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math' as math;

import 'package:flip_card/flip_card.dart' as Flip;
import 'dart:ui';

class ViewPortfolio extends StatefulWidget {
  @override
  _ViewPortfolioState createState() => _ViewPortfolioState();
}

class _ViewPortfolioState extends State<ViewPortfolio>
    with SingleTickerProviderStateMixin {
  GlobalKey<Flip.FlipCardState> flipCardKey = GlobalKey<Flip.FlipCardState>();
  double _fromTop;

  List months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  ScrollController _scrollViewController = ScrollController();
  TabController _tabController;

  List stocks = [];
  Map data = {};

  String portfolioName = '';

  int totalStocks = 0;
  int totalSectors = 0;

  double monthlyGain = 0.0;
  double yearlyGain = 0.0;
  double totalGain = 0.0;

  double investedValue = 0.0;
  double portfolioValue = 0.0;
  double totalShares = 0.0;
  double change = 0.0;

  ScrollController scrollController;

  bool isDividendsTab = false;
  bool isChartsTab = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);

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
    setState(() {
      stocks = data['stocks'];
      portfolioName = data['portfolioName'];
      investedValue = data['investedValue'];
      portfolioValue = data['portfolioValue'];
      totalShares = data['totalShares'];
      change = data['change'];
      // print(stocks);
    });
  }

  String selectedSortOption = '';

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    data = data['portfolio'];
    setData();

    setSectors();

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
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
                          selectedSortOption = option;
                          stocks.multisort([true], 'buyPrice');
                        });
                      },
                      items: <String>[
                        'Buy Date',
                        'Sector',
                        'Name',
                        'Value',
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
                expandedHeight: 250.0,
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
                      Tab(text: "Assets"),
                      Tab(text: "Statistics"),
                      Tab(text: "Dividends"),
                      Tab(text: "Report"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              _assets(),
              _statistics(),
              Text("cc"),
              Text('oof')
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }

  _dividendMonths() {
    return Center(
      child: Container(
          padding: EdgeInsets.only(top: 50),
          height: MediaQuery.of(context).copyWith().size.height * 0.3,
          width: MediaQuery.of(context).copyWith().size.width * 0.9,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)),
              child: GridView.count(
                padding: EdgeInsets.all(5),
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5,
                children: months.map((m) {
                  return InkWell(
                    child: Container(
                      // margin: EdgeInsets.all(3),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Center(child: Text(m)),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                Icons.brightness_1,
                                color: Colors.red,
                                size: 10,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ))),
    );
  }

  _summary() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 50),
        height: MediaQuery.of(context).copyWith().size.height * 0.3,
        width: MediaQuery.of(context).copyWith().size.width * 0.9,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('£'),
                  Text(
                    portfolioValue.toStringAsFixed(2).replaceAllMapped(
                        new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},'),
                    style: TextStyle(fontSize: 55),
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
                        style: TextStyle(fontSize: 35),
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
                        '${change.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}  ()',
                        style: TextStyle(fontSize: 35),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _assets() {
    return Container(
        child: GridView.count(
      padding: EdgeInsets.only(top: 10),
      crossAxisCount: 1,
      mainAxisSpacing: 10,
      childAspectRatio: 5,
      children: stocks.map((s) {
        return InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.77,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border(
                    left: BorderSide(
                        color: (double.parse(s['change'].toString()) > 0
                            ? Colors.green
                            : Colors.red),
                        width: 3),
                  )),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      color: Colors.grey[300],
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: DecoratedBox(
                        decoration: BoxDecoration(),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(s['symbol']),
                              Text(s['marketData']['quote']['longName']),
                              Text(
                                  '${((double.parse(s['buyPrice'].toString()) * double.parse(s['shares'].toString())).toStringAsFixed(2)).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}')
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width * 0.77,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Value: ${s['change']}"),
                            Text("shares: ${s['shares']}"),
                            Text('Avg. Cost: 2122')
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${s['change']} £ gain",
                              style: TextStyle(
                                  color: ((double.parse(s['marketData']['quote']
                                                          ['regularMarketPrice']
                                                      .toString()) -
                                                  double.parse(s['buyPrice']
                                                      .toString())) /
                                              double.parse(
                                                  s['buyPrice'].toString()) *
                                              100) >
                                          0
                                      ? Colors.green
                                      : Colors.red),
                            ),
                            Row(
                              children: [
                                Text('${s['symbol']}: '),
                                Text(
                                  '${((double.parse((s['marketData']['quote']['regularMarketPrice']).toString()) - double.parse(s['buyPrice'].toString())) / double.parse(s['buyPrice'].toString()) * 100).toStringAsFixed(2)}%',
                                  style: TextStyle(
                                      color: ((double.parse(s['marketData']
                                                                  ['quote'][
                                                              'regularMarketPrice']
                                                          .toString()) -
                                                      double.parse(s['buyPrice']
                                                          .toString())) /
                                                  double.parse(s['buyPrice']
                                                      .toString()) *
                                                  100) >
                                              0
                                          ? Colors.green
                                          : Colors.red),
                                )
                              ],
                            ),
                            Text("")
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    ));
  }

  _statistics() {
    return Container(
      child: ListView(
        children: [
          Expanded(
            child: SizedBox(
              height: 250,
              child: charts.BarChart(
                sectorChart(),
                animate: true,
                barRendererDecorator: new charts.BarLabelDecorator<String>(),
                domainAxis: new charts.OrdinalAxisSpec(),
                primaryMeasureAxis: new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          Text("Total Shares"),
                          Text(totalShares.toString()),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Text("Monthly Gain"),
                          Text(monthlyGain.toString())
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Column(
                        children: [
                          Text("Total Stocks"),
                          Text(totalShares.toString()),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Text("Yearly Gain"),
                          Text(yearlyGain.toString())
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Column(
                        children: [
                          Text("Sectors Invested"),
                          Text(totalSectors.toString()),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Text("Total Gain"),
                          Text(totalGain.toString())
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20)),
              child: DefaultTabController(
                length: 3,
                child: SizedBox(
                  height: 300,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        tabs: [
                          Tab(
                            child: Text(
                              "Holdings",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Tab(
                            child: Text("Sectors",
                                style: TextStyle(color: Colors.red)),
                          ),
                          Tab(
                            child: Text('Dividends',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                      Expanded(
                          child: TabBarView(
                        children: [
                          Container(
                              padding: EdgeInsets.only(top: 10),
                              child: SizedBox(
                                  child: Stack(
                                children: [
                                  charts.PieChart(
                                    stocksChart(),
                                    animate: true,
                                    behaviors: [],
                                    defaultRenderer:
                                        new charts.ArcRendererConfig(
                                            arcWidth: 30,
                                            startAngle: 3 / 5 * math.pi,
                                            arcRendererDecorators: [
                                          new charts.ArcLabelDecorator(
                                              labelPosition: charts
                                                  .ArcLabelPosition.outside)
                                        ]),
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Investments"),
                                        Text("67")
                                      ],
                                    ),
                                  ),
                                ],
                              ))),
                          Container(
                            color: Colors.yellow,
                          ),
                          Container(
                            color: Colors.lightGreen,
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> sectors = [];
  Map sector = {};
  double sectorValue = 0.0;
  List<Map> sectorStocks = [];
  double sInvestedValue = 0.0;


/* -------------------------------------------------------------------------- */
/*   Makes the sectors invested in and allocates the stocks associated with   */
/* -------------------------------------------------------------------------- */

  setSectors() {
    for (var stock in stocks) {
      // print(sInvestedValue);
      sectorStocks.add(stock);

      if (sectors.isEmpty) {
        sInvestedValue = double.parse(stock['shares'].toString()) *
            double.parse(stock['buyPrice'].toString());

        sectors.add({
          'name': stock['marketData']['assets']['sector'],
          'value': sInvestedValue,
          'stocks': sectorStocks
        });
      } else {
        Map sD = sectors.firstWhere(
            (s) => stock['marketData']['assets']['sector'] == s['name'],
            orElse: () => null);

        if (sD == null) {
          //new sector
          sInvestedValue = double.parse(stock['shares'].toString()) *
              double.parse(stock['buyPrice'].toString());

          sectors.add({
            'name': stock['marketData']['assets']['sector'],
            'value': sInvestedValue,
            'stocks': sectorStocks
          });
        } else {
          //pre existing sector

          sInvestedValue = double.parse(sD['value'].toString()) +
              (double.parse(stock['shares'].toString()) *
                  double.parse(stock['buyPrice'].toString()));

          sectors.remove(sD);

          sectors.add({
            'name': stock['marketData']['assets']['sector'],
            'value': sInvestedValue,
            'stocks': stockFilter(sectorStocks,
                stock['marketData']['assets']['sector'].toString())
          });
        }
      }
    }
    for (var sector in sectors) print(sector['value']); //! //////////////////
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
      sectorChartDataTable.add(new Sectors(
          name: sector['name'].toString(),
          value: double.parse(sector['value'].toString())));
    }

    return [
      charts.Series<Sectors, String>(
        id: 'Sectors',
        domainFn: (Sectors s, _) => s.name,
        measureFn: (Sectors s, _) => s.value,
        data: sectorChartDataTable,
        labelAccessorFn: (Sectors s, _) => '${(s.value/investedValue)*100} %'
      )
    ];
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

    return [
      new charts.Series<Stocks, String>(
          id: 'Stocks',
          domainFn: (Stocks s, _) => s.name,
          measureFn: (Stocks s, _) => s.value,
          data: stockChartDataTable
          )          
    ];
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

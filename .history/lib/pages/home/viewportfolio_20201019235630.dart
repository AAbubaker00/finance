import 'package:finance/sections/charts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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

  ScrollController _scrollViewController = ScrollController();
  TabController _tabController;

  List stocks = [];
  Map data = {};

  String portfolioName = '';

  int totalStocks = 0;

  double investedValue = 0.0;
  double portfolioValue = 0.0;
  double totalShares = 0.0;
  double change = 0.0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);

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

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    data = data['portfolio'];
    setData();

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.red,
                expandedHeight: 250.0,
                floating: true,
                pinned: true,
                title: Text(portfolioName),
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 50),
                        height:
                            MediaQuery.of(context).copyWith().size.height * 0.3,
                        width:
                            MediaQuery.of(context).copyWith().size.width * 0.9,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('£'),
                                  Text(
                                    portfolioValue
                                        .toStringAsFixed(2)
                                        .replaceAllMapped(
                                            new RegExp(
                                                r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                            (Match m) => '${m[1]},'),
                                    style: TextStyle(fontSize: 55),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('INVESTED'),
                                      Text(
                                        (investedValue > 999999)
                                            ? NumberFormat.compact()
                                                .format(investedValue)
                                            : investedValue
                                                .toStringAsFixed(2)
                                                .replaceAllMapped(
                                                    new RegExp(
                                                        r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                    (Match m) => '${m[1]},'),
                                        style: TextStyle(fontSize: 35),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                    )),
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
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[_assets(), _statistics(), Text("cc")],
            controller: _tabController,
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
                              Text(s['name']),
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
                                  color: ((double.parse(s['marketPrice']
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
                                  '${((double.parse(s['marketPrice'].toString()) - double.parse(s['buyPrice'].toString())) / double.parse(s['buyPrice'].toString()) * 100).toStringAsFixed(2)}%',
                                  style: TextStyle(
                                      color: ((double.parse(s['marketPrice']
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
      child: GridView.count(
        crossAxisCount: 1,
        childAspectRatio: 1.5,
        mainAxisSpacing: 10,
        children: [
          Expanded(
            child: SizedBox(
              height: 200,
              child: SelectionLineHighlight.withSampleData(),
            ),
          ),

          Expanded(child: Column(
            children: [
              Row(
                children: [
                  Column(
                    Text()
                  )
                ],
              )
            ],
          )),

          Expanded(
            child: SizedBox(height: 280, child: SectorCharts()),
          ),
        ],
      ),
    );
  }
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

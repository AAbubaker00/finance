import 'package:flutter/material.dart';

import 'package:flip_card/flip_card.dart' as Flip;
import 'dart:ui';

class ViewPortfolio extends StatefulWidget {
  @override
  _ViewPortfolioState createState() => _ViewPortfolioState();
}

class _ViewPortfolioState extends State<ViewPortfolio>
    with SingleTickerProviderStateMixin {
  List<Map<dynamic, dynamic>> portfolioData = [{}];

  GlobalKey<Flip.FlipCardState> flipCardKey = GlobalKey<Flip.FlipCardState>();
  double _fromTop;

  ScrollController _scrollViewController = ScrollController();
  TabController _tabController;

  int page = 0;

  Map data = {};

  List stocks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);

    double aspectRatio =
        (window.physicalSize.height / window.physicalSize.width);

    print(aspectRatio);
    print(window.physicalSize.height);
    print(window.physicalSize.width);

    if (aspectRatio >= 1.7) {
      _fromTop = 220;
      print("1");
    } else if (aspectRatio <= 1.6) {
      _fromTop = 630;
      print("2");
    }
  }

  setData() {
    setState(() {
      stocks = data['stocks'];
      print(stocks);
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
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                title: Text("asdasda"),
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 50),
                        height:
                            MediaQuery.of(context).copyWith().size.height * 0.2,
                        width:
                            MediaQuery.of(context).copyWith().size.width * 0.9,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [Text("Summary  ")],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Text("5626"),
                                      Text("Total Shares")
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("5626"),
                                      Text("Total Invested")
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("5626"),
                                      Text("Total Gain")
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text("£51,626,262"),
                                      Text("Total Investment Capital")
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
                      Tab(text: "Allocations"),
                      Tab(text: "Dividends"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[, Text("bb"), Text("cc")],
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
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

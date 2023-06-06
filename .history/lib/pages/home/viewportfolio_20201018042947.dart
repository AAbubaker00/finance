import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:finance/sections/charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ViewPortfolio extends StatefulWidget {
  @override
  _ViewPortfolioState createState() => _ViewPortfolioState();
}

class _ViewPortfolioState extends State<ViewPortfolio> {
  List<String> titles = ['Summary', 'Assets', 'Dividends'];
  List options = [
    Text(),
    IconButton(icon: Icon(Icons.sort), onPressed: () {}),
  ];

  int page = 0;
  int optionIndex = 0;

  Map data = {};

  List stocks = [];

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

    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          title: Text(titles[page]),
          actions: [options[optionIndex]],
        ),
      ),
      body: CarouselSlider(
        options: CarouselOptions(
          onPageChanged: (index, reason) {
            setState(() {
              page = index;
              if (index == 1) {
                optionIndex = 1;
              } else {
                optionIndex = 0;
              }
            });
          },
          initialPage: 1,
          viewportFraction: 0.97,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          height: MediaQuery.of(context).size.height,
        ),
        items: [
          _summary(),
          _assets(),
          Container(
            color: Colors.yellow,
            child: Text("asdsaa"),
          ),
        ],
      ),
    ));
  }

  _assets() {
    return Container(
        child: GridView.count(
      padding: EdgeInsets.only(top: 10),
      crossAxisCount: 1,
      mainAxisSpacing: 10,
      childAspectRatio: 5,
      children: stocks.map((s) {
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.2,
          secondaryActions: [
            IconSlideAction(
              caption: 'Edit',
              color: Colors.black45,
              icon: Icons.more_horiz,
              onTap: () => print('Edit'),
            ),
            IconSlideAction(
              caption: 'Sell',
              color: Colors.red[900],
              icon: Icons.horizontal_rule,
              onTap: () => print('Sell'),
            ),
          ],
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

  _summary() {
    return Container(
        child: StaggeredGridView.countBuilder(
      crossAxisCount: 1,
      padding: EdgeInsets.only(top: 10),
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return summarySections[index];
      },
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(1, summaryPositionSize(index)),
      mainAxisSpacing: 10,
    ));
  }

  num summaryPositionSize(int index) {
    switch (index) {
      case 0:
        return .5;
        break;
      case 1:
        return .3;
        break;
      case 2:
        return .7;
        break;
      case 3:
        return .7;
        break;
    }

    return 1;
  }

  List<Container> summarySections = [
    Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("552"), Text("Total Shares")],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [Text("£23232"), Text("Total Invested")],
                ),
                Column(
                  children: [Text("552"), Text("Total Return")],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("5"), Text("Total Stocks")],
            ),
          ],
        ),
      ),
    ),
    Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("552"), Text("Monthly Gain")],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("552"), Text("Yearly Gain")],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("552"), Text("Total Gain")],
            )
          ],
        ),
      ),
    ),
    Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: StockCharts(),
      ),
    ),
    Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: SectorCharts(),
      ),
    ),
  ];
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:finance/sections/charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ViewPortfolio extends StatefulWidget {
  @override
  _ViewPortfolioState createState() => _ViewPortfolioState();
}

class _ViewPortfolioState extends State<ViewPortfolio> {
  List<String> titles = ['Summary', 'Assets', 'Dividends'];

  int page = 0;

  Map data = {};

  List<Map<dynamic, dynamic>> stocks;

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
        ),
      ),
      body: CarouselSlider(
        options: CarouselOptions(
          onPageChanged: (index, reason) {
            setState(() {
              page = index;
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
      childAspectRatio: 7,
      children: stocks.map((s) {
        return Container(
          child: DecoratedBox(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Container(
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Colors.red, width: 3))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(s['symbol']), Text(s['name'])],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [Text("v")],
                  ),
                ),
                Align(alignment: Alignment.centerLeft,)
              ],
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

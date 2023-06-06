import 'package:carousel_slider/carousel_slider.dart';
import 'package:finance/sections/charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SamplePage extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  List upcoming = [
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
    "apple",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // backgroundColor: Color(0xff191919),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(25),
        child: AppBar(
          title: Text("Dividend"),
        ),
      ),
      body: CarouselSlider(
        options: CarouselOptions(
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
      children: upcoming.map((e) {
        return Container(
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)),
            child: Container(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.red, width: 5))
                ),
                              child: Row(
                  children: [
                    Column(
                      children: [Text("APPL"), Text("Apple, inc")],
                    )
                  ],
                ),
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
            color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
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
            color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
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
            color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
        child: StockCharts(),
      ),
    ),
    Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
        child: SectorCharts(),
      ),
    ),
  ];
}

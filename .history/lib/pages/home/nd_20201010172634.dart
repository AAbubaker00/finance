import 'package:carousel_slider/carousel_slider.dart';
import 'package:finance/sections/charts.dart';
import 'package:flutter/material.dart';

class SamplePage extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(25),
        child: AppBar(
          title: Text("Dividend"),
        ),
      ),
      body: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 0.95,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          height: MediaQuery.of(context).size.height,
        ),
        items: [
          _summary(),
          Container(
            color: Colors.blue,
            child: Text("fffd"),
          ),
          Container(
            color: Colors.yellow,
            child: Text("asdsaa"),
          ),
        ],
      ),
    ));
  }

  _summary() {
    return Container(
        child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width*0.9,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [Text("552"), Text("Total Shares")],
                        ),
                        Column(
                          children: [Text("£23232"), Text("Total Invested")],
                        ),
                        Column(
                          children: [Text("5"), Text("Total Stocks")],
                        )
                      ],
                    ),
                    Column(
                      children: [Text("552"), Text("Total Return")],
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
                child: SectorCharts(),
              ),
            )
          ],
        ),
      
    );
  }
}

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
     var size = MediaQuery.of(context).size;

   final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;


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
    return new Container(
      child: new GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        controller: new ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: widgetList.map((String value) {
          return new Container(
            color: Colors.green,
            margin: new EdgeInsets.all(1.0),
            child: new Center(
              child: new Text(
                value,
                style: new TextStyle(
                  fontSize: 50.0,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

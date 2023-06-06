import 'package:carousel_slider/carousel_slider.dart';
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
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          height: MediaQuery.of(context).size.height,
        ),
        items: [
          Container(
            color: Colors.green,
            child: Text("aaa"),
          ),
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
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [Text("552"), Text("Total Shares")],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

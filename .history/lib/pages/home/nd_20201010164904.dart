import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SamplePage extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: CarouselSlider(
        options: CarouselOptions(

          scrollDirection: Axis.horizontal,
          height: MediaQuery.of(context).size.height,
          
          
        ),
        items: [
          Container(
            color: Colors.green,
            child: Text("aaa"),
          ),Container(
            color: Colors.blue,

            child: Text("fffd"),
          ),Container(
            color: Colors.yellow,

            child: Text("asdsaa"),
          ),
        ],
      ),
    ));
  }
}

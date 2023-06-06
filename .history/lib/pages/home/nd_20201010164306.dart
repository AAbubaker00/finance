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
        options: Cars,
      ),
    ));
  }
}

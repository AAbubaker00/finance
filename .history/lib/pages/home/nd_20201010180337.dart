import 'package:carousel_slider/carousel_slider.dart';
import 'package:finance/sections/charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
        child: StaggeredGridView.countBuilder(
      crossAxisCount: 1,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) => new Container(
          color: Colors.green,
          child: new Center(
            child: new CircleAvatar(
              backgroundColor: Colors.white,
              child: new Text('$index'),
            ),
          )),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(1, get,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    ));
  }

  num getPosition(int index){
    return 1;
  }

  // _summary() {
  //   return Container(
  //       child: GridView.count(
  //         childAspectRatio: 2,
  //         scrollDirection: Axis.vertical,
  //         crossAxisCount: 1,
  //         mainAxisSpacing: 10,
  //         children: [
  //           Container(
  //             height: MediaQuery.of(context).size.height*0.5,
  //             child: DecoratedBox(
  //               decoration: BoxDecoration(
  //                   color: Colors.grey,
  //                   borderRadius: BorderRadius.circular(20)),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: [
  //                       Column(
  //                         children: [Text("552"), Text("Total Shares")],
  //                       ),
  //                       Column(
  //                         children: [Text("£23232"), Text("Total Invested")],
  //                       ),
  //                       Column(
  //                         children: [Text("5"), Text("Total Stocks")],
  //                       )
  //                     ],
  //                   ),
  //                   Column(
  //                     children: [Text("552"), Text("Total Return")],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //           Container(
  //             child: DecoratedBox(
  //               decoration: BoxDecoration(
  //                   color: Colors.grey,
  //                   borderRadius: BorderRadius.circular(20)),
  //               child: SectorCharts(),
  //             ),
  //           )
  //         ],
  //       ),

  //   );
  // }
}

import 'package:finance/custome_Widgets/_navigationbar.dart';
import 'package:finance/custome_Widgets/_stockwindow.dart';
import 'package:finance/sections/charts.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'package:flip_card/flip_card.dart' as Flip;
import 'dart:ui';

class ViewPortfolio extends StatefulWidget {
  @override
  _ViewPortfolioState createState() => _ViewPortfolioState();
}

class _ViewPortfolioState extends State<ViewPortfolio>
    with SingleTickerProviderStateMixin {
  List stocks = [
    "apple",
    "apple",
    "apple",
    "apple",
  ];

  GlobalKey<Flip.FlipCardState> flipCardKey = GlobalKey<Flip.FlipCardState>();
  double _fromTop;

  ScrollController _scrollViewController = ScrollController();
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);

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

  @override
  Widget build(BuildContext context) {
    return SliverCustomHeaderDelegate().build(context, 100, overlapsContent);
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
          .clamp(0, 255)
          .toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background image
          Container(child: Image.network(this.coverImgUrl, fit: BoxFit.cover)),
          // Put your head back
        ],
      ),
    );
  }
}

//     return SafeArea(
//         child: DefaultTabController(
//             length: 3,
//             child: Scaffold(
//               appBar: AppBar(
//                 title: Text("dssafa"),
//                 flexibleSpace: FlexibleSpaceBar(
//                   centerTitle: true,
//                   title: Center(
//                     child: Column(
//                       children: [
//                         SizedBox(height: 30,),
//                         Container(
//                           padding: EdgeInsets.all(20),
//                           height:
//                               MediaQuery.of(context).copyWith().size.height * 0.2,
//                           width: MediaQuery.of(context).copyWith().size.width * 0.9,
//                           child: DecoratedBox(
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [Text("Summary  ")],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   children: <Widget>[
//                                     Column(
//                                       children: [
//                                         Text("5626"),
//                                         Text("Total Shares")
//                                       ],
//                                     ),
//                                     Column(
//                                       children: [
//                                         Text("5626"),
//                                         Text("Total Invested")
//                                       ],
//                                     ),
//                                     Column(
//                                       children: [Text("5626"), Text("Total Gain")],
//                                     )
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Column(
//                                       children: [
//                                         Text("£51,626,262"),
//                                         Text("Total Investment Capital")
//                                       ],
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 bottom: PreferredSize(
//                   preferredSize: Size.square(200.0),
//                   child: TabBar(
//                     tabs: [
//                       Icon(Icons.train),
//                       Icon(Icons.directions_bus),
//                       Icon(Icons.motorcycle)
//                     ],
//                   ),
//                 ),
//               ),
//               body: TabBarView(
//                 children: <Widget>[
//                   Container(
//                     child: Center(
//                       child: Text('Tab 1'),
//                     ),
//                   ),
//                   Container(
//                     child: Center(
//                       child: Text('Tab 2'),
//                     ),
//                   ),
//                   Container(
//                     child: Center(
//                       child: Text('Tab 3'),
//                     ),
//                   ),
//                 ],
//               ),
//             )));
//   }
// }
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.grey[200],
//         body: Stack(
//           children: [

//             //AppBar

//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: AppBar(
//                 toolbarHeight: 40,
//                 backgroundColor: Colors.black,
//                 title: Text("asdasd"),
//               ),
//             ),

//             // Summary Section

//             Positioned(
//               top: 35,
//               left: 5,
//               right: 5,
// child: Container(
//   padding: EdgeInsets.all(10),
//   height: MediaQuery.of(context).copyWith().size.height * 0.2,
//   width: MediaQuery.of(context).copyWith().size.width * 0.9,
//   child: DecoratedBox(
//     decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10)),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [Text("Summary  ")],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             Column(
//               children: [Text("5626"), Text("Total Shares")],
//             ),
//             Column(
//               children: [Text("5626"), Text("Total Invested")],
//             ),
//             Column(
//               children: [Text("5626"), Text("Total Gain")],
//             )
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Column(
//               children: [
//                 Text("£51,626,262"),
//                 Text("Total Investment Capital")
//               ],
//             )
//           ],
//         )
//       ],
//     ),
//   ),
// ),
//             ),

//             //User Stocks Section

//             Positioned(
//               bottom: 290,
//               top: _fromTop,
//               right: 15,
//               left: 15,
//               child: InkWell(
//                 onTap: () {
//                   print("user stocks");
//                 },
//                 child: Stack(
//                   children: [
//                     Text("Your Stocks "),
//                     Container(
//                         color: Colors.red,
//                         child: DecoratedBox(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: Colors.black)),
//                           child: ListView(
//                             scrollDirection: Axis.vertical,
//                             children: stocks.map((s) {
//                               return MiniStockWindow("symbol", "exchange");
//                             }).toList(),
//                           ),
//                         )),
//                   ],
//                 ),
//               ),
//             ),

//             //Graphs Section
//             Positioned(
//                 top: _fromTop + 320,
//                 bottom: 10,
//                 right: 14,
//                 left: 14,
//                 child: Stack(children: [
//                   Container(
//                       child: DecoratedBox(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Flip.FlipCard(
//                       key: flipCardKey,
//                       front: SectorCharts(),
//                       back: StockCharts(),
//                     ),
//                   )),
//                   Align(
//                       alignment: Alignment.bottomRight,
//                       child: IconButton(
//                         onPressed: () =>
//                             flipCardKey?.currentState?.toggleCard(),
//                         icon: Icon(Icons.arrow_right),
//                       ))
//                 ])),
//             Positioned(bottom: 10, right: 60, left: 60, child: ZNavigationBar())
//           ],
//         ),
//       ),
//     );
//   }
// }

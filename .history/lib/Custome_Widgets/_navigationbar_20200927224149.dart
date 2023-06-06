import 'package:finance/pages/loading.dart';
import 'package:flutter/material.dart';

class ZNavigationBar extends StatelessWidget {
  double _iconSize = 35;

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: GNav(
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: Duration(milliseconds: 800),
            tabBackgroundColor: Colors.white30,
            selectedIndex: _selectedIndex,
            tabs: _bottomNavigationBarItemItems(),
            onTabChange: _onItemTapped
          ),
        ),
      );


    // return Container(
    //     height: MediaQuery.of(context).size.height * 0.06,
    //     width: MediaQuery.of(context).size.width * 0.5,
    //     child: DecoratedBox(
    //         decoration: BoxDecoration(
    //             color: Colors.pink, borderRadius: BorderRadius.circular(30)),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             // IconButton(
    //             //   onPressed: () {},
    //             //   icon: Icon(
    //             //     Icons.library_books,
    //             //     size: _iconSize,
    //             //   ),
    //             // ),
    //             IconButton(
    //               onPressed: () {Navigator.pushNamed(context, '/portfolio');},
    //               icon: Icon(
    //                 Icons.pie_chart,
    //                 size: _iconSize,
    //               ),
    //             ),
    //             IconButton(
    //               onPressed: () {},
    //               icon: Icon(
    //                 Icons.home,
    //                 size: _iconSize,
    //               ),
    //             ),
    //             IconButton(
    //               onPressed: () {
    //                 Navigator.pushReplacementNamed(context, "/search", arguments: {'stocklist': Loading().getStockList()});},
    //               icon: Icon(
    //                 Icons.search,
    //                 size: _iconSize,
    //               ),
    //             ),
    //           ],
    //         )));
  }
}

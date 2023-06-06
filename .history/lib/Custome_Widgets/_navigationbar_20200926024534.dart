import 'package:finance/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ZNavigationBar extends StatelessWidget {
  double _iconSize = 35;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.5,
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.pink, borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(
                //     Icons.library_books,
                //     size: _iconSize,
                //   ),
                // ),
                IconButton(
                  onPressed: () {Navigator.pushNamed(context, '/portfolio');},
                  icon: Icon(
                    Icons.pie_chart,
                    size: _iconSize,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home,
                    size: _iconSize,
                  ),
                ),
                IconButton(
                  onPressed: () {Navigator.pushReplacementNamed(context, "/search", arguments: {'stocklist': Loading().getStockList();}},
                  icon: Icon(
                    Icons.search,
                    size: _iconSize,
                  ),
                ),
              ],
            )));
  }
}

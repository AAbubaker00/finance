import 'package:finance/pages/loading.dart';
import 'package:flutter/material.dart';

class ZNavigationBar extends StatelessWidget {
  double _iconSize = 35;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.pink, borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/search", arguments: {'stocklist': Loading().getStockList()});},
                  icon: Icon(
                    Icons.search,
                    size: _iconSize,
                  ),
                ),
                
                IconButton(
                  onPressed: () {
                                        Navigator.pushReplacementNamed(context, "/search", arguments: {'stocklist': Loading().getStockList()});,

                  },
                  icon: Icon(
                    Icons.monetization_on,
                    size: _iconSize,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.settings,
                    size: _iconSize,
                  ),
                ),
              ],
            )));
  }
}

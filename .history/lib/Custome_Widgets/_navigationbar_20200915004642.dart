import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class cNavigationBar extends StatelessWidget {
  double _iconSize = 30;


  FutugetData

  @override
  Widget build(BuildContext context) {



    return Container(
        height: 60,
        width: 270,
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.pink, borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.library_books,
                    size: _iconSize,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: _iconSize,
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
              ],
            )));
  }
}

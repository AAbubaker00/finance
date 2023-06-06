import 'package:finance/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class ZNavigationBar extends StatefulWidget {
  @override
  _ZNavigationBarState createState() => _ZNavigationBarState();
}

class _ZNavigationBarState extends State<ZNavigationBar> {
  double _iconSize = 35;
  int currentIndex = 0;
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
                  onPressed: () {
                    Navigator.pushNamed(context, '/portfolio');
                  },
                  icon: Icon(
                    Icons.dash,
                    size: _iconSize,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/home");
                  },
                  icon: Icon(
                    Icons.home,
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
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/dividend");
                  },
                  icon: Icon(
                    Icons.monetization_on,
                    size: _iconSize,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/settings");
                  },
                  icon: Icon(
                    Icons.settings,
                    size: _iconSize,
                  ),
                ),
              ],
            )));
  }
}

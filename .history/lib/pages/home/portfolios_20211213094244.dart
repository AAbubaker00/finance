import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/decoration/customDecoration.dart';
import 'package:intl/intl.dart';
import 'package:backdrop/backdrop.dart';

import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/units/units.dart';
import 'package:flutter/material.dart';

class Portfolios extends StatefulWidget {
  Portfolios({Key key}) : super(key: key);

  @override
  _PortfoliosState createState() => _PortfoliosState();
}

class _PortfoliosState extends State<Portfolios> {
  List<String> sortOptions = ['Investment', 'Return', 'Buy Date', 'Shares', 'A-Z'];
  List portfolios = [];
  String selectedSortOption = 'Return', inceptionDate = '';
  String baseCurrency = '', baseC = '';

  Map data = {};

  double circularRadius = 15, ratio, width, height;

  var themeMode = true;






  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    data = ModalRoute.of(context).settings.arguments;
    portfolios = data['portfolios'];

    
    return Container(
      color: UserThemes(themeMode).backgroundColour,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: InkWell(
            onTap: () => _showPortfolios(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [Text(selectedSortOption), Icon(Icons.keyboard_arrow_down_rounded)],
            ),
          ),
        ),
      )),
    );
  }

  Widget _sortPopupMenu() => PopupMenuButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: UserThemes(themeMode).backgroundColour,
        elevation: 8,
        offset: Offset(0, 50),
        onSelected: (value) {
          // selectedSortOption = sortOptions[int.parse(value)];

          // isSortLoaded = false;
          // setSort();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(selectedSortOption), Icon(Icons.keyboard_arrow_down_rounded)],
        ),
        itemBuilder: (context) => sortOptions.map<PopupMenuItem<String>>((String option) {
          return PopupMenuItem(
            value: sortOptions.indexOf(option).toString(),
            child: Text(
              option,
              style: TextStyle(
                  color: selectedSortOption == option
                      ? UserThemes(themeMode).textColor
                      : UserThemes(themeMode).textColorVarient,
                  fontWeight: selectedSortOption == option ? FontWeight.w600 : FontWeight.w400),
            ),
          );
        }).toList(),
      );
}

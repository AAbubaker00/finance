import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/decoration/customDecoration.dart';
import 'package:intl/intl.dart';

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

  double circularRadius = 15, ratio, width, height;

  var themeMode = true;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

data = Modal
    portfolios = data['portfolios'];

    void _showPortfolios() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Ink(
            padding: EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 5),
            decoration: CustomDecoration(themeMode, true).baseContainerDecoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 15, top: 10, left: 5),
                    child: Text('Portfolios', style: CustomTextStyles(themeMode).sectionHeader)),
                GridView.count(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 1,
                  mainAxisSpacing: 5,
                  childAspectRatio: ((width / height) / .115),
                  children: portfolios.map((p) {
                    return InkWell(
                      // onLongPress: () async {
                      //   _showRemovePortfolioPanel(p);
                      // },
                      // onTap: () async {
                      //   for (var asset in filterAssets) {
                      //     if (asset['marketData']['chartData']['max'].isEmpty) {
                      //       isChartError = true;
                      //     }
                      //   }

                      //   if (isChartError == true) {
                      //     await _quickUpdate();
                      //   }

                      //   timer.cancel();

                      //   // print(p['cagr']);

                      //   Navigator.pushNamed(context, '/portfolio',
                      //           arguments: {'portfolio': p, 'data': data})
                      //       .then((value) => setState(() {
                      //             setTimer();
                      //             updateChanges = true;
                      //           }));
                      // },
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Units().circularRadius),
                      ),
                      child: Ink(
                        decoration: CustomDecoration(themeMode, false).baseContainerDecoration,
                        padding: EdgeInsets.all(10), //(top: 15, left: 10, right: 10, bottom: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(p['name'].toString(),
                                        style: CustomTextStyles(themeMode).portfolioNameStyle)),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                      p['portfolioValue'] > 1000000000
                                          ? '$baseCurrency${NumberFormat.compact().format(p['portfolioValue'])}'
                                          : '$baseCurrency${p['portfolioValue'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}', //${p['baseCurrency']}
                                      style: CustomTextStyles(themeMode).holdingValueStyle),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                        p['investedValue'] > 1000000000
                                            ? '$baseCurrency${NumberFormat.compact().format(p['investedValue'])}'
                                            : '$baseCurrency${p['investedValue'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}', //${p['baseCurrency']}
                                        style: CustomTextStyles(themeMode).holdingSubValueStyle),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      p['change'] > 1000000000
                                          ? '+$baseCurrency${NumberFormat.compact().format(p['change'])}'
                                          : (double.parse(p['change'].toString())) >= 0
                                              ? '+$baseCurrency${p['change'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(double.parse(p['change'].toString()) / double.parse(p['investedValue'].toString()) * 100).toStringAsFixed(2)}%)'
                                              : '-$baseCurrency${(p['change'] * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(double.parse((p['change'] * -1).toString()) / double.parse(p['investedValue'].toString()) * 100).toStringAsFixed(2)}%)',
                                      style: CustomTextStyles(themeMode).holdingSubValueStyle.copyWith(
                                          color: (double.parse(p['change'].toString()) >= 0
                                              ? UserThemes(themeMode).greenVarient //Colors.green
                                              : UserThemes(themeMode).redVarient)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      );
    }

    return Container(
      color: UserThemes(themeMode).backgroundColour,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: InkWell(
            onTap: () => _showPortfolios,
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

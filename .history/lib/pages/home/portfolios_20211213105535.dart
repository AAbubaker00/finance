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

class _PortfoliosState extends State<Portfolios> with TickerProviderStateMixin {
  List<String> sortOptions = ['Investment', 'Return', 'Buy Date', 'Shares', 'A-Z'];
  List portfolios = [];
  String selectedSortOption = 'Return', inceptionDate = '';
  String baseCurrency = '', baseC = '', currencySymbol = '';

  double summarySpacing = 30,
      change = 0.0,
      changePercentage = 0,
      dailyChange = 0.0,
      dailyChangePercent = 0.0,
      drawerSpacing = 5,
      yearChange = 0.0,
      yearChangePercent = 0.0,
      cagrGrowthRate = 0.0;
  double investedValue = 0.0, portfolioValue = 0.0;

  Map data = {};

  double circularRadius = 15, ratio, width, height;

  var themeMode = true;

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 1, initialIndex: 0, vsync: this);
  }

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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 200),
          child: AppBar(
            centerTitle: true,
            title: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(portfolios[0]['name']),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
                onTap: _showPortfolios),
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Container(
                  child: Container(
                    decoration: CustomDecoration(themeMode, true).baseContainerDecoration,
                    child: Container(
                      decoration: CustomDecoration(themeMode, false).baseContainerDecoration,
                      padding: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            mainAxisSize: ,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 20,
                                  // top: 10
                                ),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '$currencySymbol',
                                          style: CustomTextStyles(themeMode).overallCurrencyStyle,
                                        ),
                                        Text(
                                          '${portfolioValue.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                          style: CustomTextStyles(themeMode).overallValueStyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              'INVESTED',
                                              style: CustomTextStyles(themeMode).headerStyle,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              (investedValue > 1000000)
                                                  ? '$currencySymbol${NumberFormat.compact().format(investedValue).toString()}'
                                                  : '$currencySymbol${investedValue.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 19,
                                                  color: UserThemes(themeMode).textColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text('EARNINGS',
                                                  style: CustomTextStyles(themeMode).headerStyle)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                                (change >= 1000000 || change <= -1000000)
                                                    ? (change >= 0)
                                                        ? '+$currencySymbol${NumberFormat.compact().format(change)} (+${(changePercentage).toStringAsFixed(2)}%)'
                                                        : '-$currencySymbol${(NumberFormat.compact().format((change * -1)))} (${(changePercentage).toStringAsFixed(2)}%)'
                                                    : (change >= 0)
                                                        ? '+$currencySymbol${change.toStringAsFixed(2)} (+${(changePercentage).toStringAsFixed(2)}%)'
                                                        : '-$currencySymbol${(change * -1).toStringAsFixed(2)} (${(changePercentage).toStringAsFixed(2)}%)',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 19,
                                                    color: (change > 0)
                                                        ? UserThemes(themeMode).greenVarient
                                                        : UserThemes(themeMode).redVarient)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  //
                                ],
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text('Holdings'),
                )
              ],
            ),
          ),
        ),
        body: TabBarView(controller: _tabController, children: [Text('ds')]),
      )),
    );
  }

  _showPortfolios() {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, _, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              color: UserThemes(themeMode).backgroundColour,
              child: Card(
                color: UserThemes(themeMode).backgroundColour,
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: GridView.count(
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
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ).drive(Tween<Offset>(
            begin: Offset(0, -1.0),
            end: Offset.zero,
          )),
          child: child,
        );
      },
    );
  }
}

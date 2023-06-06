import 'package:flutter/material.dart';

class PortfolioCard extends StatelessWidget {
  final Map data;

  const PortfolioCard({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
return p['name'] == 'add'
                            ? Ink(
                                decoration: BoxDecoration(
                                    color: DarkTheme(isDark).summaryColour,
                                    // border: Border.all(color: DarkTheme(isDark).border, width: 1.5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(5),
                                  onTap: () {
                                    Navigator.of(context).pushNamed('/newPortfolio',
                                        arguments: {'data': data, 'initalData': initData});
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: DarkTheme(isDark).textColorVarient,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                onLongPress: () async {
                                  _showRemovePortfolioPanel(p);
                                },
                                onTap: () async {
                                  for (var asset in filterAssets) {
                                    if (asset['marketData']['chartData']['max'].isEmpty) {
                                      isChartError = true;
                                    }
                                  }

                                  if (isChartError == true) {
                                    await _quickUpdate();
                                  }

                                  timer.cancel();

                                  Navigator.pushNamed(
                                          context, '/portfolio', arguments: {'portfolio': p, 'data': data})
                                      .then((value) => setState(() {
                                            setTimer();
                                            updateChanges = true;
                                          }));
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: DarkTheme(isDark)
                                        .summaryColour, //VarientColours().customColours[searchViewList.indexOf(p)].withOpacity(.1),
                                    borderRadius: BorderRadius.circular(5),
                                    // border: Border.all(color: DarkTheme(isDark).border, width: 1.5)
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Text(p['name'], style: portfolioNameStyle)),
                                              // Stack(children: <Widget>[
                                              //   new Icon(
                                              //     Icons.notifications,
                                              //     color: DarkTheme(isDark).iconColour,
                                              //     size: 20,
                                              //   ),
                                              //   new Positioned(
                                              //       // draw a red marble
                                              //       top: 0.0,
                                              //       right: 0.0,
                                              //       child: CircleAvatar(
                                              //           radius: 5,
                                              //           backgroundColor: Colors.redAccent,
                                              //           child: Center(
                                              //               child: Text('1',
                                              //                   style: TextStyle(fontSize: 8)))))
                                              // ]),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text('$baseCurrency',
                                                    style: TextStyle(
                                                        color: DarkTheme(isDark).textColor,
                                                        fontSize: 30,
                                                        fontWeight: FontWeight.w300)),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                  p['portfolioValue'] > 1000000000
                                                      ? NumberFormat.compact().format(p['portfolioValue'])
                                                      : '${p['portfolioValue'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}', //${p['baseCurrency']}
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w400,
                                                    color: DarkTheme(isDark).textColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                  children: [
                                                    FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text('INVESTED', style: assetHeaderStyle)),
                                                    FittedBox(
                                                      fit: BoxFit.fitWidth,
                                                      child: Text(
                                                          p['investedValue'] > 1000000
                                                              ? '$baseCurrency${NumberFormat.compact().format(p['investedValue'])}'
                                                              : '$baseCurrency${p['investedValue'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}', //${p['baseCurrency']}
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: DarkTheme(isDark).textColor,
                                                              fontWeight: FontWeight.w500)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text('EARNINGS', style: assetHeaderStyle)),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        FittedBox(
                                                          fit: BoxFit.fitWidth,
                                                          child: Text(
                                                            p['change'] > 1000000
                                                                ? '+$baseCurrency${NumberFormat.compact().format(p['change'])}'
                                                                : (double.parse(p['change'].toString())) >= 0
                                                                    ? '+$baseCurrency${p['change'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
                                                                    : '-$baseCurrency${(p['change'] * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight: FontWeight.w500,
                                                                color:
                                                                    (double.parse(p['change'].toString()) >= 0
                                                                        ? DarkTheme(isDark)
                                                                            .greenVarient //Colors.green
                                                                        : DarkTheme(isDark).redVarient)),
                                                          ),
                                                        ),
                                                        FittedBox(
                                                          fit: BoxFit.fitWidth,
                                                          child: Text(
                                                              (double.parse(p['investedValue'].toString()) ==
                                                                      0.0)
                                                                  ? '0'
                                                                  : '${(double.parse(p['change'].toString()) / double.parse(p['investedValue'].toString()) * 100).toStringAsFixed(2)}%',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.w500,
                                                                  color:
                                                                      (double.parse(p['change'].toString()) >
                                                                              0
                                                                          ? DarkTheme(isDark)
                                                                              .greenVarient //Colors.green
                                                                          : DarkTheme(isDark).redVarient))),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                  
  }
}

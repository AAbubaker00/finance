import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ViewStock extends StatefulWidget {
  @override
  _ViewStockState createState() => _ViewStockState();
}

class _ViewStockState extends State<ViewStock> {
  List<Map> timeFrame = [
    {'time': '1D', 'selected': false},
    {'time': '1W', 'selected': false},
    {'time': '1MO', 'selected': false},
    {'time': '3MO', 'selected': false},
    {'time': '1Y', 'selected': false},
    {'time': 'MAX', 'selected': true},
  ];

  TextStyle headerStyle = TextStyle(fontSize: 15, color: Colors.white38);
  TextStyle sublineStyle = TextStyle(
    fontSize: 20,
    color: Colors.grey[350],
  );

  Map slStock = {};

  // String title = '';
  // String symbol = '';
  // String exchange = '';
  // String country = '';
  // String marketPrice = '';
  // String

  // setData() {
  //   setState(() {
  //     title = slStock['quote']['longName'];
  //     symbol = slStock['quote']['symbol'];
  //     exchange = slStock['quote']['']
  //     cuntry = slStock['quote'][''];
  //     marketPrice = slStock['quote'][''];

  //   });
  // }

  @override
  Widget build(BuildContext context) {
    slStock = ModalRoute.of(context).settings.arguments;
    slStock = slStock['data'];

    // setData();

    // print(slStock);

    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: true,
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight * 0.6),
            child: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(slStock['quote']['longName']),
              centerTitle: true,
            ),
          ),
          body: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${slStock['quote']['symbol']} ', style: TextStyle(color: Colors.white38)),
                  Icon(
                    Icons.circle,
                    size: 5,
                    color: Colors.white54,
                  ),
                  Text(' ${slStock['quote']['market'].toString()}', style: TextStyle(color: Colors.white38)),
                  Icon(
                    Icons.circle,
                    size: 5,
                    color: Colors.white54,
                  ),
                  Text(' ${slStock['quote']['fullExchangeName']}', style: TextStyle(color: Colors.white38))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Container(
                  // color: Colors.grey[300],
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'PRICE',
                        style: TextStyle(
                          color: Colors.white38,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(slStock['quote']['regularMarketPrice'].toString(),
                              style: TextStyle(color: Colors.white, fontSize: 40)),
                          Text(slStock['quote']['currency'],
                              style: TextStyle(
                                color: Colors.white38,
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${slStock['quote']['regularMarketChange']} ',
                              style: TextStyle(
                                color:
                                    (slStock['quote']['regularMarketChange'] > 0) ? Colors.green : Colors.red,
                              )),
                          Text('(${slStock['quote']['regularMarketChangePercent']}) ',
                              style: TextStyle(
                                color:
                                    (slStock['quote']['regularMarketChange'] > 0) ? Colors.green : Colors.red,
                              )),
                          Text('TODAY', style: TextStyle(color: Colors.white38))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20), child: setChart()),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: GridView.count(
                  shrinkWrap: false,
                  crossAxisCount: 6,
                  childAspectRatio: 2,
                  // scrollDirection: Axis.horizontal,
                  children: timeFrame.map((time) {
                    return InkWell(
                      child: Card(
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            time['time'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.055,
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              // color: Colors.grey[850],
                              border: Border.all(color: Colors.white38),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Text('SELL', style: TextStyle(color: Colors.white, fontSize: 20))),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.055,
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            // color: Colors.grey[850],
                            border: Border.all(color: Colors.white38),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text(
                          'BUY',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Key Ratios',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Market Cap', style: headerStyle),
                                  Text('23423424', style: sublineStyle),
                                ],
                              ),
                              Divider(
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Revenue', style: headerStyle),
                                  Text('23423424', style: sublineStyle),
                                ],
                              ),
                              Divider(
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Sector', style: headerStyle),
                                  Text('23423424', style: sublineStyle),
                                ],
                              ),
                              Divider(
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Industry', style: headerStyle),
                                  Text('23423424', style: sublineStyle),
                                ],
                              ),
                              Divider(
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('P/E Ratio', style: headerStyle),
                                  Text('23423424', style: sublineStyle),
                                ],
                              ),
                              Divider(
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('EPS', style: headerStyle),
                                  Text('23423424', style: sublineStyle),
                                ],
                              ),
                              Divider(
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('VOLUME', style: headerStyle),
                                  Text('23423424', style: sublineStyle),
                                ],
                              ),
                              Divider(
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('N. Shares', style: headerStyle),
                                  Text('23423424', style: sublineStyle),
                                ],
                              ),
                              Divider(
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('BETA', style: headerStyle),
                                  Text('23423424', style: sublineStyle),
                                ],
                              ),
                              Divider(
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('SHORT RATIO', style: headerStyle),
                                  Text('23423424', style: sublineStyle),
                                ],
                              ),
                              Divider(
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Color> gradientColors = [Colors.grey[400], Colors.transparent];

  setChart() {
    var cdt;

    print(slStock['chartData']['max']);

    for(var plot in slStock['chartData']['max'])

    return Text('hi');

    return Container(
        child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 150, minWidth: MediaQuery.of(context).size.width * 0.9),
            child: SizedBox(
                child: LineChart(LineChartData(
              gridData: FlGridData(
                show: false,
                drawVerticalLine: true,
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(showTitles: false, reservedSize: 10, interval: 1),
                leftTitles: SideTitles(showTitles: false),
                rightTitles: SideTitles(
                  showTitles: false,
                  getTextStyles: (value) => const TextStyle(
                    color: Color(0xff67727d),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  reservedSize: 28,
                ),
              ),
              // minY: investedValue / 3,
              // lineTouchData: LineTouchData(
              //   enabled: true,
              //   touchTooltipData: LineTouchTooltipData(
              //       tooltipBgColor: Colors.transparent,
              //       getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              //         return touchedBarSpots.map((barSpot) {
              //           final flSpot = barSpot;
              //           if (flSpot.x == 0 || flSpot.x == 6) {
              //             return null;
              //           }

              //           return LineTooltipItem(
              //             '${flSpot.y.toInt()} \n${cagrValueData[flSpot.x.toInt()]['date']}',
              //             const TextStyle(color: Colors.white),
              //           );
              //         }).toList();
              //       }),
              // ),
              borderData:
                  FlBorderData(show: false, border: Border.all(color: const Color(0xff37434d), width: 1)),
              lineBarsData: [
                LineChartBarData(
                  colors: [Colors.green[900], Colors.green[300]],
                  spots: cdt,
                  isCurved: true,
                  barWidth: 0.5,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: false,
                  ),
                  belowBarData: BarAreaData(
                    show: false,
                    gradientFrom: Offset(0.5, 0.1),
                    gradientTo: Offset(0.5, 1.5),
                    colors: gradientColors,
                  ),
                ),
              ],
            )))));
  }
}

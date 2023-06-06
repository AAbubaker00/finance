import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:intl/intl.dart';

class ViewStock extends StatefulWidget {
  @override
  _ViewStockState createState() => _ViewStockState();
}

class _ViewStockState extends State<ViewStock> {
  List<Map> timeFrame = [
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
                  Text(' ${slStock['quote']['market'].toString()} ', style: TextStyle(color: Colors.white38)),
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
                  top: 40,
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
                          Text('${slStock['quote']['regularMarketChange'].toStringAsFixed(2)} ',
                              style: TextStyle(
                                color:
                                    (slStock['quote']['regularMarketChange'] > 0) ? Colors.green : Colors.red,
                              )),
                          Text('(${slStock['quote']['regularMarketChangePercent'].toStringAsFixed(2)}) ',
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
              Padding(padding: EdgeInsets.only(top: 10, right: 10), child: setChart()),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: GridView.count(
                  shrinkWrap: false,
                  crossAxisCount: 5,
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

              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Your Investment',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),

              C




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
                                  Text('${NumberFormat.compact().format(slStock['quote']['marketCap'])} ',
                                      style: sublineStyle),
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
                                  Text('VOLUME', style: headerStyle),
                                  Text(
                                      '${NumberFormat.compact().format(slStock['quote']['regularMarketVolume'])}',
                                      style: sublineStyle),
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
                                  Text(
                                      (slStock['assets']['sector'] == null)
                                          ? '...'
                                          : slStock['assets']['sector'],
                                      style: sublineStyle),
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
                                  Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.width * 0.05,
                          

                                    child: Marquee(
                                      
                                      text: (slStock['assets']['industry'] == null)
                                          ? '...'
                                          : slStock['assets']['industry'],
                                      style: sublineStyle,
                                      scrollAxis: Axis.horizontal,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      blankSpace: 20.0,
                                      velocity: 10,
                                      pauseAfterRound: Duration(seconds: 1),
                                      showFadingOnlyWhenScrolling: true,
                                      fadingEdgeStartFraction: 0.1,
                                      fadingEdgeEndFraction: 0.1,
                                      numberOfRounds: 3,
                                      startPadding: 10.0,
                                      accelerationDuration: Duration(seconds: 1),
                                      accelerationCurve: Curves.linear,
                                      decelerationDuration: Duration(milliseconds: 500),
                                      decelerationCurve: Curves.easeOut,
                                    ),
                                  ),
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
                                  Text(slStock['quote']['forwardPE'].toStringAsFixed(2), style: sublineStyle),
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
                                  Text(slStock['quote']['epsForward'].toStringAsFixed(2),
                                      style: sublineStyle),
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
                                  Text(
                                      slStock['defaultKeyStatistics']['beta'] == null
                                          ? '...'
                                          : slStock['defaultKeyStatistics']['beta']['fmt'],
                                      style: sublineStyle),
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
                                  Text('BOOK', style: headerStyle),
                                  Text(slStock['quote']['bookValue'].toString(), style: sublineStyle),
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
                                  Text('Shares Outstan...', style: headerStyle),
                                  Text(NumberFormat.compact().format(slStock['quote']['sharesOutstanding']),
                                      style: sublineStyle),
                                ],
                              ),
                              Divider(
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.055,
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              // color: Colors.grey[850],
                              border: Border.all(color: Colors.white38, width: 0.5),
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
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            // color: Colors.grey[850],
                            border: Border.all(color: Colors.white38, width:0.5),
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
              
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Color> gradientColors = [Colors.grey[400], Colors.transparent];
  double index = 0.0;
  int x = 0;

  setChart() {
    List<FlSpot> chartData = [];

    // print(slStock['chartData']['max']['close']);

    for (var plot in slStock['chartData']['max']['close']) {
      if (plot != null) {
        if (plot > 20) {
          chartData.add(FlSpot(index, double.parse(plot.toStringAsFixed(2))));
          index++;
          x = 0;
        }
      }
    }

    // return Text('hi');

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
            
              borderData:
                  FlBorderData(show: false, border: Border.all(color: const Color(0xff37434d), width: 1)),
              lineBarsData: [
                LineChartBarData(
                  colors: [Colors.green[900], Colors.green[300]],
                  spots: chartData,
                  isCurved: false,
                  barWidth: 0.5,
                  isStrokeCapRound: false,
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

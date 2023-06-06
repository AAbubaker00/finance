import 'package:finance/services/yahooapi/yahoo_api_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:time_formatter/time_formatter.dart';

class ViewStock extends StatefulWidget {
  @override
  _ViewStockState createState() => _ViewStockState();
}

class _ViewStockState extends State<ViewStock> {
  List<Map<String, dynamic>> timeFrame = [
    {'time': '1D', 'selected': false},
    {'time': '1W', 'selected': false},
    {'time': '3W', 'selected': false},
    {'time': '1Y', 'selected': false},
    {'time': 'MAX', 'selected': true}
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(DateTime.fromMillisecondsSinceEpoch(1434672000 * 1000));
    getstocData();
  }

  Map selectedStock = {};
  Map data = {};

  TextStyle headline = TextStyle(
    color: Colors.white38,
  );
  TextStyle subText = TextStyle(color: Colors.white);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool isSell = false;
  bool isBuy = false;

  @override
  Widget build(BuildContext context) {
    // selectedStock = ModalRoute.of(context).settings.arguments;
    // selectedStock = selectedStock['data'];
    // getstocData();

    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          endDrawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.

            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,

              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                ),
                Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.49,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Form(
                            key: _formKey,
                            child: ListView(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Details',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: TextFormField(
                                    validator: (txt) => txt.isEmpty
                                        ? 'Enter Price*'
                                        : (double.tryParse(txt) != null
                                            ? null
                                            : 'Enter a Valid Amount'),
                                    decoration: InputDecoration(
                                      labelText: 'Purchase Price',
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    onChanged: (txt) {},
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: TextFormField(
                                    validator: (txt) => txt.isEmpty
                                        ? 'Enter N. of Shares'
                                        : (double.tryParse(txt) != null
                                            ? null
                                            : 'Enter a Valid Amount'),
                                    decoration: InputDecoration(
                                      labelText: 'N. Shares',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    onChanged: (txt) {},
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: TextFormField(
                                    onTap: () {},
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(fontSize: 15),
                                      labelText: 'Date of Event',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    onChanged: (txt) {},
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text('Select Portfolio',
                                      style: TextStyle(fontSize: 20)),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: ListView.builder(
                                        itemCount: 1,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              // setState(() {
                                              //   if (portfolioData['portfolios']
                                              //           [index]['editMode'] ==
                                              //       true) {
                                              //     portfolioData['portfolios'][index]
                                              //         ['editMode'] = false;
                                              //   } else {
                                              //     portfolioData['portfolios'][index]
                                              //         ['editMode'] = true;
                                              //   }
                                              // });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(right: 5),
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                    // border: Border.all(
                                                    // color: (portfolioData[
                                                    //                     'portfolios']
                                                    //                 [index]
                                                    //             ['editMode'] ==
                                                    //         true)
                                                    //     ? Colors.green
                                                    //     : Colors.grey[600]
                                                    //         .withOpacity(0.6)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 15, right: 15),
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(),
                                                    child: Center(
                                                      child: Text(
                                                        "",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // ),
                                          );
                                        }),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Options',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (isBuy) {
                                              isBuy = false;
                                            } else {
                                              isBuy = true;
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: isBuy
                                                          ? Colors.green[600]
                                                          : Colors.grey[600]),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text('Buy'))),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (isSell) {
                                              isSell = false;
                                            } else {
                                              isSell = true;
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: isSell
                                                          ? Colors.red[600]
                                                          : Colors.grey[600]),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text('Sell'))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: FloatingActionButton.extended(
                                      backgroundColor: Colors.black,
                                      elevation: 0,
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {}
                                      },
                                      icon: Icon(
                                        Icons.save_alt,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Update',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          backgroundColor: Colors.black,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight * 0.7),
              child: AppBar(
                  backgroundColor: Colors.black,
                  title: Text("APPL"),
                  actions: [
                    Container(
                      child: IconButton(
                          icon: Icon(
                            Icons.add_outlined,
                            color: Colors.white38,
                          ),
                          onPressed: () =>
                              _scaffoldKey.currentState.openEndDrawer()),
                    ),
                  ])),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          // color: Colors.red,
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.43,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Market Price', style: headline),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "3242342",
                                    style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Gbp',
                                    style: headline,
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '221',
                                    style: headline,
                                  ),
                                  Text(' (23%)', style: headline)
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          // color: Colors.blue,
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('52w Low', style: headline),
                                  Text('52w High', style: headline),
                                  Text('52w Change', style: headline),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('33432 ', style: subText),
                                  Text('234%', style: subText),
                                  Text('LSE', style: subText),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('24H High', style: headline),
                                  Text('24H Low', style: headline),
                                  Text('24H Chnage', style: headline),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('23 ', style: subText),
                                  Text('5212', style: subText),
                                  Text('1231', style: subText),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: GridView.count(
                        shrinkWrap: false,
                        crossAxisCount: 5,
                        childAspectRatio: 2.5,
                        // scrollDirection: Axis.horizontal,
                        children: timeFrame.map((time) {
                          return InkWell(
                            child: Container(
                              // color: Colors.pink,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: time['selected'] == true
                                              ? Colors.grey[600]
                                              : Colors.transparent)),
                                ),
                                child: Center(
                                  child: Text(
                                    time['time'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 300,
                        ),
                        child: SizedBox(
                          child: _getDefaultLineChart(),
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Company Details',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ceo',
                                  style: headline,
                                ),
                                Text(
                                  '3232',
                                  style: subText,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Headquaters',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Country',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                            Text(
                              'Key Ratios',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Market Cap',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Revenue',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Beta',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(''),
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sector',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Website',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Outstanding Shares',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                            Text(''),
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Book Value',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Price/Book',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Short Ratio',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(''),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Industry',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Exchange',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                            Text(''),
                            Text(''),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Fowards EPS',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Trailing EPS',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Foward PE',
                                  style: headline,
                                ),
                                Text('3232', style: subText),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String text;
  bool isExpanded = false;
  bool descTextShowFlag = false;

  double prevValue = 0.0;

  _getDefaultLineChart() {
    print(selectedStock['chartData']['max']['close']);

    List<_ChartData> chartDataTable = List<_ChartData>();
    int dateIndex = 0;

    List<double> maxValues_low = selectedStock['chartData']['max']['low'];
    List<double> maxValues_high = selectedStock['chartData']['max']['high'];
    List<double> maxValues_open = selectedStock['chartData']['max']['open'];
    List<double> maxValues_close = selectedStock['chartData']['max']['close'];

    for (var date in selectedStock['chartData']['max']['timestamp']) {
      chartDataTable.add(
        _ChartData(close: maxValues_close[dateIndex], open: maxValues_open[dateIndex], low: maxValues_low[dateIndex)
      );
    }

    // selectedStock['chartData']['max'].forEach((key, value) {
    // if (plot == 'null') {
    //   // plot = plot.toString().replaceAll('null', '${prevValue.toString()}');
    //   // chartDataTable.add(_ChartData(double.parse(plot.toString()), dateIndex));
    //   // dateIndex++;
    //   print('yes');
    // } else {
    // chartDataTable.add(_ChartData(plot, dateIndex));
    // }

    // chartDataTable.add(_ChartData(
    //     open: plot['open'][dateIndex],
    //     close: plot['close'][dateIndex],
    //     high: plot['high'][dateIndex],
    //     low: plot['low'][dateIndex],
    //     dateIndex: dateIndex));

    // print(plot);

    // prevValue = plot;

    //   dateIndex++;
    // });

    // selectedStock['chartDataTable'].forEach((key, value) {
    //   for(var )
    // });

    // return Text("das");

    return SfCartesianChart(
      trackballBehavior: TrackballBehavior(
          enable: true,
          tooltipDisplayMode: TrackballDisplayMode.floatAllPoints),
      plotAreaBorderWidth: 0,
      crosshairBehavior: CrosshairBehavior(enable: true),
      borderWidth: 0,
      primaryXAxis: NumericAxis(
        axisLine: AxisLine(width: 0, color: Colors.transparent),
        isVisible: true,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorGridLines: MajorGridLines(
            width: 1,
            color: Colors.grey[600].withOpacity(.5),
            dashArray: <double>[5, 5]),
      ),
      primaryYAxis: NumericAxis(
        interactiveTooltip: InteractiveTooltip(enable: true),
        opposedPosition: true,
        labelStyle:
            TextStyle(fontSize: 10, color: Colors.grey[600].withOpacity(.5)),
        labelPosition: ChartDataLabelPosition.inside,
        labelFormat: '{value} ${selectedStock['quote']['currency']}',
        axisLine: AxisLine(width: 0.3),
        majorTickLines: MajorTickLines(width: 0.3),
        majorGridLines: MajorGridLines(color: Colors.grey[600].withOpacity(.3)),
      ),
      series: <ChartSeries<_ChartData, dynamic>>[
        HiloOpenCloseSeries(
            dataSource: chartDataTable,
            xValueMapper: (_ChartData dateIndex, _) => dateIndex.dateIndex,
            lowValueMapper: (_ChartData dateIndex, _) => dateIndex.low,
            highValueMapper: (_ChartData dateIndex, _) => dateIndex.high,
            openValueMapper: (_ChartData dateIndex, _) => dateIndex.open,
            closeValueMapper: (_ChartData dateIndex, _) => dateIndex.close)

        // FastLineSeries<_ChartData, num>(
        //     animationDuration: 1000,
        //     trendlines: <Trendline>[
        //       Trendline(
        //           type: TrendlineType.exponential,
        //           color: Colors.green.withOpacity(0.6),
        //           width: 0.2)
        //     ],
        //     dataSource: chartDataTable,
        //     xValueMapper: (_ChartData sales, _) => sales.dateIndex,
        //     yValueMapper: (_ChartData sales, _) => sales.price,
        //     width: 0.5,
        //     markerSettings: MarkerSettings(isVisible: false)),
      ],
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  getstocData() async {
    selectedStock = await YahooApiService()
        .getAllStockData(symbol: 'lloy', exchange: 'LSE');

    setState(() {});
  }
}

class _ChartData {
  _ChartData({this.open, this.dateIndex, this.low, this.high, this.close});
  final double open;
  final double close;
  final double low;
  final double high;
  final double dateIndex;
}

import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:intl/intl.dart';

class ViewStock extends StatefulWidget {
  @override
  _ViewStockState createState() => _ViewStockState();
}

class _ViewStockState extends State<ViewStock> {
    FocusNode focusNode = FocusNode();
      String hintText = '0';
  List<Map> timeFrame = [
    {'time': '1W', 'selected': false},
    {'time': '1MO', 'selected': false},
    {'time': '3MO', 'selected': false},
    {'time': '1Y', 'selected': false},
    {'time': 'MAX', 'selected': true},
  ];

  TextStyle headerStyle = TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w100);
  TextStyle sublineStyle = TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300);

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
              title: Text(
                slStock['quote']['longName'],
              ),
              centerTitle: true,
              actions: [
                FlatButton(
                    onPressed: () {},
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size:
                            20, //Text('ADD', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ))
              ],
            ),
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${slStock['quote']['symbol']} ',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100)),
                  Icon(
                    Icons.circle,
                    size: 5,
                    color: Colors.white,
                  ),
                  Text(' ${slStock['quote']['market'].toString()} ',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100)),
                  Icon(
                    Icons.circle,
                    size: 5,
                    color: Colors.white,
                  ),
                  Text(' ${slStock['quote']['fullExchangeName']}',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100))
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(slStock['quote']['currency'],
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100)),
                          Text(slStock['quote']['regularMarketPrice'].toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w400)),
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
                          Text('TODAY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Number of Shares',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 50, color: Colors.grey[600], fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.blueAccent[400], fontWeight: FontWeight.w300),
                          hintText: hintText,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          // border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                        // onChanged: (price) {
                        //   setState(() => purchasePrice = double.parse(price.toString()));
                        // },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                          labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                          helperStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
                          helperText: 'default: 1',
                          labelText: '*Quantity',
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey[600],
                          )),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                        // onChanged: (amount) {
                        //   setState(() => quantity = double.parse(amount.toString()));
                        // },
                      ),
                      SizedBox(height: 20),
                      // InkWell(
                      //   // onTap: () {
                      //   //   _pickDateDialog();
                      //   // },
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Container(
                      //         height: MediaQuery.of(context).size.height * 0.045,
                      //         width: MediaQuery.of(context).size.width,
                      //         child: DecoratedBox(
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(5),
                      //               border: Border.all(color: Colors.grey[600])),
                      //           child: Padding(
                      //             padding: EdgeInsets.only(
                      //               left: 10,
                      //             ),
                      //             child: Align(
                      //               alignment: Alignment.centerLeft,
                      //               child: Text(
                      //                 DateFormat('dd-MM-yyyy').format(_selectedDate).toString(),
                      //                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         height: 7,
                      //       ),
                      //       Padding(
                      //           padding: EdgeInsets.only(left: 10, bottom: 20),
                      //           child: Text(
                      //             'Purchase Date',
                      //             style: TextStyle(
                      //                 color: Colors.white, fontWeight: FontWeight.w200, fontSize: 12),
                      //           ))
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
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

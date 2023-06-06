import 'package:flutter/material.dart';
import 'package'
class Analysis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: DefaultTabController(
              length: 2,
              child: SizedBox(
                height: 330,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: Text(
                            "Stock Allocations",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Sector Allocations",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: TabBarView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Container(
                          child: Column(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: 270,
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.8),
                                child: SizedBox(
                                  child: stocksChart(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 1000),
                          child: SizedBox(
                            height: 250,
                            child: sectorChart(),
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(''),
                    Text('()'),
                    Text('daily change'),
                  ],
                ),
                Column(
                  children: [
                    Text(''),
                    Text('()'),
                    Text('Yearly Change'),
                  ],
                ),
                Column(
                  children: [
                    Text(''),
                    Text('()'),
                    Text('Total Change'),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Text('Net Assets Return'),
                        Text(portfolioValue.toString())
                      ], //value of whole account
                    ),
                    Column(
                      children: [
                        Text('Number Of holdings'),
                        Text(stocks.length.toString())
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('Base Currency'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('P/E Ratio'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                  ],
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Text('Inital Assets Value'),
                        Text((investedValue.toStringAsFixed(2))),
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('Shares Outstanding'),
                        Text(totalShares.toString())
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('Launch Date'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('P/B Ratio'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                  ],
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Text('Largest Sector Holding'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('Largest Asset Holding'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                    Column(
                      children: [
                        Text('Total Dividends Paid'),
                        Text('2323')
                      ], //oldest stock held date
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  
  List<Map<String, dynamic>> sectors = [];
  List<Map> sectorStocks = [];
  Map sector = {};
  double sectorValue = 0.0;
  double sInvestedValue = 0.0;

  setSectors() {
    for (var stock in stocks) {
      // print(sInvestedValue);
      sectorStocks.add(stock);

      if (sectors.isEmpty) {
        sInvestedValue = double.parse(stock['shares'].toString()) *
            double.parse(stock['buyPrice'].toString());

        // print(sInvestedValue);

        sectors.add({
          'name': stock['marketData']['assets']['sector'],
          'value': sInvestedValue,
          'stocks': stockFilter(
              sectorStocks, stock['marketData']['assets']['sector'].toString())
        });
      } else {
        Map exSector = sectors.firstWhere(
            (s) => stock['marketData']['assets']['sector'] == stock['name'],
            orElse: () => null);

        if (exSector == null) {
          //new sector
          sInvestedValue = double.parse(stock['shares'].toString()) *
              double.parse(stock['buyPrice'].toString());

          sectors.add({
            'name': stock['marketData']['assets']['sector'],
            'value': sInvestedValue,
            'stocks': stockFilter(sectorStocks,
                stock['marketData']['assets']['sector'].toString())
          });

          // print(sInvestedValue);
        } else {
          //pre existing sector

          sInvestedValue = double.parse(exSector['value'].toString()) +
              (double.parse(stock['shares'].toString()) *
                  double.parse(stock['buyPrice'].toString()));

          // exSector['stocks'].add(stock);
          // exSector['value'] = sInvestedValue;

          sectors.remove(exSector);

          sectors.add({
            'name': stock['marketData']['assets']['sector'],
            'value': sInvestedValue,
            'stocks': stockFilter(sectorStocks,
                stock['marketData']['assets']['sector'].toString())
          });
          // print(exSector['value']);
        }
      }
    }
  }

  List<Color> gradientColors = [Colors.grey[400], Colors.transparent];

  setCAGRChart() {
    // print(cagrData);

    List<FlSpot> cagrDataTable = [];
    List<FlSpot> cdt = [];
    List<FlSpot> cdvt = [];

    double interval = 0.0;
    double index = 0.0;

    for (var plot in cagrData) {
      cagrDataTable
          .add(FlSpot(index, double.parse(plot['value'].toStringAsFixed(2))));
      index++;

      if (interval == 0.0) {
        interval = double.parse(plot['value'].toString());
      } else {
        interval = (interval > double.parse(plot['value'].toString()))
            ? interval
            : double.parse(plot['value'].toString());
      }
    }

    int x = 0;
    index = 0.0;
    interval = 0.0;

    for (var plot in cagrValueData) {
      if (x == 2) {
        cdvt.add(FlSpot(index, double.parse(plot['value'].toStringAsFixed(2))));
        index++;
        x = 0;
      }
      x++;
    }

    x = 0;
    index = 0.0;

    for (var plot in cagrDataTable) {
      x++;
      if (x == 2) {
        cdt.add(FlSpot(index, cagrDataTable[(x * index.toInt())].y));
        x = 0;
        index++;
      }
    }

    interval = interval / 4;

    // print(interval);
    return LineChart(LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:
            SideTitles(showTitles: false, reservedSize: 10, interval: 1),
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
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
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
    ));
  }

  /* -------------------------------------------------------------------------- */
  /*          Section: Filter; filters stocks into the required sectors         */
  /* -------------------------------------------------------------------------- */

  List<Map<dynamic, dynamic>> stockFilter(
      List<Map<dynamic, dynamic>> stocks, String sector) {
    List<Map<dynamic, dynamic>> filteredStocks = [];

    for (var stock in stocks) {
      if (stock['marketData']['assets']['sector'] == sector) {
        filteredStocks.add(stock);
      }
    }
    return filteredStocks;
  }

  /* -------------------------------------------------------------------------- */
  /*               Sector: Creates dataTable for the Sector chart               */
  /* -------------------------------------------------------------------------- */

  sectorChart() {
    List<Sectors> sectorChartDataTable = [];

    for (var sector in sectors) {
      // print(sector['value']);
      sectorChartDataTable.add(new Sectors(
          name: sector['name'].toString(),
          value: double.parse(sector['value'].toString())));
    }

    return charts.BarChart(
      [
        charts.Series<Sectors, String>(
            id: 'Sectors',
            domainFn: (Sectors s, _) => s.name,
            measureFn: (Sectors s, _) => s.value,
            data: sectorChartDataTable,
            labelAccessorFn: (Sectors s, _) =>
                '${((s.value / investedValue) * 100).toStringAsFixed(2)} %')
      ],
      animate: true,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      domainAxis: new charts.OrdinalAxisSpec(),
      primaryMeasureAxis:
          new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    );
  }

  /* -------------------------------------------------------------------------- */
  /*                 Section: Creats datatable for stocks chart                 */
  /* -------------------------------------------------------------------------- */

  stocksChart() {
    List<Stocks> stockChartDataTable = [];

    for (var stock in stocks) {
      stockChartDataTable.add(new Stocks(
          name: stock['marketData']['quote']['symbol'],
          value: (double.parse(stock['shares'].toString())) *
              double.parse(stock['buyPrice'].toString())));
    }

    List<charts.Color> co = [
      charts.MaterialPalette.blue.shadeDefault.darker,
      charts.MaterialPalette.red.shadeDefault.darker,
      charts.MaterialPalette.green.shadeDefault.darker,
      charts.MaterialPalette.pink.shadeDefault.darker,
      charts.MaterialPalette.gray.shadeDefault.darker,
      charts.MaterialPalette.yellow.shadeDefault.darker,
      charts.MaterialPalette.lime.shadeDefault.darker,
      charts.MaterialPalette.deepOrange.shadeDefault.darker,
      charts.MaterialPalette.cyan.shadeDefault.darker,
      charts.MaterialPalette.indigo.shadeDefault.darker,
      charts.MaterialPalette.purple.shadeDefault.darker,
      charts.MaterialPalette.teal.shadeDefault.darker,
      charts.MaterialPalette.blue.shadeDefault.lighter,
      charts.MaterialPalette.red.shadeDefault.lighter,
      charts.MaterialPalette.green.shadeDefault.lighter,
      charts.MaterialPalette.pink.shadeDefault.lighter,
      charts.MaterialPalette.gray.shadeDefault.lighter,
      charts.MaterialPalette.yellow.shadeDefault.lighter,
      charts.MaterialPalette.lime.shadeDefault.lighter,
      charts.MaterialPalette.deepOrange.shadeDefault.lighter,
      charts.MaterialPalette.cyan.shadeDefault.lighter,
      charts.MaterialPalette.indigo.shadeDefault.lighter,
      charts.MaterialPalette.purple.shadeDefault.lighter,
      charts.MaterialPalette.teal.shadeDefault.lighter,
    ];

    return Stack(
      children: [
        charts.PieChart(
          [
            new charts.Series<Stocks, String>(
                id: 'Stocks',
                domainFn: (Stocks s, _) => s.name,
                measureFn: (Stocks s, _) => s.value,
                data: stockChartDataTable,
                labelAccessorFn: (Stocks s, _) =>
                    '${s.name}\n${((s.value / investedValue) * 100).toStringAsFixed(2)}%',
                outsideLabelStyleAccessorFn: (Stocks s, _) =>
                    charts.TextStyleSpec(
                      fontSize: 10,
                        color: charts.Color.white), //(r: 32, g: 32, b: 34)),
                colorFn: (_, index) => co[index],
                )                
          ],
          animate: false,
          behaviors: [],
          defaultRenderer: new charts.ArcRendererConfig(arcWidth: 30,
              // startAngle: pi,
              // arcLength: pi,
              arcRendererDecorators: [
                new charts.ArcLabelDecorator(
                    outsideLabelStyleSpec: charts.TextStyleSpec(fontSize: 15),
                    labelPosition: charts.ArcLabelPosition.outside)
              ]),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Investments",
                  style: TextStyle(
                    color: Colors.white,
                  )),
              Text(
                "${stocks.length}",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class Stocks {
  final String name;
  final double value;

  Stocks({this.name, this.value});
}

class Sectors {
  final String name;
  final double value;

  Sectors({this.name, this.value});
}
}

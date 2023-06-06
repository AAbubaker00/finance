import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math' as math;
import 'package:multi_charts/multi_charts.dart';


class SectorCharts extends StatefulWidget {
  @override
  _SectorChartsState createState() => _SectorChartsState();
}

class _SectorChartsState extends State<SectorCharts> {
  List<charts.Series> seriesList;

  Color re = Colors.red;

  static List<charts.Series<Sector, String>> createData() {
    final data = [
      new Sector(
          percentage: 21,
          sector: "Technology",
          color: charts.MaterialPalette.red.shadeDefault),
      new Sector(
          percentage: 10,
          sector: "Finacials",
          color: charts.MaterialPalette.blue.shadeDefault),
      new Sector(
          percentage: 10,
          sector: "Services",
          color: charts.MaterialPalette.yellow.shadeDefault),
      new Sector(
          percentage: 7,
          sector: "Estate",
          color: charts.MaterialPalette.pink.shadeDefault),
      new Sector(
          percentage: 8,
          sector: "Non Cylical",
          color: charts.MaterialPalette.green.shadeDefault),
      new Sector(
          percentage: 44,
          sector: "Transportation",
          color: charts.MaterialPalette.purple.shadeDefault),
    ];

    return [
      charts.Series<Sector, String>(
          id: "Percentage",
          domainFn: (Sector sector, _) => sector.sector,
          measureFn: (Sector sector, _) => sector.percentage,
          data: data,
          colorFn: (Sector sector, _) => sector.color,
          labelAccessorFn: (Sector sector, _) =>
              '${sector.sector} \n ${sector.percentage} stocks')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        charts.PieChart(
          createData(),
          animate: true,
          behaviors: [],
          defaultRenderer: new charts.ArcRendererConfig(
              arcWidth: 30,
              startAngle: 3 / 5 * math.pi,
              arcRendererDecorators: [
                new charts.ArcLabelDecorator(
                    labelPosition: charts.ArcLabelPosition.outside)
              ]),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Investments"), Text("67")],
          ),
        ),
      ],
    );
  }
}

class Sector {
  final String sector;
  final int percentage;
  final charts.Color color;

  Sector(
      {@required this.sector, @required this.percentage, @required this.color});
}

class StockCharts extends StatefulWidget {
  @override
  _StockChartState createState() => _StockChartState();
}

class _StockChartState extends State<StockCharts> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: RadarChart(
            values: [1, 2, 4, 7, 9, 0, 6],
            labels: [
              "Label1",
              "Label2",
              "Label3",
              "Label4",
              "Label5",
              "Label6",
              "Label7",
            ],
            labelColor: Colors.red,
            strokeColor: Colors.grey[400],
            maxValue: 10,
            fillColor: Colors.purple[200],
            chartRadiusFactor: 0.7,
          ),
        ),
      ],
    );
  }
}

class SelectionLineHighlight extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SelectionLineHighlight(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory SelectionLineHighlight.withSampleData() {
    return new SelectionLineHighlight(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,

      
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList, animate: animate, behaviors: [
      new charts.LinePointHighlighter(
      
         
    ]);
  }

  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 22),
      new LinearSales(4, 35),
      new LinearSales(5, 123),
      new LinearSales(6, 145),
      new LinearSales(7, 98),
      new LinearSales(8, 109),
      new LinearSales(9, 90),
      new LinearSales(10, 150),
      new LinearSales(11, 107),
      new LinearSales(12, 200),
      new LinearSales(13, 175),
      new LinearSales(14, 275),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class RTLLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  RTLLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory RTLLineChart.withSampleData() {
    return new RTLLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Charts will determine if RTL is enabled by checking the directionality by
    // requesting Directionality.of(context). This returns the text direction
    // from the closest instance of that encloses the context passed to build
    // the chart. A [TextDirection.rtl] will be treated as a RTL chart. This
    // means that the directionality widget does not have to directly wrap each
    // chart. It is show here as an example only.
    //
    // By default, when a chart detects RTL:
    // Measure axis positions are flipped. Primary measure axis is on the right
    // and the secondary measure axis is on the left (when used).
    // Domain axis' first domain starts on the right and grows left.
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: new charts.LineChart(
          seriesList,
          animate: animate,
        ));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 22),
      new LinearSales(4, 35),
      new LinearSales(5, 123),
      new LinearSales(6, 145),
      new LinearSales(7, 98),
      new LinearSales(8, 109),
      new LinearSales(9, 90),
      new LinearSales(10, 150),
      new LinearSales(11, 107),
      new LinearSales(12, 200),
      new LinearSales(13, 175),
      new LinearSales(14, 275),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

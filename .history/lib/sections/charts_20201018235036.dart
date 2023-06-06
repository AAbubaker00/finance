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
          behaviors: [
          ],
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
          showHorizontalFollowLine:
              charts.LinePointHighlighterFollowLineType.none,
          showVerticalFollowLine:
              charts.LinePointHighlighterFollowLineType.nearest),
      new charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag)
    ]);
  }

  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 22),
      new LinearSales(4, 35),
      new LinearSales(5, 75),
      new LinearSales(6, 75),
      new LinearSales(7, 75),
      new LinearSales(8, 75),
      new LinearSales(9, 75),
      new LinearSales(10, 75),
      new LinearSales(11, 75),
      new LinearSales(12, 75),
      new LinearSales(13, 75),
      new LinearSales(14, 75),
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
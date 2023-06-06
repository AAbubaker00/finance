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

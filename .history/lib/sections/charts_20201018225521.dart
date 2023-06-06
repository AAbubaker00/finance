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
              arcWidth: 15,
              startAngle: 3 / 5 * math.pi,
              arcLength: 7 / 5 * math.pi,
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


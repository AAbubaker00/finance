// ignore_for_file: unnecessary_null_comparison

import 'package:valuid/shared/GeneralObject/generalObject.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CustomCharts {
  CustomCharts(this.context);
  bool isPlotsLoaded = false;
  double interval = 0.0;
  double index = 0.0;
  double crossPoint = 0.0;
  // double invested = 0.0;
  String inceptionDate = '';
  BuildContext context;

  charts.Color getChartColourText(int index) {
    return charts.ColorUtil.fromDartColor(textColor);
  }

  Widget createSampleData(
      {required List<GeneralObject> data,
      required String centerData,
      required DataObject dataObject,
      int selectedIndex = 0}) {
    return charts.BarChart(
      data
          .map((s) => new charts.Series<OrdinalSales, String>(
              id: 'Desktop',
              domainFn: (OrdinalSales sales, _) => sales.year,
              measureFn: (OrdinalSales sales, _) => sales.sales,
              data: [OrdinalSales('0', (s.value! / dataObject.onPortfolio!.invested) * 100)],
              colorFn: (_, index) => selectedIndex == data.indexOf(s)
                  ? charts.ColorUtil.fromDartColor(customColours[data.indexOf(s)])
                  : charts.ColorUtil.fromDartColor(customColours[data.indexOf(s)].withOpacity(.2))))
          .toList(),
      barGroupingType: charts.BarGroupingType.stacked,
      flipVerticalAxis: true,
      behaviors: [new charts.PercentInjector<String>(totalType: charts.PercentInjectorTotalType.domain)],
      layoutConfig: charts.LayoutConfig(
        leftMarginSpec: charts.MarginSpec.fixedPixel(0),
        topMarginSpec: charts.MarginSpec.fixedPixel(0),
        rightMarginSpec: charts.MarginSpec.fixedPixel(0),
        bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
      ),
      primaryMeasureAxis: new charts.PercentAxisSpec(
        renderSpec: charts.NoneRenderSpec()
      ),
      domainAxis: new charts.OrdinalAxisSpec(showAxisLine: false, renderSpec: new charts.NoneRenderSpec()),
      vertical: false,
    );
  }
}

class MyConfig extends charts.ArcRendererConfig {
  var stroke;
  var arcWidth;
  var arcRendererDecorators;
  var strokeWidthPx;
  var isDark;

  MyConfig(this.isDark)
      : this.stroke = charts.ColorUtil.fromDartColor(summaryColour),
        this.arcWidth = 40,
        this.arcRendererDecorators = [
          new charts.ArcLabelDecorator(
              showLeaderLines: false,
              leaderLineColor: charts.ColorUtil.fromDartColor(textColorVarient),
              insideLabelStyleSpec:
                  charts.TextStyleSpec(fontSize: 10, color: charts.ColorUtil.fromDartColor(textColor)),
              labelPosition: charts.ArcLabelPosition.inside)
        ],
        this.strokeWidthPx = 1;
}

class OrdinalSales {
  final String year;
  final num sales;

  OrdinalSales(this.year, this.sales);
}

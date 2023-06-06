// ignore_for_file: unnecessary_null_comparison

import 'package:valuid/shared/CustomeArcRenderer/custome_Arc_Renderer.dart';
import 'package:valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:valuid/shared/GeneralObject/generalObject.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

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

  customePieChart(
      {List<GeneralObject> data,
      List<GeneralObject> secondaryData,
      String centerData,
      DataObject dataObject,
      int selectedIndex = 0}) {
    return Stack(
      children: [
        charts.PieChart(
          [
            new charts.Series<GeneralObject, String>(
              id: 'GeneralObject',
              domainFn: (GeneralObject s, _) => s.name,
              measureFn: (GeneralObject s, _) => s.value,
              data: data,
              labelAccessorFn: (GeneralObject s, _) => '${s.symbol}\n${s.weight.toStringAsFixed(2)}%',
              insideLabelStyleAccessorFn: (GeneralObject s, index) => charts.TextStyleSpec(
                color: getChartColourText(index!),
              ),
              outsideLabelStyleAccessorFn: (GeneralObject s, index) => charts.TextStyleSpec(
                color: getChartColourText(index!),
              ),
              colorFn: (_, index) => selectedIndex == index
                  ? charts.ColorUtil.fromDartColor(customColours[index!].withOpacity(1))
                  : charts.ColorUtil.fromDartColor(customColours[index!].withOpacity(.2)),
            )
          ],
          animate: false,
          defaultRenderer: MyAssetThinHalfConfig(),
          layoutConfig: charts.LayoutConfig(
            leftMarginSpec: charts.MarginSpec.fixedPixel(0),
            topMarginSpec: charts.MarginSpec.fixedPixel(0),
            rightMarginSpec: charts.MarginSpec.fixedPixel(0),
            bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
          ),
        ),
        centerData != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: InkWell(
                  // onTap: centerFunction,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 1.0, right: 1),
                                child: Text('${dataObject.userCurrencySymbol}',
                                    style: CustomTextStyles(dataObject.context).holdingValueStyle),
                              ),
                              Text(
                                  dataObject.onPortfolio.value > 1000000000
                                      ? '${NumberFormat.compact().format(dataObject.onPortfolio.value)}'
                                      : '${dataObject.onPortfolio.value.toStringAsFixed(0).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                  style: CustomTextStyles(dataObject.context)
                                      .calenderTitleTextStyle
                                      .copyWith(fontWeight: FontWeight.w800)),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 1.0, left: .5),
                                child: Text(
                                  '${(dataObject.onPortfolio.value - dataObject.onPortfolio.value.toInt()).toStringAsFixed(2).replaceRange(0, 1, '')}',
                                  style: CustomTextStyles(dataObject.context).holdingValueStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 70, vertical: 5),
                          child: CustomDivider(),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Row(
                            children: [
                              Text(
                                '$centerData',
                                style: CustomTextStyles(context).calenderTitleTextStyle,
                              ),
                              Text(
                                '%',
                                style: CustomTextStyles(context).holdingValueStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Text(''),
      ],
    );
  }

  Widget createSampleData(
      {required List<GeneralObject> data,
      required List<GeneralObject> secondaryData,
      required String centerData,
      required DataObject dataObject,
      int selectedIndex = 0}) {
    return charts.BarChart(
      data
          .map((s) => new charts.Series<OrdinalSales, String>(
              id: 'Desktop',
              domainFn: (OrdinalSales sales, _) => sales.year,
              measureFn: (OrdinalSales sales, _) => sales.sales,
              data: [OrdinalSales('0', (s.value / dataObject.onPortfolio!.invested) * 100)],
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
      primaryMeasureAxis: new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
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

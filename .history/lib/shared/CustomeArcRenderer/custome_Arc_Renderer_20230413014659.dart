import 'package:Valuid/shared/themes/themes.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

class MyAssetConfig extends charts.ArcRendererConfig {
  var stroke;
  var arcWidth;
  var arcRendererDecorators;
  var strokeWidthPx;
  var isDark;

  MyAssetConfig(this.isDark)
      : this.stroke = charts.ColorUtil.fromDartColor(summaryColour),
        this.arcWidth = 70,
        this.arcRendererDecorators = [
          new charts.ArcLabelDecorator(
              // labelPadding: 5,
              showLeaderLines: true,
              // leaderLineColor: charts.ColorUtil.fromDartColor(textColorVarient),
              outsideLabelStyleSpec: charts.TextStyleSpec(
                  fontSize: 15, color: charts.ColorUtil.fromDartColor(textColor)),
              labelPosition: charts.ArcLabelPosition.outside)
        ],
        this.strokeWidthPx = 9;
}

class MyAssetThinHalfConfig extends charts.ArcRendererConfig {
  var stroke;
  var arcWidth;
  // var arcRendererDecorators;
  var strokeWidthPx;
  var isDark;
  var startAngle;
  var arcLength;

  MyAssetThinHalfConfig()
      : this.stroke = charts.ColorUtil.fromDartColor(summaryColour),
        this.arcWidth = 10,
        this.startAngle = pi,
        arcLength = pi,
        // this.arcRendererDecorators = [
        //   new charts.ArcLabelDecorator(
        //       // labelPadding: 5,
        //       showLeaderLines: true,
        //       leaderLineColor: charts.ColorUtil.fromDartColor(textColorVarient),
        //       outsideLabelStyleSpec: charts.TextStyleSpec(
        //           fontSize: 15, color: charts.ColorUtil.fromDartColor(textColor)),
        //       labelPosition: charts.ArcLabelPosition.outside),
        //   // new charts.ArcLabelDecorator(
        //   //     // labelPadding: 5,
        //   //     showLeaderLines: false,
        //   //     leaderLineColor: charts.ColorUtil.fromDartColor(textColorVarient),
        //   //     insideLabelStyleSpec: charts.TextStyleSpec(
        //   //         fontSize: 10, color: charts.ColorUtil.fromDartColor(textColor)),
        //   //     labelPosition: charts.ArcLabelPosition.inside)
        // ],
        this.strokeWidthPx = 1;
}
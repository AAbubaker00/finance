import 'package:Strice/shared/themes/themes.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MyConfig extends charts.ArcRendererConfig {
  // bool isDark = true;
  var stroke;
  var arcWidth;
  var arcRendererDecorators;
  var strokeWidthPx;


class MyAssetConfig extends charts.ArcRendererConfig {
  var stroke;
  var arcWidth;
  // var arcRendererDecorators;
  var strokeWidthPx;
  var isDark;

  MyAssetConfig(this.isDark)
      : this.stroke = charts.ColorUtil.fromDartColor(DarkTheme(isDark).summaryColour),
        this.arcWidth = 20,
        // this.arcRendererDecorators = [
        //   new charts.ArcLabelDecorator(
        //       labelPadding: 5,
        //       showLeaderLines: true,
        //       leaderLineColor: charts.ColorUtil.fromDartColor(DarkTheme(isDark).textColorVarient),
        //       outsideLabelStyleSpec: charts.TextStyleSpec(
        //         fontSize: 15,
        //         color: charts.ColorUtil.fromDartColor(DarkTheme(isDark).textColor)
        //       ),
        //       labelPosition: charts.ArcLabelPosition.outside)
        // ],
        this.strokeWidthPx = 2;
}

class MyAssetThinConfig extends charts.ArcRendererConfig {
  var stroke;
  var arcWidth;
  // var arcRendererDecorators;
  var strokeWidthPx;
  var isDark;

  MyAssetThinConfig(this.isDark)
      : this.stroke = charts.ColorUtil.fromDartColor(DarkTheme(isDark).summaryColour),
        this.arcWidth = 5,
        // this.arcRendererDecorators = [
        //   new charts.ArcLabelDecorator(
        //       labelPadding: 5,
        //       showLeaderLines: true,
        //       leaderLineColor: charts.ColorUtil.fromDartColor(DarkTheme(isDark).textColorVarient),
        //       outsideLabelStyleSpec: charts.TextStyleSpec(
        //         fontSize: 15,
        //         color: charts.ColorUtil.fromDartColor(DarkTheme(isDark).textColor)
        //       ),
        //       labelPosition: charts.ArcLabelPosition.outside)
        // ],
        this.strokeWidthPx = 2;
}

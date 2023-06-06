import 'package:charts_common/src/chart/cartesian/axis/spec/axis_spec.dart' show LineStyleSpec;
// ignore: implementation_imports
import 'package:charts_common/src/common/color.dart' show Color;
// ignore: implementation_imports
import 'package:charts_common/src/common/graphics_factory.dart' show GraphicsFactory;
// ignore: implementation_imports
import 'package:charts_common/src/common/line_style.dart' show LineStyle;
// ignore: implementation_imports
import 'package:charts_common/src/common/style/style.dart' show Style;
// ignore: implementation_imports
import 'package:charts_common/src/common/material_palette.dart' show MaterialPalette;
// ignore: implementation_imports
import 'package:charts_common/src/common/palette.dart' show Palette;
import 'package:charts_flutter/flutter.dart';
// import 'package:stonks/consts.dart';


class CustomMaterialStyle implements Style {
  const CustomMaterialStyle();

  @override
  Color get black => MaterialPalette.black;

  @override
  Color get transparent => MaterialPalette.transparent;

  @override
  Color get white => MaterialPalette.white;

  @override
  List<Palette> getOrderedPalettes(int count) =>
      MaterialPalette.getOrderedPalettes(count);

  @override
  LineStyle createAxisLineStyle(
      GraphicsFactory graphicsFactory, LineStyleSpec spec) {
    return graphicsFactory.createLinePaint()
      ..color = spec?.color ?? MaterialPalette.gray.shadeDefault
      ..dashPattern = spec?.dashPattern
      ..strokeWidth = spec?.thickness ?? 1;
  }

  @override
  LineStyle createTickLineStyle(
      GraphicsFactory graphicsFactory, LineStyleSpec spec) {
    return graphicsFactory.createLinePaint()
      ..color = spec?.color ?? MaterialPalette.gray.shadeDefault
      ..dashPattern = spec?.dashPattern
      ..strokeWidth = spec?.thickness ?? 1;
  }

  @override
  int get tickLength => 3;

  @override
  Color get tickColor => MaterialPalette.gray.shade800;

  @override
  LineStyle createGridlineStyle(
      GraphicsFactory graphicsFactory, LineStyleSpec spec) {
    return graphicsFactory.createLinePaint()
      ..color = spec?.color ?? MaterialPalette.gray.shade300
      ..dashPattern = spec?.dashPattern
      ..strokeWidth = spec?.thickness ?? 1;
  }

  @override
  Color get arcLabelOutsideLeaderLine => MaterialPalette.gray.shade600;

  @override
  Color get defaultSeriesColor => MaterialPalette.gray.shadeDefault;

  @override
  Color get arcStrokeColor => ColorUtil.fromDartColor(Colors.red);

  @override
  Color get legendEntryTextColor => MaterialPalette.gray.shade800;

  @override
  Color get legendTitleTextColor => MaterialPalette.gray.shade800;

  @override
  Color get linePointHighlighterColor => MaterialPalette.gray.shade600;

  @override
  Color get noDataColor => MaterialPalette.gray.shade200;

  @override
  Color get rangeAnnotationColor => MaterialPalette.gray.shade100;

  @override
  Color get sliderFillColor => MaterialPalette.white;

  @override
  Color get sliderStrokeColor => MaterialPalette.gray.shade600;

  @override
  Color get chartBackgroundColor => MaterialPalette.white;

  @override
  double get rangeBandSize => 0.65;
}
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      mainData(),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(showTitles: false, reservedSize: 10),
        leftTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
                  color: Color(0xff67727d),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
            reservedSize: 28,
            interval: 500,
            
            ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 50),
            FlSpot(1, 250),
            FlSpot(2, 1000),
            FlSpot(3, 220),
            FlSpot(4, 350),
            FlSpot(5, 1230),
            FlSpot(6, 1450),
            FlSpot(7, 980),
            FlSpot(8, 1090),
            FlSpot(9, 900),
            FlSpot(10, 1500),
            FlSpot(11, 1070),
            FlSpot(12, 2000),
            FlSpot(13, 1750),
            FlSpot(14, 2750),
          ],
          isCurved: true,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}

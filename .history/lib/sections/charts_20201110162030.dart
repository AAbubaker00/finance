import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  @override
  Widget build(BuildContext context) {
    return LineChart(mainData(),
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
        bottomTitles: SideTitles(
          showTitles: false,
          reservedSize: 10
        ),

        leftTitles: SideTitles(
          showTitles: false
        ),

        rightTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          reservedSize: 0,
          interval: 100
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 5),
      FlSpot(1, 25),
      FlSpot(2, 100),
      FlSpot(3, 22),
      FlSpot(4, 35),
      FlSpot(5, 123),
      FlSpot(6, 145),
      FlSpot(7, 98),
      FlSpot(8, 109),
      FlSpot(9, 90),
      FlSpot(10, 150),
      FlSpot(11, 107),
      FlSpot(12, 200),
      FlSpot(13, 175),
      FlSpot(14, 275),
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

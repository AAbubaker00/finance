class Analysis{
   List cuReturnPeriods = [
    {'period': 30, 'return': 0.0, 'id': '1-Month'},
    {'period': 90, 'return': 0.0, 'id': '3-Months'},
    {'period': 180, 'return': 0.0, 'id': '6-Months'},
    {'period': 265, 'return': 0.0, 'id': '1-year'},
    {'period': 1095, 'return': 0.0, 'id': '3-years'},
    {'period': 1825, 'return': 0.0, 'id': '5-years'}
  ];
  List<BarChartGroupData> crpCDT = [];
  getCumativeReturn() {
    crpCDT.clear();
    for (var period in cuReturnPeriods) {
      if (period['period'] < performance.length) {
        double endValue = performance[performance.length - 1]['value'];

        double startValue = performance[performance.length - period['period']]['value'];
        double periodReturn = ((endValue - startValue) / investedValue) * 100;

        period['return'] = periodReturn;
      }
    }

    // print(cuReturnPeriods);

    cuReturnPeriods = cuReturnPeriods.where((element) => element['return'] != 0.0).toList();

    int index = 0;

    for (var period in cuReturnPeriods) {
      crpCDT.add(BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            borderRadius: BorderRadius.circular(5),
            y: period['return'],
            width: 25,
            // gradientFrom: Offset(1, -1),
            // gradientTo: Offset(1, 1),
            // gradientColorStops: [.70, 1],

            colors: [VarientColours().customColours[index]],
          ),
        ],
        barsSpace: 10,
        showingTooltipIndicators: [0],
      ));

      index++;
    }

    index = 0;

    return BarChart(
      BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              // fitInsideVertically: true,
              fitInsideHorizontally: true,
              tooltipBgColor: Colors.transparent,
              tooltipPadding: EdgeInsets.all(0),

              tooltipMargin: 5,
              getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
              ) {
                return BarTooltipItem(
                  '${rod.y.toStringAsFixed(2)}%',
                  TextStyle(
                    color: DarkTheme(isDark).textColor,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) => TextStyle(
                  color: DarkTheme(isDark).textColorVarient, fontWeight: FontWeight.w500, fontSize: 15),
              margin: 30,
              getTitles: (double value) {
                // String txt = value.toInt() == 0
                //     ? '${DateFormat('dd-MM-yyyy').format(inception_Date)} \nto \n${inception_Date.year}-12-31'
                //     : '${years[value.toInt() - 1]['id']}-12-31 \nto \n${years[value.toInt()]['id']}-12-31';

                // return 'FY ${years[value.toInt()]['id']}';
                // print(0]['id']);
                // print(value);

                int index = value.toInt();

                return cuReturnPeriods[index]['id'].toString();
              },
            ),
            leftTitles: SideTitles(showTitles: false),
          ),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) =>
                FlLine(color: DarkTheme(isDark).border.withOpacity(.3), strokeWidth: 1),
            horizontalInterval: 20,
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: crpCDT),
    );
  }

  
}
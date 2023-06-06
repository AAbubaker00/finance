import 'package:Onvest/shared/printFunctions/custom_Print_Functions.dart';
import 'package:http/http.dart' as http;
// import 'package:csv/csv.dart' as csv;

class Stooq {
  final String _fixedEndPoint = 'https://stooq.com/q/d/l/?s=^spx&i=d';
  List snpHistoricalData = [];
  List snpStandardFormat = [];

  Future<Map> getGSPCHistoricalData({DateTime inceptionDate}) async {
    try {
      // print('here');
      // Stopwatch sp = Stopwatch();
      // sp.start();

      http.Response response = await http.get(Uri.parse(_fixedEndPoint));

      if (response.statusCode == 200) {
        var conv // = csv.CsvToListConverter().convert(response.body);

        conv.removeAt(0);
        conv.removeWhere((dataPoint) => inceptionDate.isAfter(DateTime.parse(dataPoint[0])));

        for (var dataPoint in conv) {
          snpStandardFormat.add({'date': DateTime.parse(dataPoint[0]), 'value': dataPoint[4]});

          if (snpHistoricalData.isEmpty) {
            snpHistoricalData.add({
              'id': DateTime.parse(dataPoint[0]).year,
              'dataPoints': [
                {
                  'date': dataPoint[0],
                  'open': dataPoint[1],
                  'high': dataPoint[2],
                  'low': dataPoint[3],
                  'close': dataPoint[4],
                }
              ]
            });
          } else {
            var isSnPHistoricalYearExist = snpHistoricalData
                .firstWhere((year) => year['id'] == DateTime.parse(dataPoint[0]).year, orElse: () => null);

            if (isSnPHistoricalYearExist == null) {
              snpHistoricalData.add({
                'id': DateTime.parse(dataPoint[0]).year,
                'dataPoints': [
                  {
                    'date': dataPoint[0],
                    'open': dataPoint[1],
                    'high': dataPoint[2],
                    'low': dataPoint[3],
                    'close': dataPoint[4],
                  }
                ]
              });
            } else {
              isSnPHistoricalYearExist['dataPoints'].add({
                'date': dataPoint[0],
                'open': dataPoint[1],
                'high': dataPoint[2],
                'low': dataPoint[3],
                'close': dataPoint[4],
              });
            }
          }
        }

        for (var year in snpHistoricalData) {
          var firstDataPoint = year['dataPoints'].first;
          var lastDataPoint = year['dataPoints'].last;

          year['roi'] = ((lastDataPoint['close'] - firstDataPoint['open']) / firstDataPoint['open']) * 100;
          year['roi_value'] = (lastDataPoint['close'] - firstDataPoint['open']);

          for (var dataPoint in year['dataPoints']) {
            dataPoint['roi'] = ((dataPoint['close'] - firstDataPoint['open']) / firstDataPoint['open']) * 100;
            dataPoint['roi_value'] = dataPoint['close'] - firstDataPoint['open'];
            // dataPoint['roi_value_per'] = dataPoint['close'] - firstDataPoint['open'];
          }
        }

        // sp.stop();
        // print(sp.elapsed);

        // print(snpHistoricalData);

        return {'snpYearFormat': snpHistoricalData, 'snpSTDFormat': snpStandardFormat};
      }

      return {};
    } catch (e) {
      PrintFunctions().printError(e);

      return {};
    }
  }
}

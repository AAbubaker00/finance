import 'package:Valuid/services/yahooapi/yahoo_api_provider.dart';
import 'package:Valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Valuid/shared/update/initialise.dart';
import 'package:Valuid/extensions/stringExt.dart';
import 'dart:math' as math;

class CAGR {
  cargTimelineSort(var asset) {
    int removeIndex = asset['marketData']['chartData']['max']['timestamp'].indexOf(asset['buyDate']);

    asset['useTime'] = asset['marketData']['chartData']['max']['timestamp']
        .getRange(removeIndex, asset['marketData']['chartData']['max']['timestamp'].length - 1)
        .toList();

    asset['usePrice'] = asset['marketData']['chartData']['max']['close']
        .getRange(removeIndex, asset['marketData']['chartData']['max']['close'].length - 1)
        .toList();

    return asset;
  }

  setCAGRData(Map data) async {
    List stocks = data['assets'], cagrData = [];
    String baseCurrency = data['currency'];
    Map rates = data['rates'];

    // inceptionDate = getInceptionDae(stocks);

    for (var stock in stocks) {
      // PrintFunctions().printArrivalLine();

      if (stock['marketData']['chartData']['max']['timestamp'].last == stock['buyDate']) {
        stock['marketData']['chartData']['max'] =
            await YahooApiService().getYahooChartData(symbol: stock['symbol'], exchange: stock['exchange']);
      }

      int removeIndex = stock['marketData']['chartData']['max']['timestamp'].indexOf(stock['buyDate']);

      stock['useTime'] = stock['marketData']['chartData']['max']['timestamp']
          .getRange(removeIndex, stock['marketData']['chartData']['max']['timestamp'].length - 1)
          .toList();

      stock['usePrice'] = stock['marketData']['chartData']['max']['close']
          .getRange(removeIndex, stock['marketData']['chartData']['max']['close'].length - 1)
          .toList();
    }

    // print('here');
    for (var stock in stocks) {
      if (stocks.length > 2) {
        stock['history']
            .sort((a, b) => DateTime.parse(a['filledOn']).compareTo(DateTime.parse(b['filledOn'])));
        stock['history'] = stock['history'].reversed.toList();
      }

      String quote = stock['marketData']['quote']['currency'].toString().capitalizeAll();
      double cvrtRate ;//= Initialise(baseCurrency: baseCurrency).getRate(rates, quote);

      for (var date in stock['useTime']) {
        var lastEvent = stock['history'].firstWhere(
            (event) =>
                DateTime.parse(event['filledOn']).isBefore(DateTime.parse(date)) || event['filledOn'] == date,
            orElse: () => null);

        if (lastEvent == null) {
          // print(lastEvent);
        } else {
          try {
            // print(lastEvent);
            double assetTotalShares = double.parse(lastEvent['outstandingShares'].toString());
            double assetAveragePrice = double.parse(lastEvent['averagePrice'].toString()) * cvrtRate;

            int dateIndex = stock['useTime'].indexOf(date);
            double priceAtDateIndex =
                (stock['usePrice'][dateIndex] / (stock['exchange'] == 'LSE' ? 100 : 1)) * cvrtRate;

            if (cagrData.isEmpty) {
              cagrData.add({
                'date': date,
                'value': ((priceAtDateIndex - assetAveragePrice) * assetTotalShares) +
                    (assetTotalShares * assetAveragePrice),
                'invested': assetTotalShares * assetAveragePrice,
                'assets': 1
              });
            } else {
              var isEventExist = cagrData.firstWhere((event) => event['date'] == date, orElse: () => null);

              if (isEventExist == null) {
                cagrData.add({
                  'date': date,
                  'value': ((priceAtDateIndex - assetAveragePrice) * assetTotalShares) +
                      (assetTotalShares * assetAveragePrice),
                  'invested': assetTotalShares * assetAveragePrice,
                  'assets': 1
                });
              } else {
                int eventIndex = cagrData.indexOf(isEventExist);

                try {
                  cagrData[eventIndex]['value'] +=
                      ((priceAtDateIndex - assetAveragePrice) * assetTotalShares) +
                          (assetTotalShares * assetAveragePrice);
                  cagrData[eventIndex]['invested'] += (assetTotalShares * assetAveragePrice);
                  cagrData[eventIndex]['assets'] += 1;
                } on Exception catch (e) {
                  print(e);
                }
              }
            }
          } catch (e) {
            PrintFunctions().printError(e);
          }
        }
      }
    }


    cagrData.sort((a, b) => DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])));

    cagrData = cagrData
        .where((plot) => !(cagrData.indexOf(plot) != 0 &&
            cagrData.indexOf(plot) < cagrData.length - 1 &&
            (plot['assets'] < cagrData[cagrData.indexOf(plot) + 1]['assets'] &&
                plot['assets'] < cagrData[cagrData.indexOf(plot) - 1]['assets'])))
        .toList();

    // sp.stop();
    // print(sp.elapsed);

    print(cagrData);
    return cagrData;
  }

  getCurrentYearReturn(List cagr) {
    var first = cagr.firstWhere((date) => DateTime.parse(date['date']).year == DateTime.now().year);
    var last = cagr.last;

    return last['value'] - first['value'];
  }

  getCAGRGrowth(List cagr) {
    var first = cagr.first;
    var last = cagr.last;

    print(first);
    print(last);

    print(DateTime.parse(first['date']).difference(DateTime.parse(last['date'])).inDays.abs());
    print(last['value'] / last['invested']);

    return (math.pow((last['value'] / last['invested']),
            365 / (DateTime.parse(first['date']).difference(DateTime.parse(last['date'])).inDays.abs()))) -
        1;
  }

  //hi

}

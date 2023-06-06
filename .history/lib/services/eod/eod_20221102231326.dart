import 'package:http/http.dart' as http;
import 'package:Valuid/extensions/stringExt.dart';

class EodHistoricalData {
  //! https://eodhistoricaldata.com/img/logos/US/MSFT.png

  Future<String> getLogo(String symbol, String exchange) async {
    try {
      int x = 0;
      while (x != 2) {
        if (exchange.capitalizeAll() == 'NASDAQGS' ||
            exchange.capitalizeAll() == 'NYSE' ||
            exchange.capitalizeAll() == 'AMEX' ||
            exchange.capitalizeAll() == 'NYQ' ||
            exchange.capitalizeAll() == 'NASDAQ' ||
            exchange.capitalizeAll() == 'NMS') {
          if (x == 0) {
            Uri uri = Uri.parse("https://eodhistoricaldata.com/img/logos/US/${symbol.toLowerCase()}.png");
            // print(uri);

            http.Response response = await http.get(uri);

            if (response.statusCode == 200) {
              // print(uri);
              return uri.toString();
            }
          } else if (x == 1) {
            Uri uri = Uri.parse("https://eodhistoricaldata.com/img/logos/US/${symbol.capitalizeAll()}.png");
            // print(uri);

            http.Response response = await http.get(uri);

            if (response.statusCode == 200) {
              return uri.toString();
            } else {
              return null;
            }
          }
        }

        x++;
      }

      return 
    } catch (e) {
      print('////////////////////////////');
      print(e.toString());
      print('////////////////////////////');
    }

    // try {
    //   for (var stock in Stocks) {
    //     int x = 0;

    //     print(stock['symbol']);

    //     if (stock['marketData']['quote']['fullExchangeName'].toString().capitalizeAll() == 'NASDAQGS' ||
    //         stock['marketData']['quote']['fullExchangeName'].toString().capitalizeAll() == 'NYSE' ||
    //         stock['marketData']['quote']['fullExchangeName'].toString().capitalizeAll() == 'AMEX') {
    //       while (x != 2) {
    //         switch (x) {
    //           case 0:
    //             uri = Uri.parse(
    //                 "https://eodhistoricaldata.com/img/logos/US/${stock['symbol'].toString().toLowerCase()}.png");
    //             response = await http.get(uri);

    //             if (response.statusCode == 200) {
    //               print(uri);
    //               stock['logo'] = uri;
    //               x = 2;
    //             } else {
    //               stock['logo'] = null;
    //             }
    //             break;
    //           case 1:
    //             uri = Uri.parse(
    //                 "https://eodhistoricaldata.com/img/logos/US/${stock['symbol'].toString().capitalizeAll()}.png");

    //             response = await http.get(uri);

    //             if (response.statusCode == 200) {
    //               print(uri);
    //               stock['logo'] = uri;
    //               x = 2;
    //             } else {
    //               stock['logo'] = null;
    //             }
    //             break;
    //         }

    //         x++;
    //       }
    //     }
    //     // else if (stock['marketData']['quote']['fullExchangeName'].toString().capitalizeAll() == 'LSE') {
    //   String symbol = stock['marketData']['quote']['symbol'];
    //   symbol = symbol.replaceAll(RegExp('.L'), '');

    //   while (x != 2) {
    //     switch (x) {
    //       case 0:
    //         uri = Uri.parse(
    //             "https://eodhistoricaldata.com/img/logos/LSE/${symbol.toString().toLowerCase()}.png");

    //         response = await http.get(uri);
    //         break;
    //       case 1:
    //         uri = Uri.parse(
    //             "https://eodhistoricaldata.com/img/logos/LSE/${symbol.toString().capitalizeAll()}.png");

    //         response = await http.get(uri);
    //         break;
    //     }

    //     if (response.statusCode == 200) {
    //       String uriStr = uri.toString().replaceAll(RegExp('https://'), '');
    //       stock['logo']['logo'] = uriStr;
    //       x = 2;
    //     } else {
    //       stock['logo']['logo'] = null;
    //     }

    //     x++;
    //   }
    // }
    // }
    // } on Exception catch (e) {
    //   // TODO

    //   print(e.toString());
    // }

    // return Stocks;
  }
}

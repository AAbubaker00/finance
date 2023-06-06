import 'package:valuid/extensions/stringExt.dart';
import 'package:valuid/models/quote/quote.dart';
import 'package:valuid/shared/dividends/dividends.dart';
import 'package:valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

String _sFixedEndPoint = 'https://www.marketbeat.com/stocks/';
String _sDividendsEndPoint = '/dividend/';

String exchange = '', symbol = '';

class Marketbeat {
  // ignore: missing_return
  Future<List<Dividends>> getDividends({List<QuoteObject> holdings}) async {
//Getting the response from the targeted url

    List<Dividends> dividends = [];
    List<Dividends> removeDividends = [];

    // var holding;
    // for (var holding in holdings) {
    try {
      // exchangeCheck(holding);
      _sFixedEndPoint = 'https://www.marketbeat.com/stocks/';

      //! https://www.marketbeat.com/stocks/NASDAQ/AAPL/dividend/?__cf_chl_tk=M1yYZLX2sGVGxyxWO4Ex3ove52GyNzJCXYh3u_3l21g-1657707977-0-gaNycGzNCD0

      // _sFixedEndPoint = _sFixedEndPoint +
      //     '$exchange/' +
      //     '${holding.symbol.capitalizeAll().replaceAll('.L', '')}' +
      //     '$_sDividendsEndPoint';

      PrintFunctions().printStartEndLine(_sFixedEndPoint);

      final response =
          await http.Client().get(Uri.parse('https://www.marketbeat.com/stocks/NASDAQ/AAPL/dividend/'));

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);

        int childIndex = 0;
        int index = 0;

        print(document.getElementsByClassName('scroll-table sort-table fixed-header').)

        for (var child in document.getElementsByClassName('scroll-table sort-table fixed-header')) {
          print(child);
          // if (child.id == 'dividend-history') {
          //   childIndex = index;

          //   print(child);
          // }
          index++;
        }

        var tabContentResponse = document.getElementById('tabContentDividends');
        var tableContentResponse = tabContentResponse.children[childIndex + 1].children[1];

        for (var element in tableContentResponse.children) {
          if (element.children.length == 7 && element.children[3].text.isNotEmpty) {
            // var div = Dividends.fromElement(element, holding);

            // if (dividends.isEmpty ||
            //     dividends.firstWhere(
            //             (divCheck) =>
            //                 divCheck.exDate == div.exDate &&
            //                 divCheck.record == div.record &&
            //                 divCheck.date == div.date,
            //             orElse: () => null) ==
            //         null) {
            //   dividends.add(Dividends.fromElement(element, holding));
            // }
          }
        }
      }
    } catch (e) {
      // PrintFunctions().printError(holding.name + ': ' + e.toString());
    }
    // }

    for (var dividend in dividends) {
      var inputFormat = DateFormat('MM/dd/yyyy');
      var outputFormat = DateFormat('yyyy-MM-dd');

      if (dividend.date.isNotEmpty &&
          dividend.exDate.isNotEmpty &&
          dividend.date != '' &&
          dividend.exDate != '' &&
          dividend.date != null &&
          dividend.exDate != null) {
        var inputExDate = inputFormat.parse(dividend.exDate);
        dividend.exDate = outputFormat.format(inputExDate);

        var inputAnnouncedDate = inputFormat.parse(dividend.announced);
        dividend.announced = outputFormat.format(inputAnnouncedDate);

        var inputPaymentDate = inputFormat.parse(dividend.date);
        dividend.date = outputFormat.format(inputPaymentDate);

        var inputRecordDate = inputFormat.parse(dividend.record);
        dividend.record = outputFormat.format(inputRecordDate);
      } else {
        removeDividends.add(dividend);
      }
    }

    for (var dividend in removeDividends) {
      dividends.remove(dividend);
    }

    dividends =
        dividends.where((divided) => DateTime.parse(divided.date).year == DateTime.now().year).toList();

    return dividends;
  }

  Future<List> getNews(QuoteObject holding) async {
    try {
      _sFixedEndPoint = 'https://www.marketbeat.com/stocks/';
      exchangeCheck(holding);

      _sFixedEndPoint = _sFixedEndPoint + '$exchange/' + '${holding.symbol}}';
      // print(_sFixedEndPoint);

      final response = await http.Client().get(
        Uri.parse(
          _sFixedEndPoint,
        ),
      );

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);

        var responseString1 = document.getElementsByClassName('mt-1 bg-white light-shadow d-flex');

        responseString1 =
            responseString1.length < 10 ? responseString1 : responseString1.getRange(0, 10).toList();

        // print(responseString1.length);

        responseString1.forEach((element) {
          var imgURL = element.getElementsByClassName('p-2 text-center')[0].children[0].attributes['src'];
          if (imgURL[0] == '/') {
            imgURL = 'https://www.marketbeat.com/' + imgURL;
          }
          // print(imgURL);

          // var date = element.children[1].children[0].text.replaceRange(
          //     element.children[1].children[0].text.indexOf('|'),
          //     element.children[1].children[0].text.length,
          //     '');

          // // print(date);

          // var title = element.children[1].children[1].text;
          // // print(title);

          // var src = element.children[1].children[1].attributes['href'];
          // // print(src);

          // var description = '';

          // if (element.children[1].children.length > 2) {
          //   description = element.children[1].children[2].text;
          // }

          // print(description);

          // print('object');

          // news.add(NewsObject(
          //     date: date,
          //     title: title,
          //     src: src,
          //     description: description,
          //     imgURL: imgURL,
          //     provider: 'Marketbeat'));
        });
      }

      // print(news.length);

      return [];
    } catch (e) {
      PrintFunctions().printStartEndLine(e.toString());
      return [];
    }
  }

  Future<QuoteObject> getMarketbeatQuote(Map result) async {
    try {
      preCheck(result);

      String uri = 'https://www.marketbeat.com/stocks/$exchange/$symbol/';

      final response = await http.Client().get(Uri.parse(uri));

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);

        // print(document.getElementsByClassName('PageTitleHOne').first.text.replaceRange(
        //     document.getElementsByClassName('PageTitleHOne').first.text.indexOf('('),
        //     document.getElementsByClassName('PageTitleHOne').first.text.length,
        //     ''));
        // var r = QuoteObject.fromMap(document, s: result['symbol'], e: result['exchDisp'], n: result['name']);
        // print(r.name);

        return QuoteObject.fromMap(document, s: result['symbol'], e: result['exchDisp'], n: result['name']);
      }
    } catch (e) {
      // TODO

      PrintFunctions().printError('getMarketbeatQuote: $e');
    }
  }

  Future<List<QuoteObject>> getMarketbeatQuoteList(List<QuoteObject> holdings) async {
    try {
      List<Future> resposeFutures = List.generate(
          holdings.length,
          (index) => http.Client().get(Uri.parse(
              'https://www.marketbeat.com/stocks/${getExchange(holdings[index])}/${getSymbol(holdings[index])}/')));

      List response = await Future.wait(resposeFutures);

      List<QuoteObject> responseJson = List.generate(
          response.length,
          (index) => QuoteObject.fromMap(parser.parse(response[index].body),
              s: holdings[index].symbol, e: holdings[index].exchange));

      return responseJson;
    } catch (e) {
      // TODO

      PrintFunctions().printError('getMarketbeatQuoteList: $e');
      return [QuoteObject()];
    }
  }

  exchangeCheck(QuoteObject holding) {
    switch (holding.exchange) {
      case 'NasdaqGS':
        exchange = 'NASDAQ';
        break;
      case 'LSE':
        exchange = 'LON';
        break;
      default:
        exchange = holding.exchange;
        break;
    }
  }

  preCheck(Map result) {
    switch (result['exchDisp']) {
      case 'NasdaqGS':
        exchange = 'NASDAQ';
        symbol = result['symbol'];
        break;
      case 'LSE':
        exchange = 'LON';
        symbol = result['symbol'].toString().capitalizeAll().replaceAll('.L', '');
        break;
      default:
        exchange = result['exchDisp'];
        symbol = result['symbol'];

        break;
    }
  }

  getSymbol(QuoteObject result) {
    switch (result.exchange) {
      case 'NasdaqGS':
        return result.symbol;
        break;
      case 'LSE':
        return result.symbol.toString().capitalizeAll().replaceAll('.L', '');
        break;
      default:
        return result.symbol;

        break;
    }
  }

  getExchange(QuoteObject result) {
    switch (result.exchange) {
      case 'NasdaqGS':
        return 'NASDAQ';
        break;
      case 'LSE':
        return 'LON';
        break;
      default:
        return result.exchange;
        break;
    }
  }
}

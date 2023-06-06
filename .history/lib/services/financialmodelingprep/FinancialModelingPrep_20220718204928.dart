import 'dart:convert';
import 'package:Valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:http/http.dart' as http;

class FinancialModelingPrep {
  String _sDividendEndPoint = 'https://financialmodelingprep.com/api/v3/stock_dividend_calendar?from=';
  String _sSplitter = '&to=';

  String _key = '&apikey=4036bedb1d23e6799b48f34fc942ffdb';

  List userDividends = [];

  // 'https://financialmodelingprep.com/api/v3/stock_dividend_calendar?from=2020-12-01&to=2021-12-01&apikey=4036bedb1d23e6799b48f34fc942ffdb'
// https://financialmodelingprep.com/api/v3/stock_dividend_calendar?from=2020-06-01&to=2020-09-10&apikey=4036bedb1d23e6799b48f34fc942ffdb
  Future<List> getDividends(List stocks) async {
    // print(stocks.length);
    var month = DateTime.now().month;
    var endMonth = DateTime.now().month;

    var monthSTR = month < 10 ? '0${month - 1}' : (month - 1).toString();
    var endMonthSTR = month < 7 ? '0${endMonth + 2}' : '${endMonth + 2}';

    _sDividendEndPoint = _sDividendEndPoint +
        '${DateTime.now().year}' +
        '-$monthSTR-' +
        '${DateTime.now().day}' +
        '$_sSplitter' +
        '${DateTime.now().year}-' +
        '$endMonthSTR'
            '-${DateTime.now().day}' +
        '$_key';

    // print(_sDividendEndPoint);

    try {
      http.Response response = await http.get(Uri.parse(_sDividendEndPoint));

      if (response.statusCode == 200) {
        var responseJson = await json.decode(response.body);

        List reponseJsonToList = responseJson;

        print(reponseJsonToList);

        for (var stock in stocks) {
          // print(stock['symbol']);
          List isRequiredDividends =
              reponseJsonToList.where((dividend) => dividend['symbol'] == stock['symbol']).toList();
          // responseJson.where((dividend) => dividend['symbol'] == stock, orElse: () => null);

          // print(isRequiredDividends);



          if (isRequiredDividends != null ) {
            for (var dividend in isRequiredDividends) {
              
              dividend['shares'] = stock['shares'];
              dividend['totalPayment'] = stock['shares'] * dividend['adjDividend'];

              if (dividend['paymentDate'] != null) {
                if (dividend['paymentDate'][6] == '-') {
                  dividend['paymentDate'] =
                      dividend['paymentDate'].replaceRange(5, 6, '0${dividend['paymentDate'][5]}');
                }
              }

              userDividends.add(dividend);
            }
          }
        }

        return userDividends;
      }

      return [];
    } catch (e) {
      PrintFunctions().printError(e);

      return [];
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:valuid/models/stocktwits/stocktwits_object.dart';
import 'package:valuid/shared/printFunctions/custom_Print_Functions.dart';

class StockTwits {
  final _sFixedEndPoint =
      "https://api.stocktwits.com/api/2/discover/earnings_calendar?date_from=2023-01-01&date_to=2023-12-31";

  getCurrentYearEarnings() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.stocktwits.com/api/2/discover/earnings_calendar?date_from=${DateTime.now().year}-01-01&date_to=${DateTime.now().year}-12-31"));

    if (response.statusCode == 200) {
      var responseJSON = await json.decode(response.body);

      // print(responseJSON['earnings'].runtimeType);

      List earnings = [], holdings = ['AAPL', 'MAIN', 'AMZN'];

      (responseJSON['earnings'] as Map).forEach((key, value) {
        print((value['stocks'] as List).where((element) => false));
      });
    }
  }
}

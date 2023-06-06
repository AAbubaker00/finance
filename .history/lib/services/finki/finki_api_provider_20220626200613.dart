import 'dart:convert';
import 'package:Onvest/shared/printFunctions/custom_Print_Functions.dart';
import 'package:http/http.dart' as http;

class FinkApiService {
// https://www.finki.io/callAPI.php?isin=GB00BH4HKS39&function=dividendData&key=aa297f1nk1
//https://finki.io/isinAPI.php?ticker=LSE:lloy

  // ignore: non_constant_identifier_names
  String _sFixedEndPoint_apiCall = "https://www.finki.io/callAPI.php?isin=";
  // ignore: non_constant_identifier_names
  String _sFixedEndPoint_isinCall = "https://finki.io/isinAPI.php?ticker=";
  String _dividendEndPoint = "&function=dividendData&key=aa297f1nk1";

  Future<Map<String, dynamic>> getDividendData({String exchange, String symbol}) async {
    try {
      _sFixedEndPoint_isinCall = _sFixedEndPoint_isinCall + "$exchange:$symbol";
      http.Response response = await http.get(Uri.parse(_sFixedEndPoint_isinCall));
      if (response.statusCode == 200) {
        _sFixedEndPoint_apiCall = _sFixedEndPoint_apiCall + '${response.body}' + _dividendEndPoint;
        response = await http.get(Uri.parse(_sFixedEndPoint_apiCall));

        if (response.statusCode == 200) {
          var responseJson = await json.decode(response.body);
          responseJson = responseJson[0];

          // print(responseJson);
          return responseJson;
        }
      }
      return {};
    } catch (e) {
      PrintFunctions().printError(e);
      return {};
    }
  }
}

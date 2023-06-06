import 'dart:convert';
import 'package:Valuid/shared/earnings/earnings.dart';
import 'package:Valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

//! https://commodities-api.com/api/symbols?access_key=5ppvoro5ot7i7m76xsbzz5qyyzk7h4dmnx35dy28c4foj0q4swvvmlqa497q

String _sFixedEndPoint =
    'https://commodities-api.com/api/latest?access_key=5ppvoro5ot7i7m76xsbzz5qyyzk7h4dmnx35dy28c4foj0q4swvvmlqa497q&base=USD&symbols=RICE%2CWHEAT%2CSUGAR%2CCORN%2CWTIOIL%2CBRENTOIL%2CSOYBEAN%2CCOFFEE%2CXAU%2CXAG%2CXPD%2CXPT%2CXRH%2CRUBBER%2CETHANOL%2CCPO%2CNG%2CLUMBER%2CCOTTON%2CROBUSTA%2CCOCOA%2CTIN%2CCANO%2CCOAL%2CLCO%2CXCU%2CETHANOL%2CNG%2CNI%2COAT%2CZNC';

class CommoditiesAPI {
  Future<Map> getCommodities() async {
    try {
      http.Response response = await http.get(Uri.parse(_sFixedEndPoint));

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);

        return (responseJson['data']['rates']);
      }

      return {};
    } catch (e) {}
  }
}

import 'dart:convert';
import 'package:Valuid/shared/earnings/earnings.dart';
import 'package:Valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

//! https://commodities-api.com/api/symbols?access_key=5ppvoro5ot7i7m76xsbzz5qyyzk7h4dmnx35dy28c4foj0q4swvvmlqa497q

String _sFixedEndPoint =
    'https://commodities-api.com/api/latest?access_key=5ppvoro5ot7i7m76xsbzz5qyyzk7h4dmnx35dy28c4foj0q4swvvmlqa497q&base=USD&symbols=RICE%2CWHEAT%2CSUGAR%2CCORN%2CWTIOIL%2CBRENTOIL%2CSOYBEAN%2CCOFFEE%2CXAU%2CXAG%2CXPD%2CXPT%2CXRH%2CRUBBER%2CETHANOL%2CCPO%2CNG%2CLUMBER%2CCOTTON%2CROBUSTA%2CCOCOA%2CTIN%2CCANO%2CCOAL%2CLCO%2CXCU%2CETHANOL%2CNG%2CNI%2COAT%2CZNC%2CALU';

class CommoditiesAPI {
  Future<Map> getCommodities() async {
    try {
      http.Response response = await http.get(Uri.parse(_sFixedEndPoint));

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);

        return (responseJson['data']['rates']);
      }

      return {};
    } catch (e) {
      PrintFunctions().printStartEndLine(e.toString());

      return {};
    }
  }

  List supportedCommodities = [
    {'name': 'Brent Crude Oil', 'rate': '', 'symbol': 'BRENTOIL'},
    {'name': 'Canola', 'rate': '', 'symbol': 'CANO'},
    {'name': 'Coal', 'rate': '', 'symbol': 'COAL'},
    {'name': 'Cocoa', 'rate': '', 'symbol': 'COCOA'},
    {'name': 'Arabica Coffee', 'rate': '', 'symbol': 'COFFEE'},
    {'name': 'Corn', 'rate': '', 'symbol': 'CORN'},
    {'name': 'Cotton', 'rate': '', 'symbol': 'COTTON'},
    {'name': 'Crude Palm Oil', 'rate': '', 'symbol': 'CPO'},
    {'name': 'Ethanol', 'rate': '', 'symbol': 'ETHANOL'},
    {'name': 'Cobalt (Troy Ounce)', 'rate': '', 'symbol': 'LCO'},
    {'name': 'Cobalt (Troy Ounce)', 'rate': '', 'symbol': 'LUMBER'},
    {'name': 'Natural Gas', 'rate': '', 'symbol': 'NG'},
    {'name': 'Nickel', 'rate': '', 'symbol': 'NI'},
    {'name': 'Oat', 'rate': '', 'symbol': 'OAT'},
    {'name': 'Rice', 'rate': '', 'symbol': 'RICE'},
    {'name': 'Robusta Coffee', 'rate': '', 'symbol': 'ROBUSTA'},
    {'name': 'Rubber', 'rate': '', 'symbol': 'RUBBER'},
    {'name': 'Soybeans', 'rate': '', 'symbol': 'SOYBEAN'},
    {'name': 'Sugar', 'rate': '', 'symbol': 'SUGAR'},
    {'name': 'Tin', 'rate': '', 'symbol': 'TIN'},
    {'name': 'Wheat', 'rate': '', 'symbol': 'WHEAT'},
    {'name': 'WTI Crude Oil', 'rate': '', 'symbol': 'WTIOIL'},
    {'name': 'Silver (Troy Ounce)', 'rate': '', 'symbol': 'XAG'},
    {'name': 'Gold (Troy Ounce)', 'rate': '', 'symbol': 'XAU'},
    {'name': 'Copper', 'rate': '', 'symbol': 'XCU'},
    {'name': 'Palladium (Troy Ounce)', 'rate': '', 'symbol': 'XPD'},
    {'name': 'Platinum (Troy Ounce)', 'rate': '', 'symbol': 'XPT'},
    {'name': 'Rhodium (Troy Ounce)', 'rate': '', 'symbol': 'XRH'},
    {'name': 'Zinc', 'rate': '', 'symbol': 'ZNC'},
    {'name': '', 'rate': '', 'symbol': 'ALU'},
  ];

  // {
  //   "BRENTOIL": 0.010829542993286,
  //   "CANO": 0.0011961722488038,
  //   "COAL": 0.0024539877300613,
  //   "COCOA": 0.00042265426880811,
  //   "COFFEE": 0.45662100456621,
  //   "CORN": 0.16366612111293,
  //   "COTTON": 0.81967213114754,
  //   "CPO": 0.0010743320531395,
  //   "ETHANOL": 0.462748727441,
  //   "LCO": 0.047664442326025,
  //   "LUMBER": 0.0016767270288397,
  //   "NG": 0.10688328345447,
  //   "NI": 0.000044471127120717,
  //   "OAT": 0.0024084778420039,
  //   "RICE": 0.059171597633136,
  //   "ROBUSTA": 0.00044702726866339,
  //   "RUBBER": 0.57471264367816,
  //   "SOYBEAN": 0.06872852233677,
  //   "SUGAR": 5.4704595185996,
  //   "TIN": 0.000025537116068177,
  //   "USD": 1,
  //   "WHEAT": 0.0030120481927711,
  //   "WTIOIL": 0.01150747986191,
  //   "XAG": 0.049661375491649,
  //   "XAU": 0.00056312337470016,
  //   "XCU": 4.4113592500689,
  //   "XPD": 0.00047755491881566,
  //   "XPT": 0.0010706638115632,
  //   "XRH": 0.000067796610169492,
  //   "ZNC": 0.00025796465884174
  // };
}

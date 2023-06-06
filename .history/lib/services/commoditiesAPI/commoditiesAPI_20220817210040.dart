import 'dart:convert';
import 'package:Valuid/shared/earnings/earnings.dart';
import 'package:Valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

//! https://commodities-api.com/api/symbols?access_key=5ppvoro5ot7i7m76xsbzz5qyyzk7h4dmnx35dy28c4foj0q4swvvmlqa497q

String _sFixedEndPoint =
    'https://commodities-api.com/api/latest?access_key=5ppvoro5ot7i7m76xsbzz5qyyzk7h4dmnx35dy28c4foj0q4swvvmlqa497q&base=USD&symbols=RICE%2CWHEAT%2CSUGAR%2CCORN%2CWTIOIL%2CBRENTOIL%2CSOYBEAN%2CCOFFEE%2CXAU%2CXAG%2CXPD%2CXPT%2CXRH%2CRUBBER%2CETHANOL%2CCPO%2CNG%2CLUMBER%2CCOTTON%2CROBUSTA%2CCOCOA%2CTIN%2CCANO%2CCOAL%2CLCO%2CXCU%2CETHANOL%2CNG%2CNI%2COAT%2CZNC%2CALU';

class CommoditiesAPI {
  Future<List> getCommodities() async {
    try {
      http.Response response = await http.get(Uri.parse(_sFixedEndPoint));

      if (response.statusCode == 200) {
        Map responseJson = json.decode(response.body)['data']['rates'];
        responseJson.remove('USD');

        // PrintFunctions().printStartEndLine(responseJson.length.toString());

        responseJson.forEach((key, value) {
          supportedCommodities.firstWhere((commoditity) => commoditity['symbol'] == key)['rate'] = value;
        });

        // PrintFunctions().printStartEndLine(supportedCommodities.first.toString());

        return supportedCommodities;
      }

      return [];
    } catch (e) {
      PrintFunctions().printStartEndLine(e.toString());

      return [];
    }
  }

  List supportedCommodities = [
    {'name': 'Brent Crude Oil', 'rate': 0.0, 'symbol': 'BRENTOIL'},
    {'name': 'Canola', 'rate': 0.0, 'symbol': 'CANO'},
    {'name': 'Coal', 'rate': 0.0, 'symbol': 'COAL'},
    {'name': 'Cocoa', 'rate': 0.0, 'symbol': 'COCOA'},
    {'name': 'Arabica Coffee', 'rate': 0.0, 'symbol': 'COFFEE'},
    {'name': 'Corn', 'rate': 0.0, 'symbol': 'CORN'},
    {'name': 'Cotton', 'rate': 0.0, 'symbol': 'COTTON'},
    {'name': 'Crude Palm Oil', 'rate': 0.0, 'symbol': 'CPO'},
    {'name': 'Ethanol', 'rate': 0.0, 'symbol': 'ETHANOL'},
    {'name': 'Cobalt (Troy Ounce)', 'rate': 0.0, 'symbol': 'LCO'},
    {'name': 'Cobalt (Troy Ounce)', 'rate': 0.0, 'symbol': 'LUMBER'},
    {'name': 'Natural Gas', 'rate': 0.0, 'symbol': 'NG'},
    {'name': 'Nickel', 'rate': 0.0, 'symbol': 'NI'},
    {'name': 'Oat', 'rate': 0.0, 'symbol': 'OAT'},
    {'name': 'Rice', 'rate': 0.0, 'symbol': 'RICE'},
    {'name': 'Robusta Coffee', 'rate': 0.0, 'symbol': 'ROBUSTA'},
    {'name': 'Rubber', 'rate': 0.0, 'symbol': 'RUBBER'},
    {'name': 'Soybeans', 'rate': 0.0, 'symbol': 'SOYBEAN'},
    {'name': 'Sugar', 'rate': 0.0, 'symbol': 'SUGAR'},
    {'name': 'Tin', 'rate': 0.0, 'symbol': 'TIN'},
    {'name': 'Wheat', 'rate': 0.0, 'symbol': 'WHEAT'},
    {'name': 'WTI Crude Oil', 'rate': 0.0, 'symbol': 'WTIOIL'},
    {'name': 'Silver (Troy Ounce)', 'rate': 0.0, 'symbol': 'XAG'},
    {'name': 'Gold (Troy Ounce)', 'rate': 0.0, 'symbol': 'XAU'},
    {'name': 'Copper', 'rate': 0.0, 'symbol': 'XCU'},
    {'name': 'Palladium (Troy Ounce)', 'rate': 0.0, 'symbol': 'XPD'},
    {'name': 'Platinum (Troy Ounce)', 'rate': 0.0, 'symbol': 'XPT'},
    {'name': 'Rhodium (Troy Ounce)', 'rate': 0.0, 'symbol': 'XRH'},
    {'name': 'Zinc', 'rate': 0.0, 'symbol': 'ZNC'},
    {'name': 'Aluminum', 'rate': 0.0, 'symbol': 'ALU'},
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

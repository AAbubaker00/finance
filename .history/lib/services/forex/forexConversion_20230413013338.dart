import 'dart:convert';
import 'package:valuid/extensions/stringExt.dart';
import 'package:valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:http/http.dart';

class ForexConversion {
  String _sForexLatestEndPoint =
      'http://data.fixer.io/api/latest?access_key=5e3972aeb42fb6efd5bc9df9cea3486a&format=1';
  String baseCurrency;

  ForexConversion({this.baseCurrency});

  Future<Map> getLatestFxRates() async {
    try {
      Response response = await get(Uri.parse(_sForexLatestEndPoint));
      Map newRates = {'base': 'USD', 'rates': {}};

      if (response.statusCode == 200) {
        Map rates = (json.decode(response.body));

        double baseUSDRate = rates['rates']['USD'];

        rates['rates'].forEach((key, value) {
          if (key != 'USD') {
            double newRate = baseUSDRate * (1 / value);

            newRates['rates'][key] = newRate;
          }
        });
        return newRates;
      }

      return {};
    } catch (e) {
      PrintFunctions().printError(e);

      return {};
    }
  }

  double getRate(Map rates, String quote) {
    if (baseCurrency != 'USD' && quote != 'USD') {
      return (rates['rates']['$baseCurrency']) * (1 / rates['rates']['$quote']);
    } else if (baseCurrency == 'USD' && quote != 'USD') {
      return (rates['rates'][quote]);
    } else if (baseCurrency != 'USD' && quote == 'USD') {
      return 1 / rates['rates']['$baseCurrency'];
    } else {
      return 1;
    }
  }

  List currencySymbols = [
    {'short': 'GBP', 'symbol': '£', 'name': 'Pound sterling'},
    {'short': 'USD', 'symbol': '\$', 'name': 'United States Dollar'},
    {'short': 'EUR', 'symbol': '€', 'name': 'Euro'},
    {'short': 'CAD', 'symbol': 'C\$', 'name': 'Canadian dollar'},
    {'short': 'HKD', 'symbol': 'HK\$', 'name': 'Hong Kong dollar'},
    {'short': 'ISK', 'symbol': 'ISK', 'name': 'Icelandic króna'},
    {'short': 'PHP', 'symbol': '₱', 'name': 'Philippine peso'},
    {'short': 'DKK', 'symbol': 'Kr.', 'name': 'Danish krone'},
    {'short': 'HUF', 'symbol': 'Ft', 'name': 'Hungarian forint'},
    {'short': 'CZK', 'symbol': 'Kč', 'name': 'Czech koruna'},
    {'short': 'RON', 'symbol': 'lei', 'name': 'Romanian leu'},
    {'short': 'SEK', 'symbol': 'kr', 'name': 'Swedish krona'},
    {'short': 'IDR', 'symbol': 'Rp', 'name': 'Indonesian rupiah'},
    {'short': 'BRL', 'symbol': 'R\$', 'name': 'Brazilian real'},
    {'short': 'RUB', 'symbol': '₽', 'name': 'Russian ruble'},
    {'short': 'HRK', 'symbol': 'kn', 'name': 'Croatian kuna'},
    {'short': 'JPY', 'symbol': '¥', 'name': 'Japanese yen'},
    {'short': 'THB', 'symbol': '฿', 'name': 'Thai baht'},
    {'short': 'CHF', 'symbol': 'CHf', 'name': 'Swiss franc'},
    {'short': 'BGN', 'symbol': 'Лв.', 'name': 'Bulgarian lev'},
    {'short': 'TRY', 'symbol': '₺', 'name': 'Turkish lira'},
    {'short': 'CNY', 'symbol': '¥', 'name': 'Renminbi'},
    {'short': 'NOK', 'symbol': 'kr', 'name': 'Norwegian krone'},
    {'short': 'NZD', 'symbol': 'NZ\$', 'name': 'New Zealand dollar'},
    {'short': 'ZAR', 'symbol': 'R', 'name': 'South African rand'},
    {'short': 'MXN', 'symbol': 'Mex\$', 'name': 'Mexican peso'},
    {'short': 'SGD', 'symbol': 'S\$', 'name': 'Singapore dollar'},
    {'short': 'AUD', 'symbol': 'A\$', 'name': 'Australian dollar'},
    {'short': 'ILS', 'symbol': '₪', 'name': 'Israeli Shekel'},
    {'short': 'KRW', 'symbol': '₩', 'name': 'Korean won'},
    {'short': 'PLN', 'symbol': 'zł', 'name': 'Polish Zloty'}
  ];

  Map getCurrencySymbol() {
    return currencySymbols.firstWhere(
      (element) => element['short'] == baseCurrency.capitalizeAll(),
      orElse: () => {'short': '??', 'symbol': '??', 'name': 'Unknown'},
    );
  }
}

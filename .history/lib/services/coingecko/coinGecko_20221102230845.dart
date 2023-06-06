import 'package:Valuid/services/coingecko/coin.dart';
import 'package:Valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class CoinGeko {
  String _sFixedSearchEndPoint = 'https://api.coingecko.com/api/v3/search?query=';
  String _sFixedCoinReult = 'https://api.coingecko.com/api/v3/coins/';

  List<Coin> coins = [];

  Future<List<Coin>> getSearchResult(String searchString) async {
    _sFixedSearchEndPoint += searchString;

    PrintFunctions().printStartEndLine(_sFixedSearchEndPoint);

    try {
      http.Response response = await http.get(Uri.parse(_sFixedSearchEndPoint));

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);

        responseJson = responseJson['coins'] as List;

        // print(responseJson);

        for (var coin in responseJson) {
          coins.add(Coin.fromMap(coin));
        }

        // print(coins.length);

        if (coins.length >= 100) {
          coins = coins.getRange(0, 100);
        }

        return Future.value(coins);
      }

      return [];
    } catch (e) {
      PrintFunctions().printError(e);

      return [];
    }
  }

  Future<Map> getCoinResult(String id) async {
    _sFixedCoinReult += id;

    // PrintFunctions().printStartEndLine(_sFixedCoinReult);

    try {
      http.Response response = await http.get(Uri.parse(_sFixedCoinReult));
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);

        // print(responseJson['market_data']['price_change_24h']);

        // print(responseJson['market_data']['current_price']['usd']);

        // if(responseJson['market_data']['current_price']['usd'] == null){
        //   Initialise(baseCurrency: '')
        // }

        return {
          'logo': responseJson['image']['large'],
          'type': responseJson['categories'][0],
          'symbol': responseJson['symbol'],
          'name': responseJson['name'],
          'id': responseJson['id'],
          'regularMarketPrice': responseJson['market_data']['current_price']['usd'],
          'regularMarketChange': responseJson['market_data']['price_change_24h'],
          'regularMarketChangePercent': responseJson['market_data']['market_cap_change_percentage_24h']
        };
      }

      return {};
    } catch (e) {
      PrintFunctions().printError(e);

      return {};
    }
  }
}

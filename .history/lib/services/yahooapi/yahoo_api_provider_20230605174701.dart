import 'dart:convert';
import 'package:valuid/extensions/stringExt.dart';
import 'package:valuid/models/quote/quote.dart';
import 'package:valuid/pages/news/newsObject.dart';
import 'package:valuid/shared/earnings/earnings.dart';
import 'package:valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:intl/intl.dart';

class YahooApiService {
  String _sQuoteEndPoint = 'https://query1.finance.yahoo.com/v7/finance/quote?symbols=';
  String _sFixedEndPoint = "https://query1.finance.yahoo.com/v10/finance/quoteSummary/";
  String _sChartDataEndPoint = "https://query1.finance.yahoo.com/v8/finance/chart/";
  String _sTickerSearchEndPoint = "http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=";
  // ignore: non_constant_identifier_names
  String _sTickerSearckEndPoint_Updated =
      'https://finance.yahoo.com/_finance_doubledown/api/resource/searchassist;searchTerm=';
  String _sNewsFixedEndPoint =
      'https://api.rss2json.com/v1/api.json?rss_url=http://feeds.finance.yahoo.com/rss/2.0/headline?s=';

  String _sTrendingEndPoint = 'https://query1.finance.yahoo.com/v1/finance/trending/US?lang=en-US&count=10';
  String _sTopMutualFunds =
      'https://query1.finance.yahoo.com/v1/finance/screener/predefined/saved?formatted=false&lang=enUS&region=US&scrIds=top_mutual_funds&count=10';

//!  nio?device=console&returnMeta=true

  // ignore: non_constant_identifier_names
  final String _SFixedFinacialDataEndPoint =
      '?modules=incomeStatementHistory,balanceSheetHistory,cashFlowStatementHistory';
  final String _sNewsDataEndPoint = '&lang=en-US';
  // ignore: non_constant_identifier_names
  final String _sFixedChartEndPoint_symbol = "?symbol=";
  final String _sFixedTickerSearchEndPoint =
      "&region=US&lang=en-US&row=all&callback=YAHOO.Finance.SymbolSuggest.ssCallback";
  // ignore: non_constant_identifier_names
  final String _sFixedTickerSearchEndPoint_Updated = '?device=console&returnMeta=true';
  // ignore: non_constant_identifier_names
  final String _sFixedChartEndPoint_timePeriod = "&period1=0&period2=9999999999&interval=1d";
  // ignore: non_constant_identifier_names
  final String _sFixedChartEndPoint_end = "&events=div";
  final String _sFixedAssetsEndPoint = "?modules=assetProfile";
  final String _sFixedDefaultKeyStatistics = '?modules=defaultKeyStatistics';
  final String _sFixedCalenderEvents = '?modules=calendarEvents';

  // final String _sFixedCryptoNewsEndPoint = 'https://www.investing.com/news/cryptocurrency-news';

  late String _sQuote;
  Map<String, dynamic> _quoteData = Map<String, dynamic>();

  Future<Map<String, dynamic>> getAllAssetData({required String symbol, required String exchange}) async {
    var a = getYahooQuote(symbol: symbol, exchange: exchange);
    // var b = getYahooCompanyAssets(symbol: symbol, exchange: exchange);

    _quoteData['quote'] = await a;
    // _quoteData['assets'] = await b;

    return _quoteData;
  }

  getQuoteChartData(String s, {exchange, symbol}) {}

  //                                                                                     //

  Future<QuoteObject> getYahooQuote({required String symbol, String exchange}) async {
    _sQuoteEndPoint = _sQuoteEndPoint + symbol;

    // PrintFunctions().printStartEndLine(_sQuoteEndPoint);

    try {
      http.Response response = await http.get(Uri.parse(_sQuoteEndPoint));

      if (response.statusCode == 200) {
        var responseJson = await json.decode(response.body);
        responseJson = responseJson["quoteResponse"]["result"][0];

        return QuoteObject.fromMap(responseJson);
      }

      return QuoteObject();
    } catch (e) {
      PrintFunctions().printError(e);
      return QuoteObject();
    }
  }

  //                                                                                     //

  Future<List<QuoteObject>> getYahooQuoteList(List<QuoteObject> holdings) async {
    // exchangeCheck(symbol, exchange);
    if (holdings.length != 0) {
      // print(_sQuoteEndPoint + holdings[0].symbol);
      try {
        List<Future> resposeFutures = List.generate(
            holdings.length, (index) => http.get(Uri.parse(_sQuoteEndPoint + holdings[index].symbol)));

        List response = await Future.wait(resposeFutures);
        List<QuoteObject> responseJson = List.generate(response.length,
            (index) => QuoteObject.fromMap(json.decode(response[index].body)["quoteResponse"]["result"][0]));

        return responseJson;
      } catch (e) {
        PrintFunctions().printError(e);
        return [QuoteObject()];
      }
    } else {
      return [QuoteObject()];
    }
  }

  //                                                                                     //

  Future<List<QuoteObject>> getYahooCompanyAssetsList(List<QuoteObject> holdings) async {
    if (holdings.length != 0) {
      try {
        List<Future> resposeFutures = List.generate(
            holdings.length,
            (index) =>
                http.get(Uri.parse(_sFixedEndPoint + holdings[index].symbol + "$_sFixedAssetsEndPoint")));

        List response = await Future.wait(resposeFutures);
        List<QuoteObject> responseJson = List.generate(response.length,
            (index) => QuoteObject.fromMap(json.decode(response[index].body)["quoteResponse"]["result"][0]));

        return responseJson;
      } catch (e) {
        PrintFunctions().printError(e);
        return [QuoteObject()];
      }
    } else {
      return [QuoteObject()];
    }
  }

  Future<Map<String, dynamic>> getYahooCompanyAssets({String symbol, String exchange}) async {
    _sFixedEndPoint = _sFixedEndPoint + symbol + "$_sFixedAssetsEndPoint";

    try {
      http.Response response = await http.get(Uri.parse(_sFixedEndPoint));


      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        responseJson = responseJson["quoteSummary"]["result"][0]["assetProfile"];

        print(responseJson);

        return responseJson;
      }

      return Map();
    } catch (e) {
      PrintFunctions().printError(e);

      return Map();
    }
  }

  //                                                                                     //
  bool isHeadingsLoaded = false;
  List dates = [];
  List quoteValues = [];

  Future<Map<String, dynamic>> getYahooChartData(
      {String timePeriod = '1d', String symbol, String exchange}) async {
    _sChartDataEndPoint = _sChartDataEndPoint +
        symbol +
        '$_sFixedChartEndPoint_symbol' +
        '$_sQuote' +
        '$_sFixedChartEndPoint_timePeriod' +
        '$_sFixedChartEndPoint_end';

    // print(_sChartDataEndPoint);

    try {
      http.Response response = await http.get(Uri.parse(_sChartDataEndPoint));
      if (response.statusCode == 200) {
        var responseJson = await json.decode(response.body);
        responseJson = responseJson["chart"]["result"][0];

        // print(responseJson['indicators']['quote'][0]['close']);

        List convertedTimestamps = [];
        convertedTimestamps.clear();

        for (var tS in responseJson['timestamp']) {
          convertedTimestamps
              .add(DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(tS * 1000)));
          // print(tS);
        }

        // for (var tS in convertedTimestamps) {
        //   // tS = DateFormat('yyyy-MM-dd')
        //   // .format(DateTime.fromMillisecondsSinceEpoch(tS * 1000));
        //   print(tS);
        // }

        // Map div;
        // div.containsKey(key)

        // if (responseJson.containsKey('events'))
        //   print('yes');
        // } else {
        //   print('no');
        // }

        // print('c');

        // PrintFunctions().printStartEndLine(convertedTimestamps.last);

        // print(responseJson['indicators']['quote'][0]['close']);

        return {
          'timestamp': convertedTimestamps,
          'exDividend': responseJson.containsKey('events') ? responseJson['events']['dividends'] : null,
          // 'volume': responseJson['indicators']['quote'][0]['volume'],
          'close': responseJson['indicators']['quote'][0]['close'],
          // 'high': responseJson['indicators']['quote'][0]['high'],
          // 'open': responseJson['indicators']['quote'][0]['open'],
          // 'low': responseJson['indicators']['quote'][0]['low'],
        };
      }
      return Map();
    } catch (e) {
      PrintFunctions().printError(e);

      return Map();
    }
  }

  /*


  https://query1.finance.yahoo.com/v7/finance/download/AAPL?period1=974073600&period2=4129747200&interval=1d&events=history&includeAdjustedClose=true
    https://query1.finance.yahoo.com/v7/finance/download/AAPL?period1=1598918400&period2=1604880000&interval=1d&events=history&includeAdjustedClose=true
https://query1.finance.yahoo.com/v7/finance/download/AAPL?period1=1604188800&period2=1604880000&interval=1d&events=history&includeAdjustedClose=true
https://query1.finance.yahoo.com/v7/finance/download/MSFT?period1=1603324800&period2=1604880000&interval=1d&events=history&includeAdjustedClose=true
      https://query1.finance.yahoo.com/v7/finance/download/LLOY.L?period1=1573243724&period2=1604866124&interval=1d&events=div&includeAdjustedClose=true
      https://query1.finance.yahoo.com/v7/finance/download/AAPL?period1=915148800&period2=4129315200&interval=1d&events=history&includeAdjustedClose=true
      https://query1.finance.yahoo.com/v7/finance/download/AAPL?period1=1573243724&period2=1604866124&interval=1d&events=history&includeAdjustedClose=true
      https://query1.finance.yahoo.com/v7/finance/download/LLOY.L?period1=1573243724&period2=1604866124&interval=1d&events=history&includeAdjustedClose=true
  */

  //                                                                                     //

  Future<Map<String, dynamic>> getYahooDefaultKeyStatistics({String symbol, String exchange}) async {
    // print(_sFixedEndPoint);
    _sFixedEndPoint = 'https://query1.finance.yahoo.com/v10/finance/quoteSummary/' +
        symbol +
        '$_sFixedDefaultKeyStatistics';

    try {
      http.Response response = await http.get(Uri.parse(_sFixedEndPoint));

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        responseJson = responseJson['quoteSummary']['result'][0]['defaultKeyStatistics'];

        resetFixedEndPoint();

        return responseJson;
      }

      return Map();
    } catch (e) {
      PrintFunctions().printError(e);

      return Map();
    }
  }

  //                                                                                     //

  Future<Map<String, dynamic>> getYahooFinancialData({String symbol, String exchange}) async {
    _sFixedEndPoint = 'https://query1.finance.yahoo.com/v10/finance/quoteSummary/' +
        symbol +
        '$_SFixedFinacialDataEndPoint';

    try {
      http.Response response = await http.get(Uri.parse(_sFixedEndPoint));

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        responseJson = responseJson['quoteSummary']['result'][0];

        resetFixedEndPoint();

        return {
          'incomeStatment': responseJson['incomeStatementHistory']['incomeStatementHistory'],
          'balanceSheet': responseJson['balanceSheetHistory']['balanceSheetStatements'],
          'cashFlow': responseJson['cashflowStatementHistory']['cashflowStatements'],
        };
      }

      return Map();
    } catch (e) {
      PrintFunctions().printError(e);

      return Map();
    }
  }

  //                                                                                     //

  Future<List> getTickerSearchResultUpdated({String search}) async {
    _sTickerSearckEndPoint_Updated =
        _sTickerSearckEndPoint_Updated + '$search' + '$_sFixedTickerSearchEndPoint_Updated';

    PrintFunctions().printStartEndLine(_sTickerSearckEndPoint_Updated);

    try {
      http.Response response = await http.get(Uri.parse(_sTickerSearckEndPoint_Updated));

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);

        return responseJson['data']['items'];
      }

      return [];
    } catch (e) {
      PrintFunctions().printError(e);

      return [];
    }
  }

  Future<List> getTickerSearchResult({String search}) async {
    _sTickerSearchEndPoint = _sTickerSearchEndPoint + '$search' + '$_sFixedTickerSearchEndPoint';

    // PrintFunctions().printStartEndLine(_sTickerSearchEndPoint);

    try {
      http.Response response = await http.get(Uri.parse(_sTickerSearchEndPoint));

      if (response.statusCode == 200) {
        var responseJson = json.decode(json.encode(response.body));

        responseJson = responseJson.replaceRange(0, 39, '');
        responseJson = responseJson.replaceRange(responseJson.length - 2, responseJson.length, '');

        responseJson = json.decode(responseJson);

        responseJson = responseJson['ResultSet']['Result'];

        return responseJson;
      }

      return [];
    } catch (e) {
      PrintFunctions().printError(e);

      return [];
    }
  }

  //                                                                                     //

  Future<List> getTrending() async {
    try {
      http.Response response = await http.get(Uri.parse(_sTrendingEndPoint));

      if (response.statusCode == 200) {
        var reponseJson = json.decode(response.body);

        return reponseJson['finance']['result'][0]['quotes'];
      }

      return [];
    } catch (e) {
      PrintFunctions().printError(e.toString());
      return [];
    }
  }

  //                                                                                     //

  Future<List> getTopMutualFunds() async {
    try {
      http.Response response = await http.get(Uri.parse(_sTopMutualFunds));

      if (response.statusCode == 200) {
        var reponseJson = json.decode(response.body);

        return reponseJson['finance']['result'][0]['quotes'];
      }

      return [];
    } catch (e) {
      PrintFunctions().printError(e.toString());
      return [];
    }
  }

  //                                                                                     //

  // ignore: missing_return
  Future<List<Earnings>> getYahooCalenderEvents(List<QuoteObject> holdings) async {
    List<Earnings> earnings = [];
    int count = 0;

    // print(holdings.length);
    try {
      for (var holding in holdings) {
        var url = 'https://query1.finance.yahoo.com/v10/finance/quoteSummary/' +
            '${holding.symbol}' +
            '$_sFixedCalenderEvents';

        http.Response response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          var responseJson = json.decode(response.body);
          responseJson = responseJson['quoteSummary']['result'][0]['calendarEvents']['earnings'];

          earnings.add(Earnings.fromMarketMap(
            responseJson,
            holding.symbol,
            holding.name,
          ));

          count++;
        } else {
          count++;
        }
      }

      if (count >= holdings.length) {
        return earnings;
      }
    } catch (e) {
      PrintFunctions().printError(e);
      return [];
    }
  }

  List<NewsObject> news = [];

  Future<List<NewsObject>> getNews(String holding) async {
    // String symbolSearch = '';

    // for (var asset in assets) {
    //   // symbolSearch += symbolSearch == '' ? '${asset['symbol']}' : ',${asset['symbol']}';
    //   symbolSearch += symbolSearch == '' ? '${asset['symbol']}' : ',${asset['symbol']}';
    // }

    // PrintFunctions().printStartEndLine(symbolSearch);

    _sNewsFixedEndPoint = _sNewsFixedEndPoint + holding.toString().capitalizeAll() + '$_sNewsDataEndPoint';

    // print(_sNewsFixedEndPoint);

    try {
      http.Response response = await http.get(Uri.parse(_sNewsFixedEndPoint));

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);

        // responseJson = responseJson['items'];

        for (var item in responseJson['items']) {
          news.add(NewsObject.fromMap(item));
        }

        // print(news.length);

        // print(news.first['imgURL']);

        return news;
      }
      return [];
    } catch (e) {
      PrintFunctions().printError(e.toString());

      return [];
    }
  }

  //                                                                                     //
  Future<List<NewsObject>> propertyNews() async {
    String propertyNews = 'https://uk.finance.yahoo.com/topic/property/';

    final response = await http.Client().get(Uri.parse(propertyNews));

    if (response.statusCode == 200) {
      var document = parser.parse(response.body);

      var newslist = document.getElementById('Fin-Stream').children[0].children;
      newslist.removeAt(0);

      for (var feed in newslist) {
        try {
          var contentLevel = feed.children[0].children[0].children;
          var imgURL = contentLevel.first.children.first.children.first.attributes['src'];
          var src =
              'https://uk.finance.yahoo.com' + contentLevel[1].children[2].children.first.attributes['href'];

          var title = contentLevel[1].children[2].children.first.text;

          var description = contentLevel[1].children[3].text;

          news.add(NewsObject(
              date: '',
              description: description,
              imgURL: imgURL,
              provider: 'Yahoo Finance',
              src: src,
              title: title));
        } catch (e) {
          print('different format');
        }
      }

      return news;
    }

    return null;
  }

  Future<List<NewsObject>> cryptoNews() async {
    String cryptoNews = 'https://uk.yahoo.com/topics/crypto/';

    final response = await http.Client().get(Uri.parse(cryptoNews));

    if (response.statusCode == 200) {
      var document = parser.parse(response.body);

      var newsList = document.getElementById('module-rmpMainStream').children[1].children;

      for (var feed in newsList) {
        try {
          var contentLevel = feed.children.first.children;

          var src = contentLevel.first.children.first.attributes['href'];

          var imgURL = contentLevel.first.children.first.children.first.attributes.containsKey('data-wf-src')
              ? contentLevel.first.children.first.children.first.attributes['data-wf-src']
              : contentLevel.first.children.first.children.first.attributes['src'];

          var title = contentLevel[1].children[1].children.first.text;
          var description = contentLevel[1].children[2].text;

          news.add(NewsObject(
              date: '',
              description: description,
              imgURL: imgURL,
              provider: 'Yahoo Finance',
              src: src,
              title: title));
        } catch (e) {
          print('different format');
        }
      }

      return news;
    }

    return [];
  }

  //                                                                                     //

  void resetFixedEndPoint() {
    _sFixedEndPoint = "https://query1.finance.yahoo.com/v10/finance/quoteSummary/";
  }
}

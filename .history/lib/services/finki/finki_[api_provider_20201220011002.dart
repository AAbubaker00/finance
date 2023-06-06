import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FinkApiService {
// https://www.finki.io/callAPI.php?isin=GB00BH4HKS39&function=dividendData&key=aa297f1nk1
//https://finki.io/isinAPI.php?ticker=LSE:lloy

  String _sFixedEndPoint_apiCall = "https://www.finki.io/callAPI.php?isin=";
  String _sFixedEndPoint_isinCall = "https://finki.io/isinAPI.php?ticker=";
  String _dividendEndPoint = "&function=dividendData&key=aa297f1nk1";
  String _isinIndex = '';

  Future<Map<String, dynamic>> getDividendData({String exchange, String symbol}) async{
    _s
  }
}

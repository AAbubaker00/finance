import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:finance/models/quoteYahoo.dart';

class Services {
  static const String url =
      'https://query1.finance.yahoo.com/v7/finance/quote?symbols=aapl';

  static Future<QuoteYahoo> getQuote() async{
    try{
      final response = await http.get 
    }cathc(e){

    }
  }

}

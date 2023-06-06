import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

final String _fixedEndPoint = 'https://www.robomarkets.com/beginners/info/national-holidays/';

class RoboMarkets {

  getHlidays()async {
    try{

      final response = await http.Client().get(Uri.parse())

    }catch(e){

    }
  }
}

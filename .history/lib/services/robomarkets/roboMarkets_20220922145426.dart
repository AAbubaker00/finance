import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;


final String _fixedEndPoint = 'https://www.robomarkets.com/beginners/info/national-holidays/';

class RoboMarkets {
  getHolidays() async {
    try {
      final response = await http.Client().get(Uri.parse(_fixedEndPoint));

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);

        var holidayContent = document.getElementsByClassName('table table-bordered');

        print(holidayContent.first.children.first.text);

        for (var element in holidayContent.first.children.first.children) {
          print(element.text);
        }
      }
    } catch (e) {}
  }
}

class RoboMarketsHolidayObject {
  DateTime date;
  String country;
  String exchange;
  String holdiay;

  RoboMarketsHolidayObject.fromElement(dom.Element element, {}): date
}

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

        // print(holidayContent.first.children.first.text);

        String date = '';

        for (var element in holidayContent.first.children.first.children) {
          // print(element.text);

          // print(date);
          date = date == ''
              ? element.children.first.text
              : element.children.first.text.isEmpty
                  ? date
                  : element.children.first.text;

          print(element.children.first.text.toString().length == ' '); // = date;


          for (var child in element.children) {
            // print(child.text);
          }
          // print('');
        }
      }
    } catch (e) {}
  }
}

class RoboMarketsHolidayObject {
  String date;
  String country;
  String exchange;
  String holdiay;

  // RoboMarketsHolidayObject.fromElement(dom.Element element, ) : date = element.children[0];
}

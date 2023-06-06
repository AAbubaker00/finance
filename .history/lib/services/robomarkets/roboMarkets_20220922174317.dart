import 'package:Valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:Valuid/extensions/stringExt.dart';

final String _fixedEndPoint = 'https://www.robomarkets.com/beginners/info/national-holidays/';

class RoboMarkets {
  List<RoboMarketsHolidayObject> holidays = [];
  Future<List<RoboMarketsHolidayObject>> getHolidays() async {
    try {
      final response = await http.Client().get(Uri.parse(_fixedEndPoint));

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);

        var holidayContent = document.getElementsByClassName('table table-bordered');

        // print(holidayContent.first.children.first.text);

        String date = '';

        holidayContent.first.children.first.children.removeAt(0);

        for (var element in holidayContent.first.children.first.children) {
          // print(element.text);

          // print(date);
          date = date == ''
              ? element.children.first.text
              : element.children.first.text.length == 1
                  ? date
                  : element.children.first.text;

          element.children.first.text = date;

          holidays.add(RoboMarketsHolidayObject.fromElement(element));

          // for (var child in element.children) {
          //   print(child.text);
          // }
          // print('');
        }

        return holidays;
      }
      return [];
    } catch (e) {
      PrintFunctions().printError(e.toString());

      return [];
    }
  }
}

class RoboMarketsHolidayObject {
  String date;
  String country;
  String exchange;
  String holiday;

  RoboMarketsHolidayObject();

  RoboMarketsHolidayObject.fromElement(
    dom.Element element,
  )   : date = element.children[0].text,
        country = element.children[1].text.toString().remo,
        exchange = element.children[2].text,
        holiday = element.children[3].text;

  RoboMarketsHolidayObject.fromMap(
    Map element,
  )   : date = element['date'],
        country = element['country'],
        exchange = element['exchange'],
        holiday = element['holiday'];

  Map roboMarketsHolidayObjectToMap(RoboMarketsHolidayObject holiday) => {
        'date': holiday.date,
        'country': holiday.country,
        'exchange': holiday.exchange,
        'holiday': holiday.holiday
      };
}

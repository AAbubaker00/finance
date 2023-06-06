import 'dart:convert';
import 'package:http/http.dart' as http;

//! https://eodhistoricaldata.com/img/logos/US/ko.png

class Clearbit {
  String _sFixedEndPoint = 'https://autocomplete.clearbit.com/v1/companies/suggest?query=';

  Future<Map> getLogo(String name) async {
    _sFixedEndPoint = _sFixedEndPoint + '$name';

    print(_sFixedEndPoint);

    try {
      http.Response response = await http.get(Uri.parse(_sFixedEndPoint));

      if (response.statusCode == 200) {
        var responseJSON = await json.decode(response.body);
        print(responseJSON);

        if (!responseJSON.isEmpty) {
          // print(responseJSON[0]);
          return responseJSON[0];
        } else {
          return responseJSON[0];
        }
      }

      return null;
    } catch (e) {
      // PrintFunctions().printError(e);

      return null;
    }
  }
}

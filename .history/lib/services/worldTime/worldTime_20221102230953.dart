import 'dart:convert';

import 'package:http/http.dart' as http;

class WorldTime {
  String _sFixedEndPoint = 'http://worldtimeapi.org/api/timezone/Europe/London';

  Future<Map> getTime() async {
    http.Response response = await http.get(Uri.parse(_sFixedEndPoint));

    try {
      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      }
    } catch (e) {
      print(e.toString());

      return {};
    }
  }
}

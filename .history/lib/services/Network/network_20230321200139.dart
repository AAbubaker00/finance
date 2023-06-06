import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Network {

  getConnectionStatus() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (e) {
      return false;
    }
  }
}

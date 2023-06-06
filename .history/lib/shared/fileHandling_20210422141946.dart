
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalDataSet {
  writePortfolios(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/LocalPortfolio.json');
    await file.writeAsString(text);
  }

  Future<String> readPortfolios() async {
    String text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/localDataSet.json');
      text = await file.readAsString();

      return text;
    } catch (e) {
      // print("Couldn't read file");

      return '';
    }
  }

  writeStates(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/savedStates.json');
    await file.writeAsString(text);
  }

  Future<String> readStates() async {
    String text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/savedStates.json');
      text = await file.readAsString();

      return text;
    } catch (e) {
      // print("Couldn't read file");

      return '';
    }
  }


}
import 'dart:io';
import 'package:Strice/shared/printFunctions/custom_Print_Functions.dart';
import 'package:path_provider/path_provider.dart';

class LocalDataSet {
  writePortfolios(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/LocalPortfoliosDataSet.json');
    await file.writeAsString(text);
  }

  Future<String> readPortfolios() async {
    String text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/LocalPortfoliosDataSet.json');

      text = await file.readAsString();

      return text;
    } catch (e) {
      PrintFunctions().printStartEndLine(e.toString());

      return '';
    }
  }





  writeCAGRData(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/LocalCAGRDataSet.json');
    await file.writeAsString(text);
  }

  Future<String> readCAGRData() async {
    String text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/LocalCAGRDataSet.json');

      text = await file.readAsString();

      return text;
    } catch (e) {
      PrintFunctions().printStartEndLine(e.toString());
      return '';
    }
  }

  writeStates(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/LocalStatesDataSet.json');
    await file.writeAsString(text);
  }

  Future<String> readStates() async {
    String text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/LocalStatesDataSet.json');
      text = await file.readAsString();

      return text;
    } catch (e) {
      PrintFunctions().printStartEndLine(e.toString());

      return '';
    }
  }
}

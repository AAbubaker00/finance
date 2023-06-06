import 'dart:convert';
import 'dart:io';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:path_provider/path_provider.dart';

class LocalDataSet {
  updateLocalData(DataObject dataObject) async {
    var decodedData = json.encode(DataObject().dataObjectToMap(dataObject));
    await writePortfolios(decodedData);
  }

  deleteLocalData(String data) async {
    await w('');
  }

  writePortfolios(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/LocalCalenderEvents.json');
    await file.writeAsString(text);
  }

  Future<String> getCalenderEvents() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/LocalCalenderEvents.json');

      return await file.readAsString();
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

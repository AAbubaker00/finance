import 'package:intl/intl.dart';

extension StringExtension on String {
  String removeStr() {
    return this
        .replaceAll('The ', '')
        .toString()
        .replaceAll('The ', '')
        .toString()
        .replaceAll(', Inc.', '')
        .toString()
        .replaceAll(' Inc.', '')
        .toString()
        .replaceAll(' plc', '')
        .toString()
        .replaceAll(' PLC', '')
        .toString()
        .replaceAll(' Plc', '')
        .toString()
        .replaceAll('.com', '')
        .toString()
        .replaceAll(' Company', '')
        .toString()
        .replaceAll(' Corp.', '')
        .toString()
        .replaceAll(' Limited.', '')
        .toString()
        .replaceAll(' Limited', '')
        .toString()
        .replaceAll('-', ' ')
        .toString();
  }

  // String iconsPath() {
  //   return 'assets/icons/' + this;
  // }

  String dateFormat() {
    return this.replaceAll('.', '/');
  }

  String capitalizeFirst() {
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }

  String capitalizeAll() {
    return '${this.toUpperCase()}';
  }

  String lowerCaseAll() {
    return '${this.toLowerCase()}';
  }

  String addCommas() {
    return this.replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  String compressString() {
    return NumberFormat.compact().format(this).toString();
  }

  bool validateUpperCase() {
    String pattern = r'^(?=.*?[A-Z])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(this);
  }

  bool validateLowerCase() {
    String pattern = r'^(?=.*?[a-z])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(this);
  }

  bool validateNumber() {
    String pattern = r'^(?=.*?[0-9])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(this);
  }

  bool validateSpecialCase() {
    String pattern = r'^(?=.*?[!@#\$&*~£]).{1,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(this);
  }
}

var iconsPath = 'assets/icons/';

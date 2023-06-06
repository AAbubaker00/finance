import 'dart:convert';

import 'package:Strice/shared/fileHandling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: camel_case_types
//

class LoadTheme {
  Future<bool> getTheme() async {
    var localStatesDataSet = await LocalDataSet().readStates();

    if (localStatesDataSet == '') {
      return false;
    } else {
      var statesJson = json.decode(localStatesDataSet);
      return statesJson['states']['dark'];
    }
  }
}

class DarkTheme {
  final bool isDark;

  DarkTheme(this.isDark) {
    // getTheme();

    if (isDark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }

    backgroundColour = isDark ? Color(0xFF2E303C) : Color(0xFFECEDF1);
    iconColour = isDark ? Color(0xFFDFE8FE) : Color(0xFF000000).withOpacity(.87);
    summaryColour = isDark ? Color(0xFF3A3C4A) : Color(0xFFFEFEFE);
    insideColour = isDark ? Color(0xFF3A3C4A) : Color(0xFFFEFEFE);

    primary = isDark ? Colors.black : Colors.white;


    blueVarient = isDark ? Color(0xFF30C196) : Color(0xFF30C196);
    // blueVarient = isDark ? Color(0xFF01A7E1) : Color(0xFF01A7E1);

    goldVarient = isDark ? Color(0xFFDDB42E) : Color(0xFFDDB42E);
    redVarient = isDark ? Color(0xFFE24C4E) : Color(0xFFE24C4E);
    greenVarient = isDark ? Color(0xFF30C196) : Color(0xFF30C196);
    purpleVarient = Color(0xFFCAACD9);

    border = isDark ? Color(0xFF484E5C).withOpacity(.87) : Color(0xFFDDDEE2);
    textColor = isDark ? Color(0xFFDFE8FF) : Color(0xFF000000).withOpacity(.87);
    textColorVarient = isDark ? Color(0xFFDFE8FE).withOpacity(.6) : Color(0xFF000000).withOpacity(.6);
    chartTextColour = isDark ? Color(0xFFA2A8B8) : Color(0xFF787C82);

    backColour = isDark ? Color(0xFFDFE8FE) : Color(0xFF000000).withOpacity(.87);
    themeMode = isDark ? Color(0xFF3E3E3E) : Color(0xFFECEDF1);
    backVarient = isDark ? Color(0xFF393C4A) : Color(0xFFFBFBFC);
  }

  Color themeMode;

  Color secondary = 
  Color goldVarient_2 = Color(0xFFD0A722);
  Color blueVarient_2 = Color(0xFF2A51E0);
  Color backVarient;

  Color primary;

  Color backgroundColour;
  Color bgColourVarient;
  Color iconColour;
  Color summaryColour;
  Color insideColour;
  Color backColour;

  Color purpleVarient;
  Color reponseColour;
  Color blueVarient;
  Color goldVarient;
  Color redVarient;
  Color greenVarient;
  Color backgroundVar;
  Color border;
  Color borderVarient;

  Color textColor;
  Color textColorVarient;
  Color chartTextColour;
  Color redVarient_2;
}

class VarientColours {
  List<Color> chartColours = [
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.amberAccent,
    Color(0xFF01A7E1),
    Color(0xFF4CB050),
    Colors.pink,
    Colors.blueGrey,
    Colors.orange,
  Color(0xFF7C72DC), 
    Colors.brown,
    Colors.indigo,
  ];

  List<Color> barColours = [
    Colors.pinkAccent,
    Colors.deepOrange,
    Colors.amberAccent,
    Colors.indigoAccent,
    Colors.white
  ];

  List<Color> customColours = [
     Colors.greenAccent,
    Colors.purpleAccent,
    Colors.amberAccent,
    Color(0xFF1E83F9),
    Color(0xFFD77423),
    Color(0xFF4CB050),
    Color(0xFF4358CD),
    Color(0xFFBA26D4),
    Color(0xFF1CB8AD),
   Color(0xFFB3B71C),
    Color(0xFF357C38),
    Color(0xFF324299),
    Color(0xFF9B9E19),
    Color(0xFFAF3B3C),
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Color(0xFFCAACD9),
    Color(0xFF696969),
    Colors.yellowAccent,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.brown,
    Colors.blueAccent,
    Colors.redAccent,
    Colors.yellowAccent,
    Colors.greenAccent,
    Colors.pink,
    Colors.orangeAccent,
    Colors.purpleAccent,
    Colors.blueGrey,
    Colors.pinkAccent,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.lightBlueAccent,
    Colors.deepOrange,
    Color(0xFF5598DF),
    Color(0xFFF2B25C),
    Color(0xFF7C72DC),
    Color(0xFF59BEA0),
    Color(0xFFFB9143),
    Color(0xFF77225E),
    Color(0xFFF9672B),
    Color(0xFF8B9098),
    Color(0xFF371B2C),
    Color(0xFFFFAA01),
    Color(0xFF00A5C1),
    Color(0xFF0BF170),
    Color(0xFFEFF212),
    Color(0xFFA10867),
    Color(0xFF001E85),
    Color(0xFF1E83F9),
    Color(0xFF076CA4),
    Color(0xFF205600),
    Color(0xFF2F0D04),
    Color(0xFFD5AD18),
    Color(0xFF8C4A0E),
    Color(0xFF1259C5),
    Color(0xFF205600),
    Color(0xFF1E20B1),
    Color(0xFF893DC2),
    Color(0xFFF8F50A),
    Color(0xFF04DA6C),
    Color(0xFFC5136C),
    Color(0xFF628000),
    Color(0xFFA79CE0),
    Color(0xFF004F40),
    Color(0xFF033B32),
    Color(0xFFD92668),
    Color(0xFFD6AE0C),
    Color(0xFFF96529),
    Color(0xFFD551D8),
  ];
}

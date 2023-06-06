import 'dart:convert';

import 'package:Strice/shared/fileHandling.dart';
import 'package:Strice/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemePage extends StatefulWidget {
  ThemePage({Key key}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  bool isDark = true;

  int groupValue;
  Map data;

  loadData() {
    if (data['states']['states']['dark'] == null) {
      groupValue = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DarkTheme(isDark).insideColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight * .8),
            child: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(
                color: DarkTheme(isDark).backColour, //change your color here
              ),
              backgroundColor: DarkTheme(isDark).insideColour,
              title: Text('Theme', style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 18)),
              centerTitle: true,
            ),
          ),
          body: Theme(
            data: ThemeData.dark(),
            child: ListView(
              children: [
                Row(
                  children: [
                    Radio<int>(
                      value: 0,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value;

                          data['states']['states']['dark'] = false;

                          LocalDataSet().writeStates(json.encode(data['states']));
                        });
                      },
                    ),
                    Text(
                      'Light',
                      style: TextStyle(color: DarkTheme(isDark).textColor),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio<int>(
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value;
                          data['states']['states']['dark'] = true;

                          LocalDataSet().writeStates(json.encode(data['states']));
                        });
                      },
                    ),
                    Text(
                      'Dark',
                      style: TextStyle(color: DarkTheme(isDark).textColor),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio<int>(
                      value: 2,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value;

                          var brightness = SchedulerBinding.instance.window.platformBrightness;
                          data['states']['states']['dark'] = brightness == Brightness.dark;

                          LocalDataSet().writeStates(json.encode(data['states']));
                        });
                      },
                    ),
                    Text(
                      'System Default',
                      style: TextStyle(color: DarkTheme(isDark).textColor),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

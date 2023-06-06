import 'package:Strice/shared/themes.dart';
import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  ThemePage({Key key}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  bool isDark = false;

  String label;
  EdgeInsets padding;
  int groupValue;
  bool value;
  Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DarkTheme(isDark).insideColour,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight * .8),
            child: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(
                color: DarkTheme(isDark).backColour, //change your color here
              ),
              backgroundColor: DarkTheme(isDark).backgroundColour,
              title: Text('Theme', style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 18)),
              centerTitle: true,
            ),
          ),
          body: ListView(
            children: [
              Row(
                children: [
                  Radio<int>(
                    value: 0,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value;
                      });
                    },
                  ),
                  Text('Light')
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
                      });
                    },
                  ),
                  Text('Dark')
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
                      });
                    },
                  ),
                  Text('System Default')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

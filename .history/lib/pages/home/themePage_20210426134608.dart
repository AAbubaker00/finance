import 'package:Strice/shared/themes.dart';
import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  ThemePage({Key key}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight * .8),
            child: AppBar(
              title:
                  Text('Settings', style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 18)),
            ),
          ),
        ),
      ),
    );
  }
}

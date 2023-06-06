import 'package:Strice/shared/themes.dart';
import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  ThemePage({Key key}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  bool isDark = false;
    String _selectedView = 'Card';

  @override
  Widget build(BuildContext context) {
    return Container(
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
              title:
                  Text('Settings', style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 18)),
              centerTitle: true,
            ),
          ),
          body: ListView(
            children: [
               new PopupMenuButton(
            onSelected: (value) => setState(() => _selectedView = value),
            itemBuilder: (_) => [
                  new CheckedPopupMenuItem(
                    checked: _selectedView == 'Card',
                    value: 'Card',
                    child: new Text('Card'),
                  ),
                  new CheckedPopupMenuItem(
                    checked: _selectedView == 'Swipe',
                    value: 'Swipe',
                    child: new Text('Swipe'),
                  ),
                  new CheckedPopupMenuItem(
                    checked: _selectedView == 'List',
                    value: 'List',
                    child: new Text('List'),
                  ),
                ],
          ),
            ],
          ),
        ),
      ),
    );
  }
}

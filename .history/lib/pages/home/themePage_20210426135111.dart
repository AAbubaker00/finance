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

  enum SingingCharacter { lafayette, jefferson }

// ...

SingingCharacter? _character = SingingCharacter.lafayette;


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
              RadioListTile<SingingCharacter>(
                title: const Text('Lafayette'),
                value: SingingCharacter.lafayette,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              RadioListTile<SingingCharacter>(
                title: const Text('Thomas Jefferson'),
                value: SingingCharacter.jefferson,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:Strice/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomeBottomSheet {
  bool isDark = true;
  void underDevelopment(BuildContext context, {String text}) {
    showModalBottomSheet(
        // barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  color: DarkTheme(isDark).summaryColour,
                  border: Border.all(color: DarkTheme(isDark).border),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        text.isEmpty? 'This feature is currently under development',
                        style: TextStyle(color: DarkTheme(isDark).textColor, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

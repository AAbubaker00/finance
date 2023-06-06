import 'package:Strice/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomeBottomSheet {
  bool isDark = true;
  void underDevelopment(BuildContext context) {
    showModalBottomSheet(
        // barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: DarkTheme(isDark).insideColour,
                  border: Border.all(color: DarkTheme(isDark).border),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'This feature is currently under development',
                          style: TextStyle(color: DarkTheme(isDark).textColor, fontSize: 20),
                        ),
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

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
                        text.isEmpty ? 'This feature is currently under development' : text,
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


  _confirmBottomSheet(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: DarkTheme(isDark).summaryColour,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // setState(() {
                    //   isDelete = true;
                    // });

                    // Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Remove',
                      style: TextStyle(fontSize: 20, color: DarkTheme(isDark).redVarient),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: DarkTheme(isDark).summaryColour,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 20, color: DarkTheme(isDark).textColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



}

import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomeDialogs {
  final url = 'https://play.google.com/store/apps/details?id=com.minist.strice';

  final isDark;

  CustomeDialogs(this.isDark);

  noConnectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: UserThemes(isDark).border)
                  ),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'No Internet Connection',
                        style: TextStyle(
                            fontSize: 20, color: UserThemes(isDark).textColor, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: Text(
                            'Unable to connect to database. Please check your connection and try again.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: UserThemes(isDark).textColor, fontSize: 17),
                          ))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ));
  }
}

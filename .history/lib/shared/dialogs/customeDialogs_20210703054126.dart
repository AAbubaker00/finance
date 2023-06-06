import 'package:Strice/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomeDialogs {
  final url = 'https://play.google.com/store/apps/details?id=com.minist.strice';

  bool isDark = true;

  updateAlertDialoge(BuildContext context, dynamic latestVersion, dynamic releaseNotes, dynamic version) {
    return showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Dialog(
            backgroundColor: DarkTheme(isDark).summaryColour,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: DarkTheme(isDark).border),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Update App?',
                    style: TextStyle(
                        color: DarkTheme(isDark).textColor, fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'A new version of Strice is available! Version 1.$latestVersion is now available - you have $version.',
                    style: TextStyle(
                      color: DarkTheme(isDark).textColorVarient,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Release Notes:',
                    style: TextStyle(
                        color: DarkTheme(isDark).textColor, fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '$releaseNotes',
                    style: TextStyle(
                      color: DarkTheme(isDark).textColorVarient,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Would you like to update it now?',
                    style: TextStyle(
                        color: DarkTheme(isDark).textColor, fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'LATER',
                          style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 18),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () async {
                          if (await canLaunch(url))
                            await launch(url);
                          else
                            throw "Could not launch $url";
                        },
                        child: Text('UPDATE NOW',
                            style: TextStyle(color: DarkTheme(isDark).blueVarient, fontSize: 18)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  noConnectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: DarkTheme(isDark).border)
                  ),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'No Internet Connection',
                        style: TextStyle(
                            fontSize: 20, color: DarkTheme(isDark).textColor, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: Text(
                            'Unable to connect to database. Please check your connection and try again.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: DarkTheme(isDark).textColor, fontSize: 17),
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

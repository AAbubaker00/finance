import 'package:Strice/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomeDialogs {
  final url = 'https://play.google.com/store/apps/details?id=com.minist.strice';

  bool isDark = true;

  updateAlertDialoge(BuildContext context, dynamic latestVersion, dynamic releaseNotes, dynamic version) {
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Dialog(
            backgroundColor: DarkTheme(isDark).insideColour,
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

  _guestWarningDialoge(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Dialog(
            backgroundColor: DarkTheme(isDark).insideColour,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: DarkTheme(isDark).border),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Are you sure?',
                    style: TextStyle(color: DarkTheme(isDark).goldVarient, fontSize: 22),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'With a guest account, your data will not be backed up to our servers and you risk data loss.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: DarkTheme(isDark).textColor, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'If you wish to have your data backed up, you will have to re-register with an email to secure your data from loss.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
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
                          'CANCEL',
                          style: TextStyle(color: DarkTheme(isDark).blueVarient, fontSize: 18),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () async {
                          dynamic result = await _auth.signInAnon();
                          if (result == null) {
                            setState(() {
                              isWrongCred = true;
                            });
                          } else {
                            isWrongCred = false;

                            Navigator.pushReplacementNamed(context, '/wrapper');
                          }
                        },
                        child: Text('CONTINUE AS GUEST',
                            style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 18)),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

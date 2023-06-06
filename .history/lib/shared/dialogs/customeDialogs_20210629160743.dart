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

  popupDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            SizedBox(
                height: drawerSpacing,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/editPortfolio', arguments: data)
                      .then((value) => setState(() => isChange()));
                },
                icon: Row(
                  children: [
                    SizedBox(
                      width: 3,
                    ),
                    ClipRRect(
                      child: Image.asset(
                        'assets/icons/edit.png',
                        color: DarkTheme(isDark).iconColour,
                        // height: _height * 0.1,
                        // width: _width * 0.1,
                        fit: BoxFit.fill,
                        scale: 25,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Edit Name',
                      style: TextStyle(color: DarkTheme(isDark).textColor, fontSize: 17),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: drawerSpacing,
              ),
              IconButton(
                onPressed: () {
                  CustomeBottomSheet().underDevelopment(context);
                },
                icon: Row(
                  children: [
                    SizedBox(
                      width: 3,
                    ),
                    ClipRRect(
                      child: Image.asset(
                        'assets/icons/dc.png',
                        color: DarkTheme(isDark).textColorVarient,
                        // height: _height * 0.1,
                        // width: _width * 0.1,
                        fit: BoxFit.fill,
                        scale: 25,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Analysis',
                      style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 17),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: drawerSpacing,
              ),
              IconButton(
                onPressed: () {
                  CustomeBottomSheet().underDevelopment(context);

                  // var totalShares;

                  // Navigator.pushNamed(context, '/report', arguments: {
                  //   'stocks': stocks,
                  //   'inception': inceptionDate,
                  //   'invested': investedValue,
                  //   'value': portfolioValue,
                  //   'performance': cagrData,
                  //   'shares': totalShares,
                  //   'assets': totalStocks,
                  //   'data': data
                  // });
                },
                icon: Row(
                  children: [
                    Icon(Icons.feed_rounded, color: DarkTheme(isDark).textColorVarient, size: 26),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Report',
                      style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 17),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: drawerSpacing,
              ),
              IconButton(
                onPressed: () {
                  CustomeBottomSheet().underDevelopment(context);

                  // Navigator.pushNamed(context, '/finCalender', arguments: {'stocks': stocks, 'data': data});
                },
                icon: Row(
                  children: [
                    SizedBox(
                      width: 3,
                    ),
                    ClipRRect(
                      child: Image.asset(
                        'assets/icons/calender.png',
                        color: DarkTheme(isDark).textColorVarient,
                        // height: _height * 0.1,
                        // width: _width * 0.1,
                        fit: BoxFit.fill,
                        scale: 25,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Dividends and Splits Calender',
                      style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 17),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: drawerSpacing,
              ),
              IconButton(
                onPressed: () {
                  CustomeBottomSheet().underDevelopment(context);
                },
                icon: Row(
                  children: [
                    Icon(Icons.notifications_active, color: DarkTheme(isDark).textColorVarient, size: 26),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Notifications',
                      style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 17),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: drawerSpacing,
              ),
              IconButton(
                onPressed: () {
                  CustomeBottomSheet().underDevelopment(context);
                },
                icon: Row(
                  children: [
                    Icon(
                      Icons.attach_money_outlined,
                      color: DarkTheme(isDark).textColorVarient,
                      size: 26,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Currency',
                      style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 17),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: drawerSpacing,
              ),
              Divider(
                color: DarkTheme(isDark).backgroundColour,
              ),
              SizedBox(
                height: drawerSpacing,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0, left: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.shield,
                          color: DarkTheme(isDark).textColor,
                          size: 26,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Private',
                          style: TextStyle(color: DarkTheme(isDark).textColor, fontSize: 17),
                        ),
                      ],
                    ),
                    FlutterSwitch(
                      height: 30,
                      activeColor: DarkTheme(isDark).backgroundColour,
                      inactiveColor: DarkTheme(isDark).backgroundColour,
                      // activeIcon: Icon(
                      //   Icons.visibility_off,
                      //   color: DarkTheme(isDark).backgroundColour,
                      // ),
                      // inactiveIcon: Icon(
                      //   Icons.visibility,
                      //   color: DarkTheme(isDark).backgroundColour,
                      // ),
                      toggleColor: DarkTheme(isDark).backColour,
                      duration: Duration(milliseconds: 400),
                      valueFontSize: 15,
                      toggleSize: 30,
                      activeTextColor: DarkTheme(isDark).textColorVarient,
                      inactiveTextColor: DarkTheme(isDark).textColorVarient,
                      activeText: 'On',
                      inactiveText: 'Off',
                      value: isPrivate,
                      borderRadius: 30,
                      // padding: 8,
                      showOnOff: true,

                      onToggle: (val) {
                        setState(() => isPrivate = !isPrivate);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: drawerSpacing,
              ),
              IconButton(
                onPressed: () {
                  CustomeBottomSheet().underDevelopment(context);
                },
                icon: Row(
                  children: [
                    Icon(
                      Icons.file_download_outlined,
                      color: DarkTheme(isDark).textColorVarient,
                      size: 26,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Import',
                      style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 17),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: drawerSpacing,
              ),
              IconButton(
                onPressed: () {
                  CustomeBottomSheet().underDevelopment(context);
                },
                icon: Row(
                  children: [
                    Icon(
                      Icons.file_upload_outlined,
                      color: DarkTheme(isDark).textColorVarient,
                      size: 26,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Export',
                      style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 17),
                    )
                  ],
                ),
              ),
        ],
      )
      
    );
  }
}

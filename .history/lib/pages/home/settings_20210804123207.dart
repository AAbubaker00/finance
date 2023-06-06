import 'dart:convert';

import 'package:Strice/models/user/user.dart';
import 'package:Strice/services/Login/authentication.dart';
import 'package:Strice/services/Network/network.dart';
import 'package:Strice/services/version/version.dart';
import 'package:Strice/shared/Custome_Widgets/botomSheet/custome_Bottom_Sheet.dart';
import 'package:Strice/shared/files/fileHandling.dart';
import 'package:Strice/shared/update/update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextStyle setOptionStyle, headerStyle;

  double ratio, prefixIconSize = 20, arrowIconSize = 15, spacing = 15;

  bool isDark = true, isOnline = false;

  Future getVersion() async {
    version = await Version().getPackageInfor();
    setState(() {});
  }

  Map data = {}, selectedCurrency;

  String currency = 'USD', version = '';
  final url = 'https://play.google.com/store/apps/details?id=com.minist.strice';

  @override
  void initState() {
    super.initState();
    selectedCurrency =
        Update('').currencySymbols.firstWhere((element) => element['short'] == currency, orElse: () => null);

    getConnection();
    getVersion();
  }

  getConnection() async {
    if (FirebaseAuth.instance.currentUser != null) {
      isOnline =
          FirebaseAuth.instance.currentUser.isAnonymous ? false : await Network('').getConnectionStatus();
    } else {
      isOnline = false;
    }

    setState(() {});
  }

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = (Provider.of<UserData>(context));
    data = ModalRoute.of(context).settings.arguments;

    void _passwordReset() {
      showModalBottomSheet(
          // barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Ink(
                    decoration: BoxDecoration(
                      color: DarkTheme(isDark).summaryColour,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(25.0),
                            child: Text(
                              'Password reset Link sent to ${user.email}. ',
                              style: TextStyle(fontSize: 20, color: DarkTheme(isDark).textColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
    }

    void _showConfirmPanel() {
      showModalBottomSheet(
          // barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return _confirmPanel();
          });
    }

    // _width = MediaQuery.of(context).size.width;

    print(data.forEach((key, value) = print(key)));

    // isDark = data['states']['dark'];

    setOptionStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: DarkTheme(isDark).textColor,
    );
    headerStyle =
        TextStyle(fontSize: 18, color: DarkTheme(isDark).textColorVarient, fontWeight: FontWeight.w400);

    return Container(
      color: DarkTheme(isDark).backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight * 0.8),
            child: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(
                color: DarkTheme(isDark).backColour, //change your color here
              ),
              backgroundColor: DarkTheme(isDark).backgroundColour,
              title:
                  Text('Settings', style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 18)),
              centerTitle: true,
              actions: [
                InkWell(
                  onTap: () {
                    _showConfirmPanel();
                  },
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/icons/logout.png',
                      color: DarkTheme(isDark).redVarient,
                      // height: _height * 0.1,
                      // width: _width * 0.1,
                      fit: BoxFit.scaleDown,
                      scale: 25,
                    ),
                  ),
                )
              ],
            ),
          ),
          body: Ink(
            // color: DarkTheme(isDark).summaryColour,
            child: ListView(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: DarkTheme(isDark).border),
                    color: DarkTheme(isDark).insideColour,
                    // borderRadius: BorderRadius.circular(spacing)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'ACCOUNT',
                          style: headerStyle,
                        ),
                      ),
                      InkWell(
                        splashColor: DarkTheme(isDark).reponseColour,
                        highlightColor: DarkTheme(isDark).reponseColour,
                        focusColor: DarkTheme(isDark).reponseColour,
                        hoverColor: DarkTheme(isDark).reponseColour,
                        onTap: () => Navigator.pushNamed(context, "/profile", arguments: data)
                            .then((value) => setState(() {})),
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_circle,
                              color: DarkTheme(isDark).iconColour,
                              size: prefixIconSize,
                            ),
                            Expanded(
                              child: Ink(
                                padding: EdgeInsets.only(top: spacing, bottom: spacing, left: 20, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Account Details',
                                      style: setOptionStyle,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: DarkTheme(isDark).iconColour.withOpacity(.5),
                                      size: arrowIconSize,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        splashColor: DarkTheme(isDark).reponseColour,
                        highlightColor: DarkTheme(isDark).reponseColour,
                        focusColor: DarkTheme(isDark).reponseColour,
                        hoverColor: DarkTheme(isDark).reponseColour,
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.attach_money_rounded,
                              color: DarkTheme(isDark).iconColour,
                              size: prefixIconSize,
                            ),
                            Expanded(
                              child: Ink(
                                padding: EdgeInsets.only(top: spacing, bottom: spacing, left: 20, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Base Currency',
                                        style: setOptionStyle.copyWith(color: DarkTheme(isDark).textColor)),

                                    Text(
                                      currency,
                                      style: TextStyle(
                                          color: DarkTheme(isDark).textColor, fontWeight: FontWeight.w400),
                                    )
                                    // Align(
                                    //   alignment: Alignment.center,
                                    //   child: DropdownButton<Map>(
                                    //     dropdownColor: DarkTheme(isDark).insideColour,
                                    //     // icon: Text(
                                    //     //   currency,
                                    //     //   style: TextStyle(
                                    //     //       fontSize: prefixIconSize, color: DarkTheme(isDark).textColor, fontWeight: FontWeight.w400),
                                    //     // ),
                                    //     autofocus: true,
                                    //     icon: Text(currency),
                                    //     underline: Container(
                                    //       color: Colors.transparent,
                                    //     ),
                                    //     onTap: (){},
                                    //     onChanged: (Map option) {
                                    //       setState(() {
                                    //         selectedCurrency = option;
                                    //         currency = selectedCurrency['short'];
                                    //       });
                                    //     },

                                    //     isDense: true,
                                    //     items: Update('').currencySymbols.map<DropdownMenuItem<Map>>((option) {
                                    //       return DropdownMenuItem<Map>(
                                    //         value: option,
                                    //         onTap: () {
                                    //           setState(() {
                                    //             selectedCurrency = option;
                                    //             currency = selectedCurrency['short'];

                                    //             // isSortLoaded = false;
                                    //           });
                                    //         },
                                    //         child: Text(
                                    //           '${option['short']} - ${option['name']} (${option['symbol']})',
                                    //           style: TextStyle(
                                    //               color: selectedCurrency['short'] == option['short']
                                    //                   ? DarkTheme(isDark).goldVarient
                                    //                   : DarkTheme(isDark).textColor),
                                    //         ),
                                    //       );
                                    //     }).toList(),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        splashColor: DarkTheme(isDark).reponseColour,
                        highlightColor: DarkTheme(isDark).reponseColour,
                        focusColor: DarkTheme(isDark).reponseColour,
                        hoverColor: DarkTheme(isDark).reponseColour,
                        onTap: () async {
                          if (!_auth.currentUser.isAnonymous) {
                            await AuthService().passwordReset(email: user.email);
                            _passwordReset();
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.vpn_key_rounded,
                              color: DarkTheme(isDark).iconColour,
                              size: prefixIconSize,
                            ),
                            Expanded(
                              child: Ink(
                                padding: EdgeInsets.only(top: spacing, bottom: spacing, left: 20, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Password reset',
                                      style: setOptionStyle.copyWith(
                                          color: (_auth.currentUser == null
                                                  ? false
                                                  : _auth.currentUser.isAnonymous)
                                              ? DarkTheme(isDark).textColorVarient
                                              : DarkTheme(isDark).textColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        splashColor: DarkTheme(isDark).reponseColour,
                        highlightColor: DarkTheme(isDark).reponseColour,
                        focusColor: DarkTheme(isDark).reponseColour,
                        hoverColor: DarkTheme(isDark).reponseColour,
                        onTap: () async {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.cloud,
                              color: DarkTheme(isDark).iconColour,
                              size: prefixIconSize,
                            ),
                            Expanded(
                              child: Ink(
                                padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: DarkTheme(isDark).border,
                                ))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Sync to Cloude',
                                      style: setOptionStyle.copyWith(color: DarkTheme(isDark).textColor),
                                    ),
                                    Icon(
                                      Icons.circle,
                                      color: isOnline
                                          ? DarkTheme(isDark).greenVarient
                                          : DarkTheme(isDark).redVarient,
                                      size: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: DarkTheme(isDark).border),
                      color: DarkTheme(isDark).insideColour,
                      // borderRadius: BorderRadius.circular(spacing)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            'FEATURES',
                            style: headerStyle,
                          ),
                        ),
                        InkWell(
                          splashColor: DarkTheme(isDark).reponseColour,
                          highlightColor: DarkTheme(isDark).reponseColour,
                          focusColor: DarkTheme(isDark).reponseColour,
                          hoverColor: DarkTheme(isDark).reponseColour,
                          onTap: () {
                            CustomeBottomSheet().underDevelopment(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.notifications,
                                color: DarkTheme(isDark).iconColour.withOpacity(.5),
                                size: prefixIconSize,
                              ),
                              Expanded(
                                child: Ink(
                                  padding:
                                      EdgeInsets.only(top: spacing, bottom: spacing, left: 20, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Push Notifications',
                                        style: setOptionStyle.copyWith(
                                            color: DarkTheme(isDark).textColorVarient),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: DarkTheme(isDark).iconColour.withOpacity(.3),
                                        size: arrowIconSize,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          splashColor: DarkTheme(isDark).reponseColour,
                          highlightColor: DarkTheme(isDark).reponseColour,
                          focusColor: DarkTheme(isDark).reponseColour,
                          hoverColor: DarkTheme(isDark).reponseColour,
                          onTap: () {
                            CustomeBottomSheet().underDevelopment(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.timelapse_rounded,
                                color: DarkTheme(isDark).iconColour.withOpacity(.5),
                                size: prefixIconSize,
                              ),
                              Expanded(
                                child: Ink(
                                  padding:
                                      EdgeInsets.only(top: spacing, bottom: spacing, left: 20, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Prices Update Frequency',
                                        style: setOptionStyle.copyWith(
                                            color: DarkTheme(isDark).textColorVarient),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: DarkTheme(isDark).iconColour.withOpacity(.3),
                                        size: arrowIconSize,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          splashColor: DarkTheme(isDark).reponseColour,
                          highlightColor: DarkTheme(isDark).reponseColour,
                          focusColor: DarkTheme(isDark).reponseColour,
                          hoverColor: DarkTheme(isDark).reponseColour,
                          onTap: () {
                            CustomeBottomSheet().underDevelopment(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.upload_file,
                                color: DarkTheme(isDark).iconColour.withOpacity(.5),
                                size: prefixIconSize,
                              ),
                              Expanded(
                                child: Ink(
                                  padding:
                                      EdgeInsets.only(top: spacing, bottom: spacing, left: 20, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Import',
                                        style: setOptionStyle.copyWith(
                                            color: DarkTheme(isDark).textColorVarient),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: DarkTheme(isDark).iconColour.withOpacity(.3),
                                        size: arrowIconSize,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          splashColor: DarkTheme(isDark).reponseColour,
                          highlightColor: DarkTheme(isDark).reponseColour,
                          focusColor: DarkTheme(isDark).reponseColour,
                          hoverColor: DarkTheme(isDark).reponseColour,
                          onTap: () {
                            CustomeBottomSheet().underDevelopment(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.file_download,
                                color: DarkTheme(isDark).iconColour.withOpacity(.5),
                                size: prefixIconSize,
                              ),
                              Expanded(
                                child: Ink(
                                  padding:
                                      EdgeInsets.only(top: spacing, bottom: spacing, left: 20, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Export',
                                        style: setOptionStyle.copyWith(
                                            color: DarkTheme(isDark).textColorVarient),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: DarkTheme(isDark).iconColour.withOpacity(.3),
                                        size: arrowIconSize,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.color_lens_outlined,
                              color: DarkTheme(isDark).iconColour,
                              size: prefixIconSize,
                            ),
                            Expanded(
                              child: Ink(
                                padding: EdgeInsets.only(top: spacing, bottom: spacing, left: 20, right: 5),
                                child: InkWell(
                                  onTap: () {
                                    // setState(() {
                                    //   data['states']['states']['dark'] = !data['states']['states']['dark'];

                                    //   LocalDataSet().writeStates(json.encode(data['states']));
                                    // });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Theme',
                                        style: setOptionStyle,
                                      ),
                                      Text(
                                        'Dark',
                                        style: setOptionStyle.copyWith(color: DarkTheme(isDark).textColor),
                                      ),
                                      FlutterSwitch(
                                        width: 90,
                                        height: 35,
                                        activeColor: DarkTheme(isDark).backgroundColour,
                                        inactiveColor: DarkTheme(isDark).backgroundColour,
                                        activeIcon: Icon(
                                          Icons.nightlight_round,
                                          color: DarkTheme(isDark).backgroundColour,
                                        ),
                                        inactiveIcon: Icon(
                                          Icons.wb_sunny_rounded,
                                          color: DarkTheme(isDark).backgroundColour,
                                        ),
                                        toggleColor: DarkTheme(isDark).backColour,
                                        duration: Duration(milliseconds: 400),
                                        valueFontSize: arrowIconSize,
                                        toggleSize: 30,
                                        activeTextColor: DarkTheme(isDark).textColorVarient,
                                        inactiveTextColor: DarkTheme(isDark).textColorVarient,
                                        activeText: 'Dark',
                                        inactiveText: 'Light',
                                        value: data['states']['dark'],
                                        borderRadius: 30,
                                        // padding: 8,
                                        showOnOff: true,

                                        onToggle: (val) {
                                          setState(() {
                                            data['states']['dark'] = val;

                                            LocalDataSet().writeStates(json.encode(data['states']));
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: DarkTheme(isDark).border),
                    color: DarkTheme(isDark).insideColour,
                    // borderRadius: BorderRadius.circular(spacing)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'About',
                          style: headerStyle,
                        ),
                      ),
                      InkWell(
                        splashColor: DarkTheme(isDark).reponseColour,
                        highlightColor: DarkTheme(isDark).reponseColour,
                        focusColor: DarkTheme(isDark).reponseColour,
                        hoverColor: DarkTheme(isDark).reponseColour,
                        onTap: () async {
                          if (await canLaunch(url))
                            await launch(url);
                          else
                            throw "Could not launch $url";
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: DarkTheme(isDark).iconColour,
                              size: prefixIconSize,
                            ),
                            Expanded(
                              child: Ink(
                                padding: EdgeInsets.only(top: spacing, bottom: spacing, left: 20, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Review App',
                                        style: setOptionStyle.copyWith(
                                          color: DarkTheme(isDark).textColor,
                                        )),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: DarkTheme(isDark).iconColour.withOpacity(.3),
                                      size: arrowIconSize,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        splashColor: DarkTheme(isDark).reponseColour,
                        highlightColor: DarkTheme(isDark).reponseColour,
                        focusColor: DarkTheme(isDark).reponseColour,
                        hoverColor: DarkTheme(isDark).reponseColour,
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/feedback', arguments: data);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.feedback,
                              color: DarkTheme(isDark).iconColour,
                              size: prefixIconSize,
                            ),
                            Expanded(
                              child: Ink(
                                padding: EdgeInsets.only(top: spacing, bottom: spacing, left: 20, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Give Feedback',
                                        style: setOptionStyle.copyWith(
                                          color: DarkTheme(isDark).textColor,
                                        )),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: DarkTheme(isDark).iconColour.withOpacity(.3),
                                      size: arrowIconSize,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        splashColor: DarkTheme(isDark).reponseColour,
                        highlightColor: DarkTheme(isDark).reponseColour,
                        focusColor: DarkTheme(isDark).reponseColour,
                        hoverColor: DarkTheme(isDark).reponseColour,
                        onTap: () {
                          Navigator.pushNamed(context, '/terms');
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.my_library_books_outlined,
                              color: DarkTheme(isDark).iconColour,
                              size: prefixIconSize,
                            ),
                            Expanded(
                              child: Ink(
                                padding: EdgeInsets.only(top: spacing, bottom: spacing, left: 20, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Terms of Use',
                                      style: setOptionStyle,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: DarkTheme(isDark).iconColour.withOpacity(.3),
                                      size: arrowIconSize,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        splashColor: DarkTheme(isDark).reponseColour,
                        highlightColor: DarkTheme(isDark).reponseColour,
                        focusColor: DarkTheme(isDark).reponseColour,
                        hoverColor: DarkTheme(isDark).reponseColour,
                        onTap: () {
                          Navigator.pushNamed(context, '/privacy');
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.shield,
                              color: DarkTheme(isDark).iconColour,
                              size: prefixIconSize,
                            ),
                            Expanded(
                              child: Ink(
                                padding: EdgeInsets.only(top: spacing, bottom: spacing, left: 20, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Privacy Notice',
                                      style: setOptionStyle,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: DarkTheme(isDark).iconColour.withOpacity(.3),
                                      size: arrowIconSize,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Ink(
                        child: Row(
                          children: [
                            Icon(
                              Icons.code,
                              color: DarkTheme(isDark).iconColour,
                              size: prefixIconSize,
                            ),
                            Expanded(
                              child: Ink(
                                padding: EdgeInsets.only(top: spacing, bottom: spacing, left: 20, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Version',
                                      style: setOptionStyle,
                                    ),
                                    Text(
                                      version,
                                      style: TextStyle(color: DarkTheme(isDark).textColor, fontSize: 17),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _confirmPanel() {
    if (!mounted) return;

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ink(
            decoration: BoxDecoration(
              color: DarkTheme(isDark).summaryColour,
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () async {
                User _u = FirebaseAuth.instance.currentUser;

                print(_u.providerData);

                try {
                  if (_u.providerData.isNotEmpty && _u.providerData[0].providerId == 'google.com') {
                    await AuthService().googleLogout();

                    await LocalDataSet().writePortfolios('');
                    await LocalDataSet().writeStates('');

                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);

                    // if (result == null) {
                    //   await LocalDataSet().writePortfolios('');
                    //   await LocalDataSet().writeStates('');

                    //   Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    // } else {
                    //   await LocalDataSet().writePortfolios('');
                    //   await LocalDataSet().writeStates('');

                    //   Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    // }
                  } else {
                    await AuthService().signOut();

                    await LocalDataSet().writePortfolios('');
                    await LocalDataSet().writeStates('');

                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);

                    // if (result == null) {
                    //   print('error');

                    //   await LocalDataSet().writePortfolios('');
                    //   await LocalDataSet().writeStates('');

                    //   Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    // } else {
                    //   await LocalDataSet().writePortfolios('');
                    //   await LocalDataSet().writeStates('');

                    //   Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    // }
                  }
                } catch (e) {
                  print('===========ERROR==================');
                  print(e.toString());
                  print('===========ERROR==================');
                }

                Future.delayed(Duration(seconds: 1), () {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      'Confirm',
                      style: TextStyle(fontSize: 20, color: DarkTheme(isDark).greenVarient),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Ink(
            decoration: BoxDecoration(
              color: DarkTheme(isDark).summaryColour,
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 20, color: DarkTheme(isDark).textColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

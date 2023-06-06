import 'package:valuid/pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:valuid/models/user/user.dart';
import 'package:valuid/services/Login/authentication.dart';
import 'package:valuid/services/marketbeat/marketbeat.dart';
import 'package:valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'shared/permissions/getPermissions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  GetPermissions().getStoragePermission();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xFFFDFDFD),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // LocalDataSet().deleteLocalData();
          // LocalDataSet().writeStates('');
          // AuthService().signOut();
          // AuthService().googleLogout();

          Marketbeat().getQuote({'symbol': 'lloy.l'});

          return StreamProvider<UserObject>.value(
              value: AuthService().user,
              initialData: null,
              child: MaterialApp(
                builder: (context, child) {
                  return ScrollConfiguration(
                    // ignore: deprecated_member_use
                    behavior: new ScrollBehavior()
                      ..buildOverscrollIndicator(context, null,
                          ScrollableDetails(direction: AxisDirection.down, controller: ScrollController())),
                    child: child,
                  );
                },
                theme: ThemeData(
                    // bottomNavigationBarTheme: BottomNavigationBarThemeData(),
                    bottomSheetTheme: BottomSheetThemeData(
                  modalBackgroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                )),
                debugShowCheckedModeBanner: false,
                home: Text('sd'),
              ));
        } else {
          return MaterialApp(
              theme: ThemeData(
                  bottomSheetTheme: BottomSheetThemeData(
                modalBackgroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
              )),
              debugShowCheckedModeBanner: false,
              home: Loading());
        }
      },
    );
  }
}

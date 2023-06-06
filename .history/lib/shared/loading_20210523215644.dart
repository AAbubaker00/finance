import 'dart:convert';

import 'package:Strice/shared/fileHandling.dart';
import 'package:Strice/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  Loading(this.isDark);

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DarkTheme(isDark).backgroundColour,
      child: SpinKitCircle(
        size: 50,
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: DarkTheme(isDark).textColorVarient.withOpacity(.5),
            ),
          );
        },
      ),
    );
  }
}

class MainLoading extends StatefulWidget {
  @override
  _MainLoadingState createState() => _MainLoadingState();
}

class _MainLoadingState extends State<MainLoading> {
  @override
  void initState() {
    super.initState();

    // var brightness = SchedulerBinding.instance.window.platformBrightness;
    // isDark = brightness == Brightness.dark;
    //
  }

  var pixelRatio;

  @override
  void dispose() {
    super.dispose();
  }

  bool isDark = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      color: DarkTheme(isDark).goldVarient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Center(
            child: SpinKitCircle(
              size: 50,
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: DarkTheme(isDark).backColour.withOpacity(.5),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

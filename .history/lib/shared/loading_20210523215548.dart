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
  double y;
  double x;

  setDimensions() {
    setState(() {
      y = 335 / pixelRatio;
      x = 250 / pixelRatio;
    });
  }

  @override
  Widget build(BuildContext context) {
    pixelRatio = MediaQuery.of(context).devicePixelRatio; // 2
    setDimensions();

    return Container(
      color: DarkTheme(isDark).goldVarient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Stack(
            children: [
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
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
            ],
          ),
        ),
      ),
    );
  }
}

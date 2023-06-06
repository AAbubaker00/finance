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

class MainLoading extends StatelessWidget {
  void initState() { 
    print('aaaaaaaaaaaaaaa')
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF2E303C),
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
                    color: Color(0xFFDFE8FE).withOpacity(.5),
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

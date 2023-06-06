import 'package:flutter/material.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';

class EventContainer extends StatelessWidget {
  const EventContainer({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
       decoration: BoxDecoration(
              // border: Border.all(color: seperator.withOpacity(.7), width: .7),
              borderRadius: BorderRadius.circular(circularRadius),
              color: summaryColour),
      child: child,
    );
  }
}

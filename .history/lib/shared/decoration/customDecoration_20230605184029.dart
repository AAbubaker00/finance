import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';

class CustomDecoration {
  late final bool appbarBottomBorderColour;
  final int appBarColourOption;
  final bool isBlur;

  

  CustomDecoration({this.isBlur = false, required this.appBarColourOption, this.appbarBottomBorderColour = true}) {
   

    calenderDecoration = BoxDecoration(
      color: summaryColour,
      borderRadius: BorderRadius.circular(circularRadius),
      // border: Border.symmetric(horizontal: BorderSide(color: seperator, width: 1)));
    );

    curvedContainerDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(circularRadius),
        // border: Border.all(color: seperator.withOpacity(.7), width: 1),
        color: backgroundColour);

    curvedBaseContainerDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(circularRadius),
        // border: Border.all(color: seperator, width: 1),
        color: summaryColour);

    topWidgetDecoration = BoxDecoration(
        boxShadow: isBlur
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]
            : [],
        border: Border(bottom: BorderSide(width: .7, color: seperator.withOpacity(.7))),
        color: summaryColour);

    bottomWidgetDecoration = BoxDecoration(
        border: Border(top: BorderSide(width: .7, color: seperator.withOpacity(.7))), color: summaryColour);

    bottomsheetDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(circularRadius),
        border: Border.all(color: seperator, width: 1),
        color: summaryColour);

    appBarContainerDecoration = BoxDecoration(
        color: appBarColourOption == 1 ? summaryColour : backgroundColour,
        // boxShadow: isBlur
        //     ? [
        //         BoxShadow(
        //             color: (theme) ? Colors.black.withOpacity(.4) : Colors.green.withOpacity(0.05),
        //             blurRadius: 15,

        //             offset: Offset(0.0, 50.0) //hanges position of shadow
        //             ),
        //       ]
        //     : [],
        border: Border(
            bottom: BorderSide(
                color: appbarBottomBorderColour ? seperator.withOpacity(.7) : Colors.transparent,
                width: .7)));

    deletionBtnDecoration = BoxDecoration(
        border: Border.all(color: redVarient.withOpacity(.1)),
        color: redVarient.withOpacity(.02),
        borderRadius: BorderRadius.circular(circularRadius));
  }

  BoxDecoration baseContainerDecoration;
  BoxDecoration appBarContainerDecoration;
  BoxDecoration deletionBtnDecoration;
  BoxDecoration curvedContainerDecoration;
  BoxDecoration curvedBaseContainerDecoration;
  BoxDecoration bottomsheetDecoration;
  BoxDecoration calenderDecoration;
  BoxDecoration topWidgetDecoration;
  BoxDecoration bottomWidgetDecoration;
}

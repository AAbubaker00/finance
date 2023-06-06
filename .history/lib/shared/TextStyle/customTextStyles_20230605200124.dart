import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyles {
  TextStyle sectionHeader,
      portfolioNameStyle,
      feedDateStyle,
      holdingValueStyle,
      pageHeaderStyle,
      overallValueStyle,
      overallCurrencyStyle,
      tableHeaderStyle,
      holdingSubValueStyle,
      deleteBtnTextStyle,
      calenderTitleTextStyle,
      calenderDateTextStyle,
      appBarTitleStyle,
      disclaimerTextStyle,
      seeAllTextStyle,
      deleteTextStyle;

  bool isChange;
  int adjust;
  num? value;

  CustomTextStyles(BuildContext context, {this.isChange = false, this.value}) {
    adjust = ((MediaQuery.of(context).size.height *
            (MediaQuery.of(context).size.height > 732 ? largerScreenMultiplier : smallerScreenMultiplier)) -
        (732 *
            (MediaQuery.of(context).size.height > 732 ? largerScreenMultiplier : smallerScreenMultiplier)));

////////////////////////////////////////////////////!
    calenderDateTextStyle = GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 30 - adjust,
      fontWeight: FontWeight.w600,
      color: textColor,
    ));

    deleteBtnTextStyle = GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 30 - adjust, fontWeight: FontWeight.w400, color: redVarient.withOpacity(.45)));

    overallCurrencyStyle = GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 30 - 1.5 * adjust,
      fontWeight: FontWeight.w500,
      color: textColor,
    ));
////////////////////////////////////////////////////!

    calenderTitleTextStyle = GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 27 - adjust,
      letterSpacing: .8,
      fontWeight: FontWeight.w400,
      color: textColor,
    ));

////////////////////////////////////////////////////!

    feedDateStyle = GoogleFonts.lato(
        textStyle: TextStyle(
      color: textColorVarient,
      fontWeight: FontWeight.w500,
      fontSize: 18 - adjust,
    ));

    tableHeaderStyle = GoogleFonts.lato(
        textStyle: TextStyle(
            color: textColorVarient, fontWeight: FontWeight.w500, fontSize: 14 - adjust, letterSpacing: .2));

////////////////////////////////////////////////////!

    holdingSubValueStyle = GoogleFonts.lato(
        textStyle: TextStyle(
            color: textColorVarient, fontWeight: FontWeight.w600, fontSize: 17 - adjust, letterSpacing: .2));

////////////////////////////////////////////////////!

    disclaimerTextStyle = GoogleFonts.lato(
        textStyle: TextStyle(
      color: textColorVarient,
      fontWeight: FontWeight.w500,
      fontSize: 12 - adjust,
    ));

////////////////////////////////////////////////////!

    deleteTextStyle = GoogleFonts.lato(
        textStyle: TextStyle(
      color: isChange ? blueVarient : navIconColour,
      fontWeight: FontWeight.w700,
      letterSpacing: .3,
      fontSize: 14 - adjust,
    ));

////////////////////////////////////////////////////!

    appBarTitleStyle = GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 21 - adjust,
      letterSpacing: .7,
      fontWeight: FontWeight.w500,
      color: textColor,
    ));

////////////////////////////////////////////////////!

    overallValueStyle = GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 50 - 1.5 * adjust,
      fontWeight: FontWeight.w400,
      color: textColor,
    ));

////////////////////////////////////////////////////!

    seeAllTextStyle = GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 22 - adjust,
      fontWeight: FontWeight.w400,
      color: textColor,
    ));

    holdingValueStyle = GoogleFonts.lato(
        textStyle: TextStyle(
      letterSpacing: .3,
      fontSize: 20 - adjust,
      fontWeight: FontWeight.w700,
      color: textColor,
    ));

////////////////////////////////////////////////////!

    portfolioNameStyle = GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: (value == null ? 19 : value) - adjust,
      letterSpacing: .2,
      fontWeight: FontWeight.w500,
      color: textColor,
    ));

////////////////////////////////////////////////////!

    sectionHeader = GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 25 - adjust,
      letterSpacing: .2,
      fontWeight: FontWeight.w500,
      color: textColor,
    ));

    pageHeaderStyle = GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 27 - adjust,
      fontWeight: FontWeight.w500,
      color: textColor,
    ));

////////////////////////////////////////////////////!
  }
}

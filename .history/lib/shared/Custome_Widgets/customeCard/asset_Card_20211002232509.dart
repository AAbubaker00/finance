import 'package:Strice/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Strice/extensions/stringExt.dart' as str;

class CustomeAssetCard extends StatelessWidget {
  final Function editHoldingFunction;
  final Function viewHoldingFunction;
  final dynamic stock;
  final double ratio;
  final bool isPrivate;
  final String currencySymbol;
  final String baseCurrency;
  final isDark;
  final int index;
  final bool isLast;

  CustomeAssetCard(this.editHoldingFunction, this.stock, this.ratio, this.isPrivate, this.currencySymbol,
      this.baseCurrency, this.isDark, this.index, this.isLast, this.viewHoldingFunction);

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    final TextStyle headerStyle =
        TextStyle(color: DarkTheme(isDark).textColorVarient, fontWeight: FontWeight.w400);
    final TextStyle sectionHeaderStyle = TextStyle(
      color: DarkTheme(isDark).textColorVarient,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );

    return InkWell(
      onLongPress: () {
        editHoldingFunction(stock);
      },
      onTap: () => Navigator.pushNamed(context, '/holding'),//viewHoldingFunction(stock),
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: );
  }
}

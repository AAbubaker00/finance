import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomInputDecoration extends {
  final String labelText;
  final BuildContext context;

  CustomInputDecoration(this.labelText, this.context);

  getMainInputDecoration() =>
      InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(
        left: 10,
      ),
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      hintStyle: CustomTextStyles(context)
          .portfolioNameStyle
          .copyWith(color: textColorVarient, fontWeight: FontWeight.w400),
      isDense: true,
      hintText: labelText,
    );
  
}

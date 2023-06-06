import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomInputDecoration extends InputDecoration {
  final String text;
  final BuildContext context;

  var contentPadding;
  var hintStyle;
  var errorBorder;
  var enabledBorder;
  var disabledBorder;
  var border;
  var isDense;
  var hintText;
  var floatingLabelBehavior;
  var isCollapsed;
  var label;
  var labelText;

  CustomInputDecoration(this.text, this.context)
      : this.contentPadding = EdgeInsets.only(left: 10),
        this.hintStyle = CustomTextStyles(context).portfolioNameStyle.copyWith(color: textColorVarient),
        this.errorBorder = InputBorder.none,
        this.enabledBorder = InputBorder.none,
        this.disabledBorder = InputBorder.none,
        this.border = InputBorder.none,
        this.isDense = true,
        this.hintText = text,
        this.isCollapsed = true,
        this.floatingLabelBehavior = FloatingLabelBehavior.never;
}

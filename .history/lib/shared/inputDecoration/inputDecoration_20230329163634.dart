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
  var prefixIcon;
  var fillColor;
  var filled;
  var prefixIconConstraints;

  CustomInputDecoration(this.text, this.context, {this.prefixIcon})
      : this.contentPadding = EdgeInsets.only(left: 15, top: 15, bottom: 15),
        this.hintStyle = CustomTextStyles(context).portfolioNameStyle.copyWith(color: textColorVarient),
        this.errorBorder = OutlineInputBorder(
          borderSide: new BorderSide(color: redVarient),
          borderRadius: new BorderRadius.circular(50),
        ),
        this.enabledBorder = OutlineInputBorder(
          borderSide: new BorderSide(color: backgroundColour),
          borderRadius: new BorderRadius.circular(50),
        ),
        this.disabledBorder = InputBorder.none,
        this.border = OutlineInputBorder(
          borderSide: new BorderSide(color: backgroundColour),
          borderRadius: new BorderRadius.circular(50),
        ),
        this.prefixIconConstraints = BoxConstraints(minHeight: 27, minWidth: 27,maxHeight: 45, maxWidth: 45),
        this.isDense = false,
        this.hintText = text,
        this.isCollapsed = true,
        this.filled = true,
        this.fillColor = backgroundColour,
        this.floatingLabelBehavior = FloatingLabelBehavior.never;
}

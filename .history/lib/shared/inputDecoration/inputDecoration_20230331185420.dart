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
  double radius;

  CustomInputDecoration(this.text, this.context,
      {this.prefixIcon,
      this.contentPadding = const EdgeInsets.only(left: 15, top: 15, bottom: 15),
      this.radius = 50})
      : this.hintStyle = CustomTextStyles(context).portfolioNameStyle,
        this.errorBorder = OutlineInputBorder(
          borderSide: new BorderSide(color: redVarient),
          borderRadius: new BorderRadius.circular(radius),
        ),
        this.enabledBorder = OutlineInputBorder(
          borderSide: new BorderSide(color: backgroundColour.withOpacity(.7), width: .7),
          borderRadius: new BorderRadius.circular(radius),
        ),
        this.disabledBorder = InputBorder.none,
        this.border = OutlineInputBorder(
          borderSide: new BorderSide(color: seperator),
          borderRadius: new BorderRadius.circular(radius),
        ),
        this.prefixIconConstraints = BoxConstraints(minHeight: 27, minWidth: 27, maxHeight: 45, maxWidth: 45),
        this.isDense = false,
        this.hintText = text,
        this.isCollapsed = true,
        this.filled = true,
        this.fillColor = backgroundColour,
        this.floatingLabelBehavior = FloatingLabelBehavior.never;
}

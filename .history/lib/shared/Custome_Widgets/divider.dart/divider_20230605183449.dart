import 'package:valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final Color color;
  final double thickness;
  final double height;

  const CustomDivider({Key? key, required this.color, this.thickness = 0.65, this.height = 10}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: color == null ? seperator.withOpacity(.7) : color,
      thickness: thickness,
    );
  }
}
